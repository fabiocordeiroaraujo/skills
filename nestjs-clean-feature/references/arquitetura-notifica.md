# Arquitetura extraida de `referencia/notifica-backend`

## Proposito desta referencia

Este documento separa o desenho arquitetural recorrente das inconsistencias historicas encontradas no projeto. Use os primeiros como base; trate as segundas como divida tecnica, nao como template.

## Mapa das camadas

| Camada | Responsabilidade observada | Exemplos |
|---|---|---|
| `src/app/core` | Entidades, VOs, contratos, casos de uso, regras | `core/template`, `core/message-category`, `core/common/vo` |
| `src/app/database` | Prisma, repositorios, mappers, filtros, UoW | `database/template`, `database/distribution-list`, `database/prisma` |
| `src/app/integration` | Adaptadores de email, fila, gRPC e fornecedores | `integration/mailer`, `integration/message-queue`, `integration/ep-cadastro` |
| `src/app/api` | Adaptadores de entrada REST e gRPC, DTOs | `api/rest/controller`, `api/rest/dto`, `api/grpc/controllers` |
| `src/app/infra/modules` | Composicao de dependencias e rotas Nest | `email.module.ts`, `template-message.module.ts`, `distribution-list.module.ts` |

O `README.md`, na secao "Estrutura do projeto", confirma essa intencao: `core` e descrito como logica de negocio, repositorios ficam em `database`, integracoes em `integration`, e modulos em `infra/modules`.

## Padroes fortes encontrados

### Portas no core

Os contratos em `core/*/contract` descrevem capacidades consumidas pelos casos de uso:

- `IEmailRepository`, `IEmailService`, `IEmailQueue`;
- `IDistributionListRepository` e `IDistributionSubscriptionRepository`;
- `ITemplateRepository` e `ITemplateCategoryRepository`;
- `IRecipientService` e `IMessageQueue`.

Isso materializa Dependency Inversion: o fluxo de negocio conhece uma abstracao, nao Prisma, Nodemailer ou gRPC.

### Injecao por construtor

Casos de uso como `CreateTemplate`, `CreateModule`, `SendEmailMessage` e `CreateDistributionSubscription` recebem dependencias no construtor e expõem `execute`. Os testes instanciam esses casos diretamente com mocks de interface, como em:

- `create-message-category.usecase.spec.ts`;
- `create-distribution-subscription.usecase.spec.ts`;
- `send-email.usecase.spec.ts`.

### Adaptadores implementam contratos

Repositorios como `TemplateRepository`, `DistributionListRepository`, `SmsRepository` e `MessageCategoryRepository` declaram `implements` sobre interfaces do core. Integracoes como `EmailMailerService` e `WhatsappBusinessService` implementam portas de service.

### Mappers protegem o dominio

`DistributionListMapper`, `TemplateMapper`, `MessageMapper` e outros traduzem nomes/campos Prisma para entidades. Isso evita que o model de persistencia seja o modelo do negocio.

### Composition root explicito

Os arquivos em `infra/modules` mostram as dependencias concretas de cada caso de uso. O estilo mais desacoplado usa factory:

```ts
{
  provide: ListMessages,
  useFactory: (repository: IMessageRepository) =>
    new ListMessages(repository),
  inject: [MessageRepository],
}
```

Arquivos mais recentes, como contratos de `message-category`, `user-preference` e `email-settings`, adicionam `Symbol` runtime ao lado da interface e usam `useClass`. A combinacao normativa das skills e:

1. interface + `Symbol` no contrato;
2. `useClass` para ligar token ao adaptador;
3. `useFactory` para construir caso de uso sem decorator Nest.

### Modulos por capacidade

Os modulos agrupam rota, controller e providers de uma capacidade. Eles exportam casos de uso/tokens somente quando outros modulos precisam consumi-los, como `DistributionListModule` e `MessageCategoryModule`.

### Entradas multiplas reutilizam casos de uso

REST e gRPC possuem controllers separados, mas dependem dos mesmos casos de uso do core. A regra nao deve ser duplicada por protocolo.

### Persistencia com auditoria e concorrencia

