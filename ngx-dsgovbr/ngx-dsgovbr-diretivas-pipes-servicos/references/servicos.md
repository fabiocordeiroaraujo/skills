# Servicos publicos

## Indice

- Defaults e mensagens: `DefaultsService`, `AlertMessageService`.
- Erros HTTP e legado: `ApiErrorHandlerService`, `HttpErrorHandler`, `HttpErrorTranslator`.
- Autenticação: `TokenService`, `AppendTokenInterceptor`, `AuthGuard`.
- Comunicação transversal: `NotifyActionService`, `UserService`, `NotificationService`, `BreadcrumbsService`, `SessionTimeService`, `MediaBreakpointService`.
- Receita completa: configuração standalone com interceptor/guard e serviço de login.

## DefaultsService

Serviço global de rótulos, mensagens e defaults.

Campos principais:

- `openAlertResourcesInNewWindow = true`
- `labelOptional = "(Opcional)"`
- `labelRequired = "(Obrigatório)"`
- `requiredStrategy: 'Flag When Required' | 'Flag When Optional'`
- `messages`: required, invalid, min/max length, date, decendio, min/max date, email, cnpj, cpf, fileType, fileSize, maxFiles, forbidden, unauthenticated.
- `labels.table.filter.row` e `labels.table.filter.col`
- `loginUrl = '/login'`
- `paginationMaxPagesSlots = 10`
- `showValidFeedbackBorders`
- `showPartialValidationErros`
- `breadcrumbs.maxLabelLength = 25`

Exemplo:

```ts
constructor(defaults: DefaultsService) {
  defaults.messages.required = ':label não informado';
  defaults.requiredStrategy = 'Flag When Optional';
}
```

## AlertMessageService

Use com `br-alert-messages`. Métodos:

- `success`, `info`, `warn`, `error`
- `apiError`
- `dismiss`, `dismissAll`
- `pushAll`
- `getMessages$`
- `onMessageClicked`, `onShowMore`

## ApiErrorHandlerService

Status:

- `ApiError` está marcado como deprecated; o comentário recomenda `AlertMessageService.error(...)`.

Uso:

- `handle(noMsgsFor?: number[])` retorna função para `catchError`.
- Traduz 401, 403, 409 e erros de validação em `AlertMessage[]`.
- `Resource` representa detalhe navegável: `new Resource(name, path?, clickable?)`.

## HttpErrorHandler e HttpErrorTranslator

`HttpErrorHandler` está marcado como deprecated no código. Mantém eventos:

- `subscribeToError(callback)`
- `subscribeToBusinessMessages(callback)`
- `handle(response)`

`HttpErrorTranslator`:

- `managedStatusCodes`
- `translate(response, severity)`
- `lookupMessage(statusCode)`

Use apenas para legado. Para telas novas, prefira `AlertMessageService` e tratamento HTTP próprio da aplicação.

## TokenService

Dependência: `jwt-decode`.

Tipos:

- `StoragePersistenceType = 'local' | 'session'`
- `TokenPayload { sub, exp, roles, transactions? }`

API:

- `storagePersistenceType`
- `tokenChanged$`
- `loadToken(): boolean`
- `store(token: string)`
- `get(): string`
- `isAuthenticated()`
- `roles: string[]`
- `transactions: string[]`

Comportamento:

- Armazena em `localStorage` por padrão.
- Remove token se `store` receber valor vazio.
- Atualiza `SessionTimeService` com `exp`.

## AppendTokenInterceptor

- Adiciona header `Authorization: Bearer <token>` se `TokenService.get()` retornar token.
- Se a resposta HTTP vier com header `Authorization`, armazena o novo token removendo prefixo `BEARER `.

Exemplo de provider em app moderna:

```ts
import { HTTP_INTERCEPTORS } from '@angular/common/http';
import { AppendTokenInterceptor } from '@serpro/ngx-dsgovbr';

providers: [
  { provide: HTTP_INTERCEPTORS, useClass: AppendTokenInterceptor, multi: true },
]
```

## AuthGuard

Verifica:

- `TokenService.isAuthenticated()`
- `route.data.roles`
- `route.data.transactions`

Se não autenticado:

- Navega para `DefaultsService.loginUrl` com `nextRoute`, se configurado.
- Emite mensagem `unauthenticated`.

