# Padroes e Templates para Configuracao NestJS

Use estes exemplos como base ao implementar variaveis de ambiente em um backend NestJS. Adapte nomes, paths e variaveis ao projeto.

## Dependencias

```bash
yarn add @nestjs/config joi
yarn add -D @types/node
```

Para testes com Jest em TypeScript:

```bash
yarn add -D @types/jest
```

E em `tsconfig.json`:

```json
{
  "compilerOptions": {
    "types": ["node", "jest"]
  }
}
```

## .env.example

```env
NODE_ENV=development
PORT=8080

DATABASE_USER=postgres
DATABASE_PASSWORD=postgres
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=app
DATABASE_CONNECTION_LIMIT=5

JWT_SECRET=change-me-generate-with-openssl-rand-base64-32
MAX_UPLOAD_SIZE=26214400
```

## config.interface.ts

```ts
export * from '@nestjs/config';

import type { NodeEnv } from './environment';

export interface EnvironmentConfig {
  NODE_ENV: NodeEnv;
  PORT: number;
}

export interface DatabaseConfig {
  DATABASE_USER: string;
  DATABASE_PASSWORD: string;
  DATABASE_HOST: string;
  DATABASE_PORT: number;
  DATABASE_NAME: string;
  DATABASE_CONNECTION_LIMIT: number;
}

export interface SecurityConfig {
  JWT_SECRET: string;
  MAX_UPLOAD_SIZE: number;
}

export interface ConfigInterface
  extends EnvironmentConfig,
    DatabaseConfig,
    SecurityConfig {}
```

## environment.ts

```ts
export const NODE_ENV_VALUES = [
  'development',
  'test',
  'homologation',
  'training',
  'production',
] as const;

export type NodeEnv = (typeof NODE_ENV_VALUES)[number];

export const DEFAULT_NODE_ENV: NodeEnv = 'development';

export const isDevelopmentEnvironment = (
  env: string | undefined = DEFAULT_NODE_ENV,
): boolean => env === 'development';

export const isVerboseLogEnvironment = (
  env: string | undefined = DEFAULT_NODE_ENV,
): boolean => env === 'development' || env === 'test';
```

## validation-schema.ts

```ts
import * as Joi from 'joi';
import { ConfigInterface } from './config.interface';
import { DEFAULT_NODE_ENV, NODE_ENV_VALUES } from './environment';

export default Joi.object<ConfigInterface>({
  NODE_ENV: Joi.string()
    .valid(...NODE_ENV_VALUES)
    .default(DEFAULT_NODE_ENV),
  PORT: Joi.number().port().default(8080),
  DATABASE_USER: Joi.string().required(),
  DATABASE_PASSWORD: Joi.string().required(),
  DATABASE_HOST: Joi.string().required(),
  DATABASE_PORT: Joi.number().port().required(),
  DATABASE_NAME: Joi.string().required(),
  DATABASE_CONNECTION_LIMIT: Joi.number().integer().positive().required(),
  JWT_SECRET: Joi.string().trim().min(1).required(),
  MAX_UPLOAD_SIZE: Joi.number().integer().positive().default(26214400),
});
```

## database-url.ts

Use helper separado para composicao de URL quando Prisma, TypeORM ou outro cliente precisar de uma connection string.

```ts
export interface DatabaseUrlConfig {
  user: string;
  password: string;
  host: string;
  port: number | string;
  database: string;
  connectionLimit?: number | string;
}

const isUnresolvedEnvReference = (value: string): boolean =>
  /^\$[A-Z_][A-Z0-9_]*$/.test(value.trim());

const firstConfigured = (
  ...values: Array<string | undefined>
): string | undefined =>
  values.find(
    (value) =>
      value !== undefined &&
      value.trim() !== '' &&
      !isUnresolvedEnvReference(value),
  );

const requiredValue = (name: string, value: string | undefined): string => {
  if (value === undefined || value.trim() === '') {
    throw new Error(`Database configuration ${name} is required`);
  }

  return value;
};

const parsePositiveInteger = (
  name: string,
  value: number | string | undefined,
): number => {
  const parsed = typeof value === 'number' ? value : Number(value);

  if (!Number.isInteger(parsed) || parsed <= 0) {
    throw new Error(
      `Database configuration ${name} must be a positive integer`,
    );
  }

  return parsed;
};

const formatHost = (host: string): string => {
  const trimmedHost = requiredValue('host', host).trim();
  const isIpv6 = trimmedHost.includes(':') && !trimmedHost.startsWith('[');

  return isIpv6 ? `[${trimmedHost}]` : trimmedHost;
};

export const getDatabaseConfigFromEnv = (
  env: NodeJS.ProcessEnv = process.env,
): DatabaseUrlConfig => ({
  user: firstConfigured(env.DATABASE_USER, env.DB_USER) ?? 'postgres',
  password:
    firstConfigured(env.DATABASE_PASSWORD, env.DB_PASSWORD) ?? 'postgres',
  host: firstConfigured(env.DATABASE_HOST, env.DB_HOST) ?? 'localhost',
  port: firstConfigured(env.DATABASE_PORT, env.DB_PORT) ?? '5432',
  database: firstConfigured(env.DATABASE_NAME, env.DB_NAME) ?? 'dbname',
  connectionLimit:
    firstConfigured(env.DATABASE_CONNECTION_LIMIT, env.DB_CONNECTION_LIMIT) ??
    '5',
});

export const buildPostgresDatabaseUrl = (config: DatabaseUrlConfig): string => {
  const user = encodeURIComponent(requiredValue('user', config.user).trim());
  const password = encodeURIComponent(
    requiredValue('password', config.password),
  );
  const host = formatHost(config.host);
  const port = parsePositiveInteger('port', config.port);
  const database = encodeURIComponent(
    requiredValue('database', config.database).trim(),
  );
  const connectionLimit = parsePositiveInteger(
    'connectionLimit',
    config.connectionLimit ?? 5,
  );

  return `postgresql://${user}:${password}@${host}:${port}/${database}?connection_limit=${connectionLimit}`;
};

