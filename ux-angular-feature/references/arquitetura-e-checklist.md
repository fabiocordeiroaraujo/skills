# Arquitetura de feature Angular sobre o padrao UX

## Estado tecnico observado

- Angular `19.2.x` e TypeScript `5.8.x`.
- Aplicacao baseada em `NgModule`.
- Componentes do template usam `standalone: false`.
- Lazy loading no `AppRoutingModule`.
- RxJS `7.8.x`.
- Bootstrap `5.3.2` e ng-bootstrap `18.x`.
- SCSS UX global em `src/assets/styles/app/_app.scss`.
- ECharts, calendario, mask, Toastr e scrollbar ja instalados.
- `InMemoryWebApiModule` e services de dados demo ainda estao presentes.
- Specs Jasmine/Karma e configuracao Protractor herdada existem, mas nao garantem cobertura/compatibilidade.

## Fontes que precisam ser lidas no contexto

| Pergunta | Fonte |
| --- | --- |
| Como o app sobe? | `frontend/src/app/app.module.ts` |
| Onde integrar rota lazy? | `frontend/src/app/app-routing.module.ts` |
| Quais exports compartilhados existem? | `frontend/src/app/shared/shared.module.ts` e `shared/components/shared-components.module.ts` |
| Como o shell e montado? | `frontend/src/app/shared/components/layouts/` |
| Como o menu atual funciona? | `frontend/src/app/shared/services/navigation.service.ts` |
| Como um feature module e composto? | `frontend/src/app/views/dashboard/dashboard.module.ts` ou `views/forms/forms.module.ts` |
| Qual a arquitetura-alvo? | `requirements/tech/03-frontend-angular.md` |

## Exemplo minimo de feature

### Module

```ts
@NgModule({
  declarations: [AttendanceDailyPageComponent],
  imports: [
    CommonModule,
    ReactiveFormsModule,
    NgbModule,
    SharedComponentsModule,
    AttendanceRoutingModule,
  ],
})
export class AttendanceModule {}
```

Importe `NgbModule` ou modulos ng-bootstrap mais estreitos conforme o padrao adotado no entorno. Nao adicione a feature ao `SharedModule`.

### Routing

```ts
const routes: Routes = [
  {
    path: 'daily',
    component: AttendanceDailyPageComponent,
    data: {
      capability: 'attendance',
      permission: 'attendance:read',
    },
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AttendanceRoutingModule {}
```

Os nomes de metadata sao ilustrativos; alinhe ao core real em vez de criar um contrato paralelo.

### Modelo de tela e API

```ts
export interface AttendanceRowView {
  studentId: string;
  displayName: string;
  status: 'present' | 'absent' | 'excused' | 'unmarked';
  updatedAt?: string;
}

@Injectable()
export class AttendanceApiService {
  constructor(private readonly http: HttpClient) {}

  load(classId: string, date: string): Observable<AttendanceRowDto[]> {
    return this.http.get<AttendanceRowDto[]>(
      `/api/attendance/classes/${encodeURIComponent(classId)}`,
      { params: { date } },
    );
  }
}
```

Evite construir URLs com dado pessoal e nao trate IDs recebidos como autorizacao.

## Estado de tela

Modele estados explicitamente quando a pagina for assincrona:

```ts
type LoadState<T> =
  | { status: 'loading' }
  | { status: 'empty' }
  | { status: 'ready'; data: T }
  | { status: 'error'; message: string; correlationId?: string }
  | { status: 'forbidden' };
```

Uma pagina de edicao pode precisar ainda de:

- `saving`;
- `saved`;
- `conflict`;
- `offline`;
- `syncing`.

Nao transforme todo estado local em singleton. Estado simples permanece no componente; compartilhamento dentro da feature vai para facade/service RxJS.

## Formularios tipados

```ts
interface StudentForm {
  name: FormControl<string>;
  birthDate: FormControl<string | null>;
}

readonly form = new FormGroup<StudentForm>({
  name: new FormControl('', { nonNullable: true, validators: [Validators.required] }),
  birthDate: new FormControl<string | null>(null),
});
```

Mapeie o valor do formulario para o comando/DTO explicitamente. Mascara, moeda e data exibida nao devem contaminar o valor canonico.

## Fronteira de HTTP e erros

O alvo arquitetural preve:

- credenciais de sessao e anti-CSRF em interceptors;
- correlacao/`traceparent`;
- idioma e versao do cliente;
- Problem Details mapeado para servico central;
- erro de campo apresentado junto ao controle;
- conflito com recarregar/comparar;
- sessao perdida com reautenticacao segura;
- retry somente quando idempotente.

Nao implemente uma versao local e divergente desses mecanismos se o core ja os fornecer. Se ainda nao existirem e forem bloqueadores, isole uma interface/adapter pequeno e relate a dependencia.

## Sessao, contexto e permissao

O modelo preferido e sessao mediada pelo backend com cookie `HttpOnly`, `Secure` e `SameSite`. O browser recebe apenas identidade apresentada, contexto ativo, vinculos, permissoes, flags e preferencias necessarias.

Regras:

- nao armazenar access/refresh token em `localStorage`;
- troca de tenant/unidade e operacao do backend;
- limpar caches/rascunhos ao mudar contexto;
- menu e guard usam capacidade/permissao para UX;
- backend autoriza cada operacao;
- 403 e diferente de 404.

## Uso tecnico do catalogo UX

Reaproveite:

- shell e grid;
- breadcrumb e cards;
- classes semanticas de botoes, inputs, badges e alertas;
- `btn-loading`, desde que sua API atenda ao fluxo;
- ng-bootstrap ja configurado;
- ECharts e `echartStyles`;
- form wizard apos revisar sua acessibilidade/API.

Nao reaproveite como arquitetura final:

- `InMemoryWebApiModule`/`InMemoryDataService`;
- `DataLayerService` mock;
- arrays locais de notificacao/menu como fonte oficial;
- `CountryService` como client de backend;
- `AuthService` e `AuthGaurd` demonstrativos;
- `any`, untyped forms e subscriptions sem cleanup;
- `setTimeout` para simular request;
- strings/lorem ipsum/assets demo.

## Testes proporcionais ao risco

| Elemento | Teste recomendado |
| --- | --- |
| Validator/mapeamento | unitario |
| Facade e estados | unitario com observables controlados |
| Client HTTP | mock no limite HTTP/contrato |
| Componente de formulario | estados, eventos, erros e foco |
| Tabela/grade | teclado, selecao, filtros, vazio e paginacao |
| Jornada critica | Playwright quando a infraestrutura existir |
| Acessibilidade | automatizado + revisao manual |

Nao misture migracao geral de runner de testes com uma feature critica sem solicitacao explicita.

## Validacao de conclusao

1. Rode `npm run build` em `frontend/`.
2. Rode specs focadas quando executaveis.
3. Verifique pelo menos um viewport desktop e um pequeno relevante.
4. Navegue por teclado pela acao principal, formulario, tabela e modal.
5. Simule loading, vazio, erro, 403 e resposta lenta conforme aplicavel.
6. Confirme que logs, URL e analytics nao contem dados sensiveis.
7. Confirme que a rota demo nao foi publicada como feature.