Se sem permissão:

- Emite mensagem `forbidden`.

Exemplo:

```ts
{
  path: 'admin',
  canActivate: [AuthGuard],
  data: { roles: ['ADMIN'] },
  loadComponent: () => import('./admin.component').then(m => m.AdminComponent),
}
```

## NotifyActionService

Tipos:

- `ActionType = 'MenuChanged' | 'HideMenu' | 'CollapseMenu'`
- `Action { type, args? }`

API:

- `action$`
- `action(a: Action)`

Usado pelo menu para reagir a mudanças/colapso.

## UserService

- `setUser(user: User)`
- `getUser(): Observable<User>`

## NotificationService

- `notifications$`
- `getUnreadNotificationsAmount$()`
- `update(unreadNotifications)`
- `updateNotifications(notifications)`

## BreadcrumbsService

- `setRoute(route: ActivatedRouteSnapshot)`
- `getBreadcrumbs(): Observable<Breadcrumbs>`
- `resetBreadrumbs(breadcrumbs: Breadcrumbs)`

Interpreta `route.data.breadcrumb` como string, objeto ou função.

## SessionTimeService

- `sessionTime$`
- `init(sessionTotalTimeMinutes, sessionWarningTimeMinutes)`
- `reset(expirationTimeSeconds?)`
- `stop()`
- `getSessionTime()` compatibilidade.

Eventos: `'warning'`, `'expired'` ou string formatada `mm:ss`.

## MediaBreakpointService

- `config(breakpoints: number[]): Observable<MediaBreakpointEvent>`
- `reset()`

Regra:

- Breakpoint positivo: match quando `innerWidth >= breakpoint`.
- Breakpoint negativo: match quando `innerWidth < abs(breakpoint)`.

## Servicos auxiliares de componentes

Exportados indiretamente por componentes:

- `BreadcrumbsService`
- `NotificationService`
- `UserService`
- `SessionTimeService`
- `MediaBreakpointService`
- Serviços de exportação da tabela: `GovBrCSVService`, `GovBrPDFService`, `GovBrSortService`, `GovBrTXTService`, `GovBrXLSService`, `GovBrXMLService`.

Normalmente aplicações consomem `AlertMessageService`, `DefaultsService`, `TokenService`, `AuthGuard`, `AppendTokenInterceptor`, `BreadcrumbsService`, `NotificationService` e `UserService`; serviços internos de tabela só são necessários para customização avançada.

## Receita completa: autenticação, token e mensagens

Exemplo de configuração em aplicação standalone com interceptor e guard:

```ts
import { ApplicationConfig } from '@angular/core';
import { provideRouter, Routes } from '@angular/router';
import { HTTP_INTERCEPTORS, provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { AppendTokenInterceptor, AuthGuard } from '@serpro/ngx-dsgovbr';

export const routes: Routes = [
  {
    path: 'admin',
    canActivate: [AuthGuard],
    data: { roles: ['ROLE_ADMIN'] },
    loadComponent: () => import('./admin.component').then(m => m.AdminComponent),
  },
];

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(routes),
    provideHttpClient(withInterceptorsFromDi()),
    { provide: HTTP_INTERCEPTORS, useClass: AppendTokenInterceptor, multi: true },
  ],
};
```

Exemplo de serviço de login usando `TokenService` e `AlertMessageService`:

```ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AlertMessageService, TokenService, UserService, User } from '@serpro/ngx-dsgovbr';
import { tap } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class LoginService {
  constructor(
    private http: HttpClient,
    private tokenService: TokenService,
    private userService: UserService,
    private alerts: AlertMessageService,
  ) {}

  login(credenciais: { login: string; senha: string }) {
    return this.http.post<{ token: string; nome: string; email: string }>('/api/login', credenciais)
      .pipe(
        tap(response => {
          this.tokenService.store(response.token);
          this.userService.setUser(new User(
            response.nome,
            response.email,
            this.tokenService.roles.map(name => ({ name, description: name })),
          ));
          this.alerts.success('Login realizado', `Bem-vindo, ${response.nome}.`);
        }),
      );
  }

  logout() {
    this.tokenService.store('');
    this.alerts.info('Sessão encerrada');
  }
}
```