export const buildDatabaseUrlFromEnv = (
  env: NodeJS.ProcessEnv = process.env,
): string => buildPostgresDatabaseUrl(getDatabaseConfigFromEnv(env));

export const resolvePrismaDatabaseUrlFromEnv = (
  env: NodeJS.ProcessEnv = process.env,
): string => {
  const databaseUrl = buildDatabaseUrlFromEnv(env);
  env.PRISMA_DATABASE_URL = databaseUrl;

  return databaseUrl;
};
```

## loader.ts

```ts
import { ConfigInterface } from './config.interface';
import { getDatabaseConfigFromEnv } from './database-url';
import { DEFAULT_NODE_ENV } from './environment';

const requiredEnv = (name: string): string => {
  const value = process.env[name];

  if (value === undefined || value.trim() === '') {
    throw new Error(`${name} must be configured`);
  }

  return value;
};

export default (): ConfigInterface => {
  const databaseConfig = getDatabaseConfigFromEnv();

  return {
    NODE_ENV: (process.env.NODE_ENV ||
      DEFAULT_NODE_ENV) as ConfigInterface['NODE_ENV'],
    PORT: parseInt(process.env.PORT ?? '', 10) || 8080,

    DATABASE_USER: databaseConfig.user,
    DATABASE_PASSWORD: databaseConfig.password,
    DATABASE_HOST: databaseConfig.host,
    DATABASE_PORT: parseInt(String(databaseConfig.port), 10) || 5432,
    DATABASE_NAME: databaseConfig.database,
    DATABASE_CONNECTION_LIMIT:
      parseInt(String(databaseConfig.connectionLimit), 10) || 5,

    JWT_SECRET: requiredEnv('JWT_SECRET'),
    MAX_UPLOAD_SIZE: Number(process.env.MAX_UPLOAD_SIZE) || 26214400,
  };
};
```

## index.ts

```ts
export { default as loader } from './loader';
export { default as validationSchema } from './validation-schema';
export * from './config.interface';
export * from './database-url';
export * from './environment';
```

## app.module.ts

```ts
import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { loader, validationSchema } from './app/infra/config';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      cache: true,
      load: [loader],
      validationSchema,
      expandVariables: true,
    }),
  ],
})
export class AppModule {}
```

## main.ts

```ts
import { ConfigService } from '@nestjs/config';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigInterface } from './app/infra/config';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const configService = app.get<ConfigService<ConfigInterface, true>>(
    ConfigService,
  );

  await app.listen(configService.get('PORT', { infer: true }));
}

bootstrap();
```

## Consumer provider

```ts
import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { ConfigInterface } from '../infra/config';

@Injectable()
export class UploadPolicyService {
  constructor(
    private readonly configService: ConfigService<ConfigInterface, true>,
  ) {}

  get maxUploadSize(): number {
    return this.configService.get('MAX_UPLOAD_SIZE', { infer: true });
  }
}
```

## Tests

```ts
import validationSchema from './validation-schema';
import { DEFAULT_NODE_ENV, NODE_ENV_VALUES } from './environment';

describe('validationSchema', () => {
  it('declara os ambientes suportados', () => {
    const nodeEnvSchema = validationSchema.extract('NODE_ENV');

    NODE_ENV_VALUES.forEach((env) => {
      expect(nodeEnvSchema.validate(env).error).toBeUndefined();
    });
    expect(nodeEnvSchema.validate('desenvolvimento').error).toBeDefined();
  });

  it('usa defaults controlados', () => {
    expect(validationSchema.extract('NODE_ENV').validate(undefined).value).toBe(
      DEFAULT_NODE_ENV,
    );
    expect(validationSchema.extract('PORT').validate(undefined).value).toBe(8080);
  });

  it('rejeita valores invalidos', () => {
    expect(validationSchema.extract('PORT').validate(70000).error).toBeDefined();
    expect(validationSchema.extract('JWT_SECRET').validate('').error).toBeDefined();
  });
});
```
