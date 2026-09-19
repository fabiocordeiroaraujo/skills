# Layout, header, menu e footer

## Indice

- `br-main-layout`: shell completo da aplicacao.
- Modelo `Application`: menu, módulos, quick links, sessão e footer.
- `br-header`: uso isolado do header.
- `br-side-menu`: menu lateral isolado e estrutura de `Menu`.
- `br-footer`, notificações e serviços relacionados.

## br-main-layout

- Seletor: `br-main-layout`
- Import: `GovBrMainLayoutModule`
- Input obrigatório: `application: Application`.

Inputs e outputs:

| Nome | Tipo/default | Uso |
| --- | --- | --- |
| `application` | `Application`, obrigatório | Dados da aplicação, menu, footer, sessão. |
| `logoRoute` | `string[]`, default `['/']` | Rota do logo. |
| `logoUrl` | `any` | Imagem do logo. |
| `breadCrumbHome` | `model<string | string[] | undefined>` | Rota home do breadcrumb. |
| `breadCrumbHomeTip` | `string | null` | Tooltip home. |
| `user` | `User` | Usuário logado. |
| `showNotifications` | `boolean`, default `false` | Mostra notificações. |
| `showSessionTime` | `boolean`, default `true` | Timer de sessão. |
| `notificationsRoute` | `any` | Rota de notificações. |
| `mostrarBarraBrasil` | `boolean`, default `true` | Barra Brasil. |
| `showSearch` | `boolean`, default `false` | Busca no header. |
| `showMenu` | `model<boolean>`, default `true` | Menu visível. |
| `userMenuTemplate` | `TemplateRef<any>` | Menu usuário customizado. |
| `customSignInContent` | `TemplateRef<any>` | Conteúdo login customizado. |
| `customAvatarContent` | `TemplateRef<any>` | Avatar customizado. |
| `mediaQueryBreakpoints` | `any[]` | Breakpoints. |

Outputs:

- `sessionTime: SessionEvent`
- `logout: boolean`
- `login: boolean`
- `search: string`
- `searchSubmit: string`
- `showCookieClick: void`
- `menuItemClick: MenuItem`

Exemplo:

```html
<br-main-layout
  [application]="application"
  [user]="user"
  [showSearch]="true"
  (searchSubmit)="buscar($event)"
  (logout)="logout()">
  <router-outlet></router-outlet>
</br-main-layout>
```

Exemplo completo de componente standalone:

`shell.component.ts`

```ts
import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import {
  Application,
  GovBrMainLayoutModule,
  Menu,
  MenuItem,
  Module,
  User,
} from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrMainLayoutModule, RouterOutlet],
  templateUrl: './shell.component.html',
})
export class ShellComponent {
  user = new User('Maria Silva', 'maria.silva@orgao.gov.br');

  modules: Module[] = [
    { name: 'cadastro', displayName: 'Cadastro', route: '/cadastro', icon: 'fas fa-address-card' },
    { name: 'relatorios', displayName: 'Relatórios', route: '/relatorios', icon: 'fas fa-chart-bar' },
    { name: 'govbr', displayName: 'Gov.br', url: 'https://www.gov.br', icon: 'fas fa-external-link-alt' },
  ];

  menu: Menu = {
    showFilter: true,
    collapsible: true,
    bestMatchActive: true,
    itens: [
      { label: 'Início', action: '/inicio', icon: 'fas fa-home' },
      {
        label: 'Cadastros',
        icon: 'fas fa-folder-open',
        itens: [
          { label: 'Pessoas', action: '/cadastros/pessoas', icon: 'fas fa-user' },
          { label: 'Unidades', action: '/cadastros/unidades', icon: 'fas fa-building' },
        ],
      },
      { label: 'Ajuda externa', url: 'https://www.gov.br/ds', target: '_blank', icon: 'fas fa-question-circle' },
    ],
  };

  application: Application = {
    name: 'Sistema Exemplo',
    version: '1.0.0',
    menu: this.menu,
    modules: this.modules,
    currentModule: this.modules[0],
    headerType: 'standard',
    headerSign: 'Ambiente de Homologação',
    headerDensity: 'small',
    sessionTotalTime: 30,
    sessionWarningTime: 25,
    quickLinks: [
      { label: 'Portal', url: 'https://www.gov.br', icon: 'fas fa-external-link-alt' },
      { label: 'Suporte', routerLink: '/suporte', icon: 'fas fa-life-ring' },
    ],
    footer: {
      show: true,
      theme: '1',
      categories: [
        {
          label: 'Institucional',
          items: [
            { label: 'Sobre', url: '/sobre' },
            { label: 'Contato', url: '/contato' },
          ],
        },
      ],
      legalInfo: '© Governo Federal',
    },
  };

  buscar(termo: string) {}
  onMenuItem(item: MenuItem) {}
  logout() {}
}
```

