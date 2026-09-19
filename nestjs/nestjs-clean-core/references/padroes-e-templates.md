# Padroes e templates do core

## Estrutura minima

```text
core/customer/
|-- contract/customer-repository.ts
|-- entity/customer.ts
|-- error/customer-errors.ts
`-- usecase/create-customer.ts
```

Adicione `dto/`, `service/` ou `vo/` apenas quando houver responsabilidade real.

## Porta com token runtime neutro

```ts
import { Customer } from '../entity/customer';

export interface CustomerRepository {
  findByEmail(email: string): Promise<Customer | null>;
  save(customer: Customer): Promise<Customer>;
}

export const CUSTOMER_REPOSITORY = Symbol('CUSTOMER_REPOSITORY');
```

O `Symbol` nao depende de NestJS. Ele existe porque a interface e apagada na compilacao e o composition root precisa de uma identidade runtime.

## Entidade com invariantes

```ts
export interface CustomerProps {
  id: string;
  name: string;
  email: string;
  active: boolean;
  createdAt: Date;
}

export class Customer {
  private constructor(private readonly props: CustomerProps) {}

  static create(props: CustomerProps): Customer {
    const name = props.name.trim();
    if (!name) throw new InvalidCustomerError('name');
    return new Customer({ ...props, name });
  }

  static restore(props: CustomerProps): Customer {
    return new Customer(props);
  }

  get id(): string { return this.props.id; }
  get name(): string { return this.props.name; }
  get email(): string { return this.props.email; }
  get active(): boolean { return this.props.active; }
  get createdAt(): Date { return this.props.createdAt; }
}
```

Se o projeto usa entidades anemicas por convencao, nao force uma migracao global durante uma feature. Ainda assim, mantenha a regra no core e teste-a.

## Caso de uso

```ts
export interface CreateCustomerInput {
  name: string;
  email: string;
}

export class CreateCustomer {
  constructor(
    private readonly repository: CustomerRepository,
    private readonly idGenerator: IdGenerator,
    private readonly clock: Clock,
  ) {}

  async execute(input: CreateCustomerInput): Promise<Customer> {
    const email = input.email.trim().toLowerCase();
    if (await this.repository.findByEmail(email)) {
      throw new CustomerAlreadyExistsError(email);
    }

    const customer = Customer.create({
      id: this.idGenerator.next(),
      name: input.name,
      email,
      active: true,
      createdAt: this.clock.now(),
    });

    return this.repository.save(customer);
  }
}
```

Use portas de ID/relogio quando testes deterministas, auditoria ou reprocessamento justificarem. Para CRUD simples alinhado ao legado, `crypto.randomUUID()` e `new Date()` podem ser suficientes.

## Erro independente de transporte

```ts
export class CustomerAlreadyExistsError extends Error {
  readonly code = 'CUSTOMER_ALREADY_EXISTS';

  constructor(readonly email: string) {
    super(`Customer already exists: ${email}`);
    this.name = CustomerAlreadyExistsError.name;
  }
}
```

Um filter HTTP pode mapear esse codigo para 409; um controller gRPC pode mapea-lo para `ALREADY_EXISTS`.

## Paginacao tipada

```ts
export interface CustomerFilter {
  name?: string;
  active?: boolean;
  page: number;
  pageSize: number;
  orderBy?: 'name' | 'createdAt';
  orderDirection?: 'asc' | 'desc';
}

export interface Page<T> {
  data: T[];
  totalItems: number;
  currentPage: number;
  pageSize: number;
}
```

## Porta de transacao tipada e neutra

```ts
export interface BillingTransactionalPorts {
  invoices: InvoiceRepository;
  outbox: OutboxRepository;
}

export interface BillingTransactionManager {
  execute<T>(
    work: (ports: BillingTransactionalPorts) => Promise<T>,
  ): Promise<T>;
}

export const BILLING_TRANSACTION_MANAGER = Symbol(
  'BILLING_TRANSACTION_MANAGER',
);
```

Tipar as portas transacionais evita um service locator `get<T>(token)` que esconde dependencias. Evite tambem decorator que depende implicitamente de `this.unitOfWork`; um callback explicito deixa o limite visivel e testavel.

Um repositorio pode usar transacao interna para persistir um agregado em varias tabelas sem expor Unit of Work ao caso de uso. Crie a porta acima quando a atomicidade cruza operacoes/ports da aplicacao.

## Teste unitario direto

```ts
describe('CreateCustomer', () => {
  it('persiste cliente normalizado', async () => {
    const repository: jest.Mocked<CustomerRepository> = {
      findByEmail: jest.fn().mockResolvedValue(null),
      save: jest.fn(async (customer) => customer),
    };
    const usecase = new CreateCustomer(repository, idGenerator, clock);

    const result = await usecase.execute({
      name: ' Ana ',
      email: 'ANA@EXAMPLE.COM',
    });

    expect(repository.save).toHaveBeenCalledTimes(1);
    expect(result.email).toBe('ana@example.com');
  });
});
```

## Onde colocar uma regra

| Regra | Local preferido |
|---|---|
| formato/invariante intrinseca de CPF/email | value object |
| transicao valida da entidade | entidade |
| unicidade que exige consulta | caso de uso |
| coordenacao entre repositorios/gateways | caso de uso |
| nome de coluna, include, audit fields | adapter/mapper |
| status HTTP, header, protobuf | controller/filter |
| escolha de implementacao concreta | modulo Nest |
