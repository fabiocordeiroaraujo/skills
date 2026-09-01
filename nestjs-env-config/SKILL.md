---
name: nestjs-env-config
description: Implementar, corrigir, auditar ou explicar variaveis de ambiente e configuracao em projetos NestJS usando @nestjs/config, ConfigModule, ConfigService, Joi, factories tipadas e .env.example. Use sempre que o usuario pedir para criar, adicionar, validar, tipar, consumir, migrar, revisar ou depurar configuracoes/env vars em um backend NestJS, incluindo problemas com process.env, validationSchema, loader, ConfigService, main.ts, Prisma DATABASE_URL ou defaults por ambiente.
---

# NestJS Env Config

## Objetivo

Implementar configuracao de ambiente em NestJS de forma consistente, tipada, validada no bootstrap e alinhada a uma camada central de config do backend.

Priorizar a API oficial `@nestjs/config`: `ConfigModule.forRoot()`, `load`, `validationSchema`, `ConfigService`, `cache`, `expandVariables` e uso de `ConfigService` no `main.ts`. Evitar espalhar `process.env` pela aplicacao; concentrar leitura, parsing e defaults na camada de configuracao.

## Fluxo

1. Ler o estado atual do projeto: `package.json`, `tsconfig*.json`, `src/app.module.ts`, `src/main.ts`, `.env.example` e qualquer pasta de config existente.
2. Instalar dependencias ausentes:
   ```bash
   yarn add @nestjs/config joi
   yarn add -D @types/node
   ```
   Para npm:
   ```bash
   npm i @nestjs/config joi
   npm i -D @types/node
   ```
3. Criar ou atualizar uma pasta de configuracao. Em projetos com camadas `app/infra`, use `src/app/infra/config`; em projetos NestJS simples, `src/config` tambem e aceitavel.
4. Definir um contrato TypeScript central para todas as variaveis expostas ao app.
5. Criar constantes/enums para valores fechados, como `NODE_ENV`.
6. Criar `validation-schema.ts` com Joi para falhar no startup quando valores obrigatorios estiverem ausentes ou invalidos.
7. Criar `loader.ts` para transformar strings em tipos finais (`number`, `boolean`, URLs derivadas) e aplicar defaults controlados.
8. Exportar tudo por `index.ts`.
9. Registrar a configuracao no modulo raiz com `ConfigModule.forRoot()`.
10. Consumir valores com `ConfigService<ConfigInterface, true>` e `{ infer: true }`.
11. Atualizar `.env.example` com o contrato canonico.
12. Adicionar ou atualizar testes focados de schema/loader/helpers quando o projeto ja usa Jest.
13. Rodar `yarn build` e testes relevantes.

## Estrutura Recomendada

Use este formato quando o projeto ainda nao tem uma camada clara de config:

