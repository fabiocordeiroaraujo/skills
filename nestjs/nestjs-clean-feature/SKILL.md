---
name: nestjs-clean-feature
description: "Implementar, estruturar, migrar ou revisar uma feature vertical completa em backend NestJS segundo a Clean Architecture observada em referencia/notifica-backend: dominio e casos de uso no core, portas por interfaces, adaptadores de banco/integracao e composition root em infra/modules. Use sempre que um novo modulo de negocio, CRUD, fluxo, endpoint REST/gRPC ou refatoracao atravessar duas ou mais camadas, especialmente quando exigir baixo acoplamento, SOLID, interfaces, repositorios ou testabilidade. Nao use para ajuste isolado de provider, rota ou controller; nesse caso use nestjs-clean-modules."
---

# NestJS Clean Feature

## Objetivo

Entregar uma fatia vertical funcional sem inverter a regra de dependencia. O `core` define o que precisa; adaptadores externos implementam essas portas; NestJS apenas conecta objetos e transportes.

Use esta skill como orquestradora. Quando disponiveis, aplique tambem:

1. `nestjs-clean-core` para dominio, portas e casos de uso.
2. `nestjs-clean-adapters` para Prisma, filas, HTTP/gRPC clients e outros gateways.
3. `nestjs-clean-modules` para providers, controllers, rotas e exports.

## Antes de editar

1. Leia `AGENTS.md` aplicaveis, `package.json`, `tsconfig`, modulo raiz e uma feature vizinha bem mantida.
2. Mapeie a arvore real. Nao suponha que o projeto usa exatamente os mesmos nomes do backend de referencia.
3. Identifique dominio, entradas, saidas, invariantes, autorizacao, transacao, idempotencia e falhas esperadas.
4. Procure contratos e componentes compartilhados antes de criar duplicatas.
5. Preserve mudancas do usuario e mantenha o escopo da feature.

Para entender quais padroes foram extraidos da referencia e quais ocorrencias legadas nao devem ser copiadas, leia `references/arquitetura-notifica.md`.

## Regra de dependencia

```text
api/rest, api/grpc, consumers ──> casos de uso ──> portas do core
                                      ^                 ^
                                      |                 |
                               infra/modules      database/integration
                               compoe o grafo     implementam as portas
```

A seta representa dependencia de codigo. O `core` nao importa NestJS, Prisma, DTO HTTP, controllers, ConfigService nem SDK de fornecedor.

## Estrutura alvo

Adapte nomes ao repositorio, preservando as responsabilidades:

```text
src/app/
|-- core/<feature>/
|   |-- contract/
|   |-- entity/
|   |-- usecase/
|   `-- dto/                 # apenas modelos de entrada/saida da aplicacao
|-- database/<feature>/      # repositorio e mapper Prisma
|-- integration/<provider>/  # adaptadores externos, se houver
|-- api/rest/                # controller e DTOs de transporte
|-- api/grpc/                # controller e protobuf, se houver
`-- infra/modules/<feature>.module.ts
```

## Fluxo de implementacao

### 1. Modele o core

- Expresse invariantes em entidade, value object ou caso de uso, conforme seu alcance.
- Defina portas pequenas a partir das necessidades do caso de uso; nao espelhe a API do Prisma ou do fornecedor.
- Modele entradas e saidas tipadas. Evite listas de parametros posicionais extensas.
- Injete portas pelo construtor e mantenha `execute` como fronteira publica do caso de uso.
- Use erros de dominio/aplicacao independentes de HTTP; filtros do transporte fazem a traducao.

### 2. Implemente adaptadores

- Faca o repositorio implementar explicitamente a porta do core.
- Converta registros externos para entidades com mapper; tipos Prisma nao atravessam a fronteira.
- Converta erros tecnicos somente quando houver semantica de negocio clara; nao transforme falha de banco em lista vazia ou `null` silencioso.
- Implemente integracoes por portas equivalentes, mantendo SDK, retry e configuracao fora do core.
- Se o fluxo grava no banco e publica em broker, avalie outbox; uma transacao Prisma nao torna a publicacao externa atomica.

### 3. Componha no NestJS

- Declare um token runtime por porta (`Symbol`) e associe-o ao adaptador no modulo de infraestrutura.
- Instancie casos de uso com `useFactory` quando isso mantiver o core livre de decorators Nest.
- Importe modulos que exportam capacidades; nao reinstancie providers compartilhados.
- Exporte somente tokens/casos de uso consumidos por outros modulos.
- Mantenha controllers finos: validar transporte, mapear DTO, chamar um caso de uso e mapear resposta.

### 4. Verifique a fatia completa

- Teste casos de uso diretamente com mocks tipados das portas.
- Teste mappers e repositorios com foco em conversao, filtros, persistencia e erros.
- Teste a composicao Nest para detectar tokens ausentes ou exports incorretos.
- Teste controller/e2e somente para comportamento de transporte e integracao da rota.
- Rode build, lint sem alteracoes destrutivas e testes focados; amplie conforme o risco.

## Decisoes obrigatorias

Antes de concluir, responda no codigo ou no relato final:

- Onde cada regra de negocio ficou e por que pertence a essa camada?
- Quais portas o caso de uso consome?
- Qual provider concreto implementa cada porta e em qual modulo ocorre o binding?
- A operacao precisa de transacao? Se sim, o limite cobre o caso de uso completo?
- Quais falhas sao de dominio e quais sao tecnicas?
- Como a feature pode ser testada sem inicializar NestJS, banco ou rede?

## Guardrails

- Nao injete repositorio Prisma ou service de fornecedor diretamente em caso de uso.
- Nao coloque `@Module`, `@Controller`, `@Injectable`, `@Inject`, `HttpException`, `ConfigService` ou decorators de scheduler no core novo.
- Nao deixe controller coordenar varias regras ou persistencias; crie um caso de uso de orquestracao.
- Nao use `any` em contratos novos quando um tipo de dominio, filtro ou pagina pode ser nomeado.
- Nao registre o mesmo repositorio sob tokens concorrentes sem uma razao documentada.
- Nao crie Unit of Work de aplicacao sem um limite atomico que atravesse varias operacoes/portas. Um repositorio ainda pode usar transacao interna para persistir um unico agregado em varias tabelas.
- Nao copie inconsistencias historicas da referencia como se fossem convencao.

## Entrega

Resuma arquivos criados/alterados por camada, bindings de interfaces, testes executados e riscos remanescentes. Se a tarefa for apenas revisao, nao edite: apresente violacoes pela direcao da dependencia e uma ordem segura de correcao.