`shell.component.html`

```html
<br-main-layout
  [application]="application"
  [user]="user"
  [showSearch]="true"
  [showNotifications]="true"
  (searchSubmit)="buscar($event)"
  (menuItemClick)="onMenuItem($event)"
  (logout)="logout()">
  <router-outlet></router-outlet>
</br-main-layout>
```

## Modelo Application

Campos:

- `name: string`
- `version: string`
- `menu?: Menu`
- `withoutAuthentication?: boolean`
- `modules?: Module[]`
- `currentModule?: Module`
- `sessionTotalTime?: number`
- `sessionWarningTime?: number`
- `ssoSystem?: string`
- `quickLinks?: BrQuickLink[]`
- `headerType?: 'standard' | 'compact' | 'none'`
- `fixedWidth?: boolean`
- `headerSign?: string`
- `headerDensity?: 'small' | 'large'`
- `headerSticky?: boolean`
- `showCookieButton?: boolean`
- `showHighContrastButton?: boolean`
- `footer?: BrFooter`
- `hideBreadCrumbs?: boolean`
- `headerActionTpl?: TemplateRef<any>`

`BrFooter`:

- `show: boolean`
- `logoUrl?: string`
- `theme: '1' | '2'`
- `categories?: BrFooterCategory[]`
- `partners?: BrPartner[]`
- `socialMedia?: BrSocialMedia`
- `contactInfo?: BrContactInfo[]`
- `legalInfo?: string`

## br-header

- Seletor: `br-header`
- Import: `GovBrHeaderModule`

Inputs:

- `application`
- `logoRoute` default `['/']`
- `logoUrl`
- `showMenu` model default `false`
- `showNotifications` default `false`
- `notificationsRoute`
- `user`
- `passwordUrl`
- `profileUrl`
- `showSearch` default `false`
- `userMenuTemplate`
- `customSignInContent`
- `customAvatarContent`
- `mostrarBarraBrasil` default `false`

Outputs:

- `logout`, `login`, `search`, `searchSubmit`, `showCookieClick`, `moduleChange`.

Use `br-header` isolado quando a app não usa `br-main-layout`.

Exemplo de `br-header` isolado:

`header-isolado.component.ts`

```ts
import { Component } from '@angular/core';
import { Application, GovBrHeaderModule, User } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrHeaderModule],
  templateUrl: './header-isolado.component.html',
})
export class HeaderIsoladoComponent {
  user = new User('Admin', 'admin@orgao.gov.br');

  application: Application = {
    name: 'Sistema Exemplo',
    version: '1.0.0',
    headerSign: 'Componentes Angular',
    headerType: 'standard',
    headerDensity: 'small',
    showHighContrastButton: true,
    quickLinks: [{ label: 'Portal Gov.br', url: 'https://www.gov.br', icon: 'fas fa-external-link-alt' }],
  };

  buscar(termo: string) {}
  logout() {}
}
```