```text
src/app/infra/config/
|-- config.interface.ts
|-- environment.ts
|-- loader.ts
|-- validation-schema.ts
`-- index.ts
```

Adicione arquivos auxiliares somente quando houver comportamento real para isolar, por exemplo `database-url.ts` para montar `DATABASE_URL`/`PRISMA_DATABASE_URL`.

Para templates completos de cada arquivo, leia `references/padroes-e-templates.md`.

## Contrato e Nomes

Escolha um contrato canonico e mantenha-o igual em todos os lugares:

- `.env.example`
- `ConfigInterface`
- `validation-schema.ts`
- `loader.ts`
- consumidores via `ConfigService`
- testes

Em projetos novos ou ja normalizados, prefira nomes simples e convencionais:

```env
NODE_ENV=development
PORT=8080
DATABASE_USER=postgres
DATABASE_PASSWORD=postgres
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=app
DATABASE_CONNECTION_LIMIT=5
JWT_SECRET=change-me
MAX_UPLOAD_SIZE=26214400
```

Se o projeto legado usa aliases (`APP_DATABASE_USER`, `DB_USER`, etc.), trate-os em helper dedicado e converta para o contrato canonico retornado pelo loader. Nao deixe metade do app ler aliases antigos e metade ler nomes novos.

## Validacao

Use Joi para validar os valores crus vindos do ambiente. Faca o schema representar as regras do dominio:

- `PORT` e portas de banco: `Joi.number().port()`
- contadores e limites: `Joi.number().integer().positive()`
- secrets obrigatorios: `Joi.string().trim().min(1).required()`
- ambientes fechados: `.valid(...NODE_ENV_VALUES).default(DEFAULT_NODE_ENV)`

Nao use placeholder em runtime para secret obrigatorio. Se `JWT_SECRET` e obrigatorio no schema, o loader tambem deve exigir valor real.

## Loader

Use o loader para transformar e compor valores finais:

- converter portas e limites para `number`;
- montar URL de banco quando necessario;
- aplicar defaults que tambem existem no schema;
- manter funcoes pequenas e testaveis.

Evite mutar `process.env` dentro do loader. Excecoes aceitaveis: integracoes externas que exigem uma variavel especifica antes de inicializar, como Prisma CLI/Client. Mesmo nesses casos, isole em helper nomeado, por exemplo `resolvePrismaDatabaseUrlFromEnv(env)`.

## AppModule

No modulo raiz:

```ts
ConfigModule.forRoot({
  isGlobal: true,
  cache: true,
  load: [loader],
  validationSchema,
  expandVariables: true,
});
```

Use `isGlobal: true` quando a aplicacao inteira deve consumir config sem importar `ConfigModule` em cada modulo. Use `cache: true` para reduzir leituras repetidas de `process.env`. Use `expandVariables: true` quando `.env` referencia outras variaveis, como `SUPPORT_EMAIL=support@${APP_URL}`.

## Consumo no Codigo

Injete `ConfigService` em services/providers:

```ts
import { ConfigService } from '@nestjs/config';
import { ConfigInterface } from '../infra/config';

constructor(
  private readonly configService: ConfigService<ConfigInterface, true>,
) {}

const maxUploadSize = this.configService.get('MAX_UPLOAD_SIZE', { infer: true });
```

No `main.ts`, obtenha config pelo app Nest, nao por `process.env`:

```ts
const configService = app.get<ConfigService<ConfigInterface, true>>(
  ConfigService,
);

await app.listen(configService.get('PORT', { infer: true }));
```

Use `process.env` diretamente somente dentro da camada de config, scripts de CLI ou adaptadores que rodam antes do container Nest existir.

## Namespaces

Para apps maiores, considere `registerAs()` para grupos como `database`, `security`, `storage` ou `queue`.

Use namespace quando:

- uma feature tem muitas variaveis;
- outro modulo precisa receber config via `forRootAsync`;
- a tipagem melhora ao injetar `ConfigType<typeof databaseConfig>`.

Em projetos pequenos ou em migracao, uma `ConfigInterface` plana pode ser mais simples e suficiente.

## Testes

Cubra pelo menos:

- valores aceitos e rejeitados de `NODE_ENV`;
- defaults (`PORT`, `MAX_UPLOAD_SIZE`, etc.);
- campos obrigatorios (`JWT_SECRET`, credenciais de banco);
- montagem de URLs derivadas;
- compatibilidade com aliases, se existirem.

Em specs TypeScript com Jest, garanta que `tsconfig.json` contenha os tipos:

```json
"types": ["node", "jest"]
```

## Checklist Final

Antes de encerrar uma tarefa de config NestJS:

- `@nestjs/config` e `joi` estao em `dependencies`.
- `ConfigModule.forRoot()` esta no modulo raiz.
- `.env.example`, `ConfigInterface`, Joi schema e loader usam o mesmo contrato.
- Secrets obrigatorios nao tem fallback inseguro.
- `main.ts` usa `ConfigService`.
- Providers consomem `ConfigService` tipado, nao `process.env`.
- Aliases legados estao isolados em helper, nao espalhados.
- `yarn build` passa.
- Testes relevantes passam ou a impossibilidade foi reportada.
