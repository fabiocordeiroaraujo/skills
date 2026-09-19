---
name: nestjs-clean-core
description: "Criar, alterar, testar ou revisar a camada core de um backend NestJS com Clean Architecture: entidades, value objects, erros, contratos/ports e casos de uso desacoplados por interfaces. Use sempre que a tarefa mencionar regra de negocio, dominio, entidade, usecase/caso de uso, repository interface, porta de saida, inversao de dependencia, SOLID, teste unitario isolado ou remocao de acoplamento com NestJS/Prisma dentro de core/."
---

# NestJS Clean Core

## Objetivo

Construir o centro da aplicacao como TypeScript independente de framework. O core deve compilar e ser testado sem subir NestJS, conectar banco ou carregar SDK externo.

Leia `references/padroes-e-templates.md` quando precisar criar arquivos ou escolher entre entidade, value object, porta, DTO de aplicacao e caso de uso.

## Fronteiras

O core pode depender de:

- TypeScript/JavaScript e bibliotecas puras justificadas;
- entidades, value objects, enums e erros do proprio core;
- interfaces definidas pelo proprio core.

O core novo nao depende de:

- `@nestjs/*`, decorators de DI, HTTP, gRPC, scheduler ou ConfigService;
- `@prisma/client`, PrismaService, models/tipos de tabela ou transacoes Prisma;
- DTOs de `api/rest` ou stubs protobuf;
- classes de `database`, `integration` ou `infra`;
- SDKs de mail, fila, storage ou fornecedor.

## Fluxo

1. Descreva o comportamento em termos do dominio, sem mencionar transporte ou banco.
2. Modele invariantes locais na entidade/value object e invariantes de fluxo no caso de uso.
3. Defina uma porta para cada capacidade externa realmente consumida.
4. Modele `Input` e `Output` do caso de uso com tipos nomeados quando houver mais de poucos argumentos.
5. Injete portas pelo construtor `private readonly`.
6. Implemente um metodo publico `execute` e mantenha helpers privados focados.
7. Escreva testes unitarios instanciando a classe diretamente com mocks das interfaces.
8. Rode `scripts/check-core-boundaries.sh <pasta-core-ou-feature>` para detectar imports que quebram a direcao de dependencia. Em core legado, limite a verificacao aos arquivos novos/alterados e reporte divida preexistente separadamente.

## Portas

- Nomeie pelo papel de dominio: `NotificationRepository`, `RecipientGateway`, `MessageQueue`; nao `PrismaNotificationService`.
- Exponha somente operacoes necessarias ao consumidor (Interface Segregation).
- Use entidades/value objects do core nas assinaturas.
- Crie filtros e resultados paginados tipados; nao publique `any`.
- Expresse ausencia com `T | null` e falha com erro; nao misture os dois significados.
- Quando a porta sera usada pelo container, exporte tambem um token runtime com nome sem prefixo ambiguo, por exemplo `NOTIFICATION_REPOSITORY = Symbol(...)`.

## Casos de uso

- Receba dependencias abstratas, nunca implementacoes.
- Faca o caso de uso coordenar validacao de negocio, consulta, mudanca de estado e persistencia.
- Gere IDs e relogio por portas quando determinismo for relevante; UUID/data globais sao aceitaveis apenas conforme convencao e risco do projeto.
- Proteja idempotencia e concorrencia quando a operacao puder ser reprocessada.
- Use uma porta de transacao (`UnitOfWork`/`TransactionManager`) sem tipos Prisma se varias escritas precisarem ser atomicas.
- Evite caso de uso chamando outro caso de uso apenas para reutilizar detalhe; extraia politica/servico de dominio quando apropriado.
- Receba identidade/tenant e autorizacao por recurso como input ou policy port. Guards cuidam da autenticacao e de regras grosseiras de papel; ownership e permissao contextual pertencem ao fluxo de negocio.

## Erros

Crie erros que descrevam a falha (`EntityNotFoundError`, `DuplicateEntityError`, `InvalidCpfError`, `OperationNotAllowedError`) e estendam `Error`. Inclua codigo/chave e dados necessarios para traducao. O adaptador HTTP/gRPC escolhe status e formato.

Ao atuar em codigo legado que usa `HttpException` no core, nao amplie o acoplamento. Preserve compatibilidade onde necessario e isole a migracao em uma fronteira clara.

## Testes

Cubra:

- caminho feliz e valor retornado;
- cada invariante e erro esperado;
- chamadas e argumentos enviados a cada porta;
- ausencia de escrita quando a validacao falha;
- idempotencia/conflito quando aplicavel;
- fronteiras de value objects.

Prefira `jest.Mocked<Port>` ou factories de mock tipadas. Nao use `TestingModule` para testar uma classe que pode ser criada com `new`.

## Checklist

- Nenhum import proibido entrou no core novo.
- O contrato pertence ao consumidor, nao ao adaptador.
- Assinaturas nao vazam Prisma, HTTP ou SDK.
- Dependencias sao `readonly` e recebidas pelo construtor.
- A regra nao ficou em controller, mapper ou repository.
- Testes executam sem container e sem I/O.
- Nomes seguem o idioma e convencao predominantes do projeto.