`header-isolado.component.html`

```html
<br-header
  [user]="user"
  [application]="application"
  [showSearch]="true"
  [showNotifications]="true"
  logoUrl="assets/images/govbr-logo.png"
  (searchSubmit)="buscar($event)"
  (logout)="logout()">
</br-header>
```

## br-side-menu

- Seletor: `br-side-menu`
- Import: `GovBrMenuModule`

Inputs:

- `logoUrl`
- `menu: Menu`
- `user: User`

Output:

- `itemClick: MenuItem | null`

`Menu`:

- `overlay`
- `showFilter` default efetivo `true`
- `closeOnSelect`
- `closeOthersItensOnExpand`
- `drilldownLevel` default efetivo `2`
- `itens: MenuItem[]`
- `collapsible` default efetivo `true`
- `bestMatchActive`
- `collapsedLabelLen`
- `footer`

`MenuItem`:

- `id`
- `label`
- `action`
- `url`
- `target`
- `icon`
- `itens`
- `expandido`
- `auth`
- `roleNames`
- `parent`
- `badge`
- `badgeIcon`
- `disabled`
- `description`
- `activeOptions`
- `queryParams`

Cuidados:

- A propriedade da lista é `itens`, não `items`.
- Use `action` para rota Angular e `url` para link externo.
- `bestMatchActive` marca o item cujo `action` é o maior prefixo da URL.

Exemplo de `br-side-menu` isolado:

`side-menu.component.ts`

```ts
import { Component } from '@angular/core';
import { GovBrMenuModule, Menu, MenuItem, NotifyActionService, User } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrMenuModule],
  templateUrl: './side-menu.component.html',
})
export class SideMenuComponent {
  user = new User('Admin', 'admin@orgao.gov.br');

  menu: Menu = {
    showFilter: true,
    closeOnSelect: true,
    collapsible: true,
    bestMatchActive: true,
    itens: [
      { label: 'Início', action: '/inicio', icon: 'fas fa-home' },
      {
        label: 'Administração',
        icon: 'fas fa-cog',
        itens: [
          { label: 'Usuários', action: '/admin/usuarios', roleNames: ['ROLE_ADMIN'] },
          { label: 'Perfis', action: '/admin/perfis', roleNames: ['ROLE_ADMIN'] },
        ],
      },
      { label: 'Documentação', url: 'https://www.gov.br/ds', target: '_blank', icon: 'fas fa-book' },
    ],
  };

  constructor(private notifyActionService: NotifyActionService) {}

  onItemClick(item: MenuItem | null) {}

  atualizarBadge() {
    this.menu.itens[0].badge = '3';
    this.notifyActionService.action({ type: 'MenuChanged' });
  }
}
```

`side-menu.component.html`

```html
<br-side-menu
  [user]="user"
  [menu]="menu"
  (itemClick)="onItemClick($event)">
</br-side-menu>
```

## br-footer

- Seletor: `br-footer`
- Import: `GovBrFooterModule`
- Inputs: `footer: BrFooter`, `fixedWidth` default `false`.

Pode ser usado dentro de `Application.footer` no `br-main-layout` ou isoladamente.

## br-notifications no header

- Seletor: `br-notifications`
- Import: vem de `GovBrHeaderModule`.
- Inputs: `route`, `icon` default `fas fa-envelope`, `user`, `showNotifications`.
- Outputs: `logout`, `close`.
- Dados são alimentados por `NotificationService`.

## Servicos relacionados

- `UserService`: `setUser(user)` e `getUser(): Observable<User>`.
- `NotificationService`: `update(unread)`, `updateNotifications(notifications)`, `notifications$`, `getUnreadNotificationsAmount$()`.
- `SessionTimeService`: usado por `br-main-layout` para `sessionTotalTime` e `sessionWarningTime`.
- `MediaBreakpointService`: emite mudanças para breakpoints configurados.
