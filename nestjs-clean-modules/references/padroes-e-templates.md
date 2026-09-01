# Padroes e templates de composition root

## Contrato e token

No core:

```ts
export interface CustomerRepository {
  save(customer: Customer): Promise<Customer>;
}

export const CUSTOMER_REPOSITORY = Symbol('CUSTOMER_REPOSITORY');
```

## Modulo de feature

```ts
@Module({
  imports: [
    DatabaseModule,
    RouterModule.register([
      { path: '/api/customers', module: CustomerModule },
    ]),
  ],
  controllers: [CustomerController],
  providers: [
    {
      provide: CUSTOMER_REPOSITORY,
      useClass: PrismaCustomerRepository,
    },
    {
      provide: CreateCustomer,
      useFactory: (
        repository: CustomerRepository,
        idGenerator: IdGenerator,
        clock: Clock,
      ) => new CreateCustomer(repository, idGenerator, clock),
      inject: [CUSTOMER_REPOSITORY, ID_GENERATOR, CLOCK],
    },
  ],
  exports: [CreateCustomer],
})
export class CustomerModule {}
```

Se o modulo atual e dono do adaptador, `useClass` (como no exemplo principal) cria a implementacao local sob o token da porta.

Se `DatabaseModule` ja fornece e exporta a classe concreta, importe-o e crie somente o alias:

```ts
imports: [DatabaseModule],
providers: [
  {
    provide: CUSTOMER_REPOSITORY,
    useExisting: PrismaCustomerRepository,
  },
]
```

Nao registre `PrismaCustomerRepository` novamente nesse segundo modelo: isso criaria outra instancia local. Melhor ainda, faça o modulo de infraestrutura dono do adaptador exportar `CUSTOMER_REPOSITORY`; nesse caso o consumidor apenas importa esse modulo e nao cria alias.

## Provider factory reutilizavel

Quando modulos ficam extensos, extraia factories tipadas sem esconder o grafo:

```ts
export const createCustomerProvider: FactoryProvider<CreateCustomer> = {
  provide: CreateCustomer,
  useFactory: (repository: CustomerRepository) =>
    new CreateCustomer(repository),
  inject: [CUSTOMER_REPOSITORY],
};
```

Prefira uma constante nomeada a helpers genericos que removem a verificacao de tipos entre argumentos e `inject`.

## Controller fino

```ts
@Controller()
export class CustomerController {
  constructor(private readonly createCustomer: CreateCustomer) {}

  @Post()
  async create(@Body() dto: CreateCustomerRequestDto): Promise<CustomerResponseDto> {
    const customer = await this.createCustomer.execute({
      name: dto.name,
      email: dto.email,
    });
    return CustomerResponseDto.fromDomain(customer);
  }
}
```

Guard, filter, interceptor, pipes, status e Swagger pertencem ao controller/API. Unicidade, normalizacao de dominio e coordenacao pertencem ao caso de uso.

## REST e gRPC

```text
CustomerRestController ---┐
                          +--> CreateCustomer --> CustomerRepository
CustomerGrpcController ---┘
```

Cada controller traduz seu protocolo. Nenhum chama o outro.

## Exports entre modulos

Exporte o caso de uso se outro modulo precisa executar a capacidade. Exporte o token se outro provider precisa depender diretamente da porta. Nao exporte controller. Evite exportar adaptador concreto.

Se uma capacidade tiver API propria e tambem for reutilizada internamente, um modulo pode exportar os casos de uso enquanto mantem controller/rota locais.

## Teste do modulo real

```ts
describe('CustomerModule wiring', () => {
  it('resolve o caso de uso com a porta registrada', async () => {
    const builder = Test.createTestingModule({ imports: [CustomerModule] });
    builder.overrideProvider(CUSTOMER_REPOSITORY).useValue(
      customerRepositoryFake,
    );
    builder.overrideProvider(ID_GENERATOR).useValue(idGeneratorFake);
    builder.overrideProvider(CLOCK).useValue(clockFake);

    const moduleRef = await builder.compile();

    expect(moduleRef.get(CreateCustomer)).toBeInstanceOf(CreateCustomer);
    expect(moduleRef.get(CustomerController)).toBeInstanceOf(
      CustomerController,
    );
  });
});
```

Sobrescreva apenas I/O externo e compile a arvore real. Para verificar `exports`, crie um pequeno `ConsumerTestModule` que importe `CustomerModule` e injete `CreateCustomer`; recriar os providers manualmente nao detecta imports, exports ou controllers ausentes.

## Configuracao assincrona de integracao

```ts
imports: [
  ProviderModule.registerAsync({
    imports: [ConfigModule],
    inject: [ConfigService],
    useFactory: (config: ConfigService<AppConfig, true>) => ({
      endpoint: config.get('PROVIDER_ENDPOINT', { infer: true }),
      timeoutMs: config.get('PROVIDER_TIMEOUT_MS', { infer: true }),
    }),
  }),
]
```

Isso respeita validacao, cache e overrides do container. Nao use uma instancia criada com `new ConfigService()` no topo do arquivo.

## Diagnostico de DI

Quando Nest nao resolve uma dependencia:

1. Leia o indice do argumento no erro.
2. Compare a ordem do construtor com `useFactory` e `inject`.
3. Confirme que o token e exatamente a mesma referencia importada.
4. Confirme que o provider esta no mesmo modulo ou foi exportado/importado.
5. Procure modulo circular antes de recorrer a `forwardRef`.
6. Confirme que nao foi usada uma interface TypeScript como token runtime.

`forwardRef` resolve apenas o ciclo do container; ele nao corrige uma dependencia arquitetural circular entre features. Prefira extrair uma capacidade compartilhada ou inverter a porta.