Repositorios atualizam `versao`, `audit_operacao` e `audit_datahora`. `rethrow-prisma-concurrency.ts` centraliza a traducao de conflitos. Preserve essas preocupacoes no adaptador.

## Variacoes historicas que nao sao normativas

### NestJS dentro do core

Varios casos usam `@Injectable`, `@Inject`, `Logger`, `BadRequestException`, `ConfigService`, `Cron` e `HttpException` dentro de `core`. Isso facilita DI imediata, mas viola a independencia do framework. Codigo novo deve manter decorators, logger e traducao HTTP nas bordas.

### Prisma dentro da porta de transacao

`core/common/transaction/unit-of-work.interface.ts` importa `Prisma.TransactionIsolationLevel`. Isso vaza tecnologia para dentro. Modele opcoes neutras no core e traduza no `PrismaUnitOfWork`.

### Modulos Nest em `core`

`message-category.module.ts`, `email-settings.module.ts` e `user-preference.module.ts` ficam em `core`. O comportamento do binding e util, mas o arquivo de composicao deve ficar em `infra/modules` (ou na camada externa equivalente).

### Erros tecnicos tratados como ausencia

Alguns repositorios capturam qualquer erro e retornam `null`, `[]` ou pagina vazia. Isso confunde "nao encontrado" com indisponibilidade. Somente uma consulta bem-sucedida sem registro retorna ausencia; falha tecnica deve subir/traduzir.

### Regra em controller

`DistributionListController.saveNewSubscriptions` normaliza, deduplica e decide precedencia de inscricoes. Essa coordenacao e regra de aplicacao e deve virar caso de uso. Controllers novos devem apenas adaptar transporte.

### `any` em contratos e filtros

Ha filtros, mappers e repositorios com `any`. Use tipos nomeados para impedir que detalhes externos atravessem fronteiras e para proteger ordenacao/filtros.

### Chaves de Unit of Work inconsistentes

`RepositoryEnum` possui valores que nao correspondem claramente aos nomes dos membros (`SYSTEM_MODULE` e `DISTRIBUTION_LIST`, por exemplo). Nao replique enums/chaves por copia; valide binding, nome e repositorio registrado.

### Providers duplicados ou concretos

`DatabaseModule` exporta classes concretas e contem registros repetidos. Modulos de feature tambem podem instanciar `PrismaService` diretamente. Prefira token unico por porta, modulo de infraestrutura compartilhado e exports minimos.

### Configuracao executada no carregamento do arquivo

Modulos como `email.module.ts`, `whatsapp.module.ts` e `unit.module.ts` criam `new ConfigService()` fora do container para montar integracoes durante import-time. Isso pode ignorar loader/validacao, dificultar override em testes e repetir configuracoes. Codigo novo deve usar `registerAsync`/`forRootAsync`, injetar `ConfigService` tipado e exportar uma unica capacidade configurada.

## Arquitetura normativa das skills

```text
Core
  entity/value object/error
  input/output de aplicacao
  port + token runtime neutro
  use case com constructor injection

Adapters
  PrismaRepository implements Port
  Mapper persistence <-> domain
  ProviderGateway implements Port
  PrismaUnitOfWork implements TransactionPort

Entradas/composicao
  REST DTO/controller ----┐
  gRPC controller --------+--> UseCase
  Nest feature module ----┘    ^
                              port -> adapter binding
```

## Ordem recomendada para uma feature

1. Especificar casos e invariantes.
2. Criar entidade/VO/erros.
3. Criar portas e inputs/outputs.
4. Criar caso de uso e teste unitario.
5. Criar mapper e repositorio/gateway com testes.
6. Criar DTO/controller por protocolo.
7. Criar modulo e bindings.
8. Registrar no modulo raiz/rota.
9. Rodar testes focados, build e e2e relevante.

## Criterio de independencia

Uma feature esta bem desacoplada quando:

- o caso de uso roda com `new` e fakes;
- trocar Prisma por memoria exige novo adaptador e novo binding, sem editar o caso de uso;
- REST e gRPC chamam a mesma regra;
- detalhes de DTO/model/SDK nao aparecem nos contratos do core;
- falhas de transporte sao traduzidas fora do dominio;
- o grafo de imports aponta para dentro.
