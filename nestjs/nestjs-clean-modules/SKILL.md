---
name: nestjs-clean-modules
description: Criar, integrar, corrigir, testar ou revisar modulos NestJS como composition root de uma Clean Architecture, fazendo binding de interfaces/tokens a adaptadores, factories de casos de uso, imports/exports, RouterModule e controllers REST/gRPC finos. Use sempre que a tarefa envolver infra/modules, @Module, providers, useFactory, useClass, Symbol injection token, DependencyResolutionException, dependencia circular, rota de feature, controller, DTO de transporte ou exportacao de capacidade entre modulos.
---

# NestJS Clean Modules

## Objetivo

Concentrar no NestJS a decisao de quais implementacoes concretas satisfazem as portas do core. O modulo e o composition root da feature; trocar banco ou fornecedor deve exigir mudanca aqui e no adaptador, nao no caso de uso.

Leia `references/padroes-e-templates.md` para os bindings recomendados, controller fino e teste de resolucao.

## Fluxo

1. Liste casos de uso expostos pela feature e suas dependencias de construtor.
2. Para cada porta, localize o token runtime e o adaptador concreto.
3. Importe o modulo que exporta uma capacidade compartilhada; nao recrie seu provider.
4. Registre adaptadores por token.
5. Registre casos de uso com `useFactory`, mantendo-os livres de decorators Nest.
6. Declare controllers e rota da feature conforme convencao local.
7. Exporte apenas capacidades usadas por outros modulos.
8. Adicione um teste que compile o modulo e resolva os providers principais.

## Binding preferido

```ts
providers: [
  {
    provide: CUSTOMER_REPOSITORY,
    useClass: PrismaCustomerRepository,
  },
  {
    provide: CreateCustomer,
    useFactory: (repository: CustomerRepository) =>
      new CreateCustomer(repository),
    inject: [CUSTOMER_REPOSITORY],
  },
]
```

Use `useExisting` quando uma unica instancia concreta precisa atender ao token e tambem ser injetada pela classe. Use `useValue` para fake/config estatica em testes. Use `useFactory` para construcao dependente de configuracao ou multiplas portas.

Interfaces TypeScript desaparecem em runtime. Nunca coloque uma interface pura em `inject`. O token deve ser `Symbol`, string bem namespaced ou classe abstrata. Prefira `Symbol` exportado junto do contrato.

## Imports e exports

- `imports`: modulos que fornecem providers exportados, integracoes configuradas e `RouterModule.register` quando o projeto usa esse padrao.
- `providers`: bindings locais e casos de uso.
- `controllers`: somente adaptadores de entrada da feature.
- `exports`: tokens/casos de uso deliberadamente publicos.

Evite importar `PrismaService` diretamente em todo modulo de feature se um `DatabaseModule`/`DataModule` ja o exporta. Evite exportar repositorio concreto quando consumidores deveriam depender do token da porta.

Configure modulos dinamicos com `forRootAsync`/`registerAsync` e `ConfigService` injetado. Nao execute `new ConfigService()` no escopo do arquivo nem configure clients durante import-time; isso contorna loader, validacao, overrides de teste e lifecycle do container.

## Controllers e DTOs

O controller pode:

- validar formato de transporte com decorators/DTOs;
- aplicar guard, filter e interceptor;
- mapear request para input do caso de uso;
- chamar um caso de uso;
- mapear output para response e status/protobuf.

O controller nao deve deduplicar entidades, consultar repositorios, coordenar varias escritas ou decidir invariantes. Mova isso para o caso de uso.

Use guards para autenticacao e autorizacao grosseira por papel/escopo. Autorizacao dependente do recurso, tenant ou ownership deve chegar ao caso de uso como actor context ou policy port, pois faz parte da decisao de negocio.

Mantenha DTOs HTTP/gRPC em `api`; nao os importe no core. Respostas podem usar factories `fromDomain`, desde que o dominio nao conheca o DTO.

## Rotas

Siga a convencao do projeto para prefixo global versus `RouterModule.register`. Garanta que o modulo registrado na rota seja o mesmo declarado e importado pelo modulo raiz. Para REST e gRPC compartilharem logica, injete os mesmos casos de uso em controllers distintos.

## Unit of Work

Registre Unit of Work somente quando consumido. Todos os repositorios da transacao devem usar o mesmo contexto. Nao associe enums/chaves trocadas nem registre repositorio que o caso de uso nao usa. Prefira um binding por porta; documente providers de escopo especial.

## Testes de composicao

Compile um `TestingModule` com o modulo ou uma configuracao equivalente, substitua somente dependencias externas inevitaveis e verifique:

- resolucao dos casos de uso;
- token apontando para o adaptador correto;
- exports acessiveis ao modulo consumidor;
- controller resolvido;
- ausencia de dependencia circular.

## Checklist

- Toda interface injetada tem token runtime.
- Factories e arrays `inject` tem mesma ordem e cardinalidade.
- Casos de uso nao ganharam decorators para facilitar DI.
- Providers compartilhados sao importados/exportados, nao duplicados.
- Controllers continuam adaptadores finos.
- Exports formam uma API minima do modulo.
- Build e teste de composicao detectam tokens ausentes.
