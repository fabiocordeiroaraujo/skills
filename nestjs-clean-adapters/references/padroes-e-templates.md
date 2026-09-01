# Padroes e templates de adaptadores

## Repositorio Prisma

```ts
@Injectable()
export class PrismaCustomerRepository implements CustomerRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findByEmail(email: string): Promise<Customer | null> {
    const record = await this.prisma.customer.findUnique({ where: { email } });
    return record ? CustomerMapper.toDomain(record) : null;
  }

  async save(customer: Customer): Promise<Customer> {
    const record = await this.prisma.customer.create({
      data: CustomerMapper.toPersistence(customer),
    });
    return CustomerMapper.toDomain(record);
  }
}
```

`@Injectable` e adequado aqui: o adaptador pertence a camada externa e pode usar o container Nest.

## Mapper

```ts
import type { Customer as CustomerRecord, Prisma } from '@prisma/client';

export class CustomerMapper {
  static toDomain(record: CustomerRecord): Customer {
    return Customer.restore({
      id: record.id,
      name: record.name,
      email: record.email,
      active: record.active,
      createdAt: record.created_at,
    });
  }

  static toPersistence(customer: Customer): Prisma.CustomerCreateInput {
    return {
      id: customer.id,
      name: customer.name,
      email: customer.email,
      active: customer.active,
      created_at: customer.createdAt,
      versao: 0,
    };
  }
}
```

O casing dos tipos segue o nome do `model` no schema (`model Customer` gera `Prisma.CustomerCreateInput`; schemas legados com model minusculo geram outro nome). Se `restore` nao existe, use o construtor/builder estabelecido no projeto. Nao burle invariantes sem uma API explicita de reidratacao.

## Lista paginada segura

```ts
const ORDER_BY = {
  name: 'name',
  createdAt: 'created_at',
} as const;

async findAll(filter: CustomerFilter): Promise<Page<Customer>> {
  const orderBy = ORDER_BY[filter.orderBy ?? 'name'];
  const where = {
    ...(filter.name && {
      name: { contains: filter.name, mode: 'insensitive' as const },
    }),
    ...(filter.active !== undefined && { active: filter.active }),
  };

  const [records, totalItems] = await this.prisma.$transaction([
    this.prisma.customer.findMany({
      where,
      skip: (filter.page - 1) * filter.pageSize,
      take: filter.pageSize,
      orderBy: { [orderBy]: filter.orderDirection ?? 'asc' },
    }),
    this.prisma.customer.count({ where }),
  ]);

  return {
    data: records.map(CustomerMapper.toDomain),
    totalItems,
    currentPage: filter.page,
    pageSize: filter.pageSize,
  };
}
```

Normalize limites de pagina na entrada ou caso de uso. Mapeie campos de ordenacao por allowlist.

## Traducao de erro

```ts
async save(customer: Customer): Promise<Customer> {
  try {
    // persistencia
  } catch (error) {
    if (isUniqueViolation(error, 'customer_email_key')) {
      throw new CustomerAlreadyExistsError(customer.email);
    }
    throw error;
  }
}
```

Somente traduza quando o erro tecnico identifica uma condicao estavel do dominio. Caso contrario, preserve a causa para observabilidade e tratamento global.

## Gateway de integracao

```ts
@Injectable()
export class CadastroGrpcRecipientGateway implements RecipientGateway {
  constructor(
    private readonly client: CadastroGrpcClient,
    private readonly config: ConfigService<AppConfig, true>,
  ) {}

  async findByCpf(cpf: Cpf): Promise<Recipient[]> {
    const response = await this.client.listRecipients(
      { cpf: cpf.value },
      { deadline: Date.now() + this.config.get('CADASTRO_TIMEOUT_MS', { infer: true }) },
    );
    return response.items.map(RecipientMapper.toDomain);
  }
}
```

O contrato `RecipientGateway` nao conhece gRPC, deadline ou protobuf.

## Unit of Work tipado e sem estado compartilhado

```ts
@Injectable()
export class PrismaBillingTransactionManager
  implements BillingTransactionManager
{
  constructor(private readonly prisma: PrismaService) {}

  execute<T>(
    work: (ports: BillingTransactionalPorts) => Promise<T>,
  ): Promise<T> {
    return this.prisma.$transaction(async (tx) => {
      const ports: BillingTransactionalPorts = {
        invoices: new PrismaInvoiceRepository(tx),
        outbox: new PrismaOutboxRepository(tx),
      };
      return work(ports);
    });
  }
}
```

As dependencias transacionais continuam explicitas e todos os repositorios usam o `tx` local. Nao grave o transaction client atual em campo de singleton. Para persistir um unico agregado em varias tabelas, uma transacao interna do repositorio pode ser suficiente e evita expor Unit of Work ao caso de uso.

## Estrategia de testes

| Componente | Tipo de teste | Verificacoes |
|---|---|---|
| mapper | unitario | todos os campos, nulls, enums, datas |
| repository | integracao | CRUD, filtros, paginacao, conflito, rollback |
| gateway | unitario com client fake | request, mapping, timeout, erro |
| UoW | integracao | mesma transacao, commit, rollback |

Evite mockar toda a API fluente do Prisma para provar queries complexas; um banco de teste oferece sinal melhor.
