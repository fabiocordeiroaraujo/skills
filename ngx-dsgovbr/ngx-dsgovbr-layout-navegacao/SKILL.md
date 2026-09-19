---
name: ngx-dsgovbr-layout-navegacao
description: "Monta e corrige layout, navegação e estrutura de aplicação com @serpro/ngx-dsgovbr. Use quando o usuário pedir br-main-layout, br-header, br-footer, br-side-menu, br-breadcrumbs, menu lateral, usuário autenticado, módulos do header, notificações no header, breadcrumbs por rota, abas br-tab/br-second-tab/br-vertical-tab, br-title, br-img ou br-wizard."
---

# ngx-dsgovbr layout e navegacao

## Quando usar

Use esta skill para montar a casca de uma aplicação GovBR: header, menu, breadcrumbs, footer, tabs, wizard e objetos de domínio como `Application`, `Menu`, `MenuItem` e `User`.

## Guia rapido

Leia:

- `references/layout-header-menu.md` para `br-main-layout`, `br-header`, `br-side-menu`, footer e modelos.
- `references/tabs-breadcrumbs.md` para breadcrumbs, tabs, title, img e wizard.

Exemplo mínimo de shell autenticado:

`shell.component.ts`

```ts
import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { GovBrMainLayoutModule, Application, User } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrMainLayoutModule, RouterOutlet],
  templateUrl: './shell.component.html',
})
export class ShellComponent {
  user = new User('Maria Silva', 'maria@example.gov.br');
  application: Application = {
    name: 'Sistema Exemplo',
    version: '1.0.0',
    menu: { itens: [{ label: 'Início', action: '/home', icon: 'fas fa-home' }] },
    footer: { show: true, theme: '1' },
  };
  sair() {}
  onMenu(_item: unknown) {}
}
```

`shell.component.html`

```html
<br-main-layout
  [application]="application"
  [user]="user"
  (logout)="sair()"
  (menuItemClick)="onMenu($event)">
  <router-outlet></router-outlet>
</br-main-layout>
```

## Decisoes importantes

- `br-main-layout` exige `application`; esse input é `input.required<Application>()`.
- Para exemplos de componentes, prefira `templateUrl` e mostre o HTML em arquivo `.component.html`; evite colocar HTML em `template` inline dentro do `.ts`, salvo quando o projeto consumidor já seguir esse padrão.
- `br-header` e `br-main-layout` têm `showMenu` como `model<boolean>`, então `[(showMenu)]` é válido.
- O input público do logo no header/menu é `logoUrl`, mesmo que o nome interno seja `logoImgUrl`.
- Breadcrumbs são alimentados por `Route.data.breadcrumb` e pelo `BreadcrumbsService`; use string simples ou objeto com `label`, `url`, `target`, `disabled`, `tip`.
- `br-notifications` pertence ao header e também aparece na skill de feedback quando o foco for ações/notificações.

## Validacao

Antes de entregar:

- Modelos (`Application`, `Menu`, `MenuItem`, `User`) foram importados de `@serpro/ngx-dsgovbr`.
- Menus usam `itens`, nao `items`.
- O objeto `Application` tem ao menos `name` e `version`.
- Rotas com breadcrumbs usam `data: { breadcrumb: '...' }` ou objeto compatível.
- Tabs usam o par correto de container e item: `br-tab-set`/`br-tab`, `br-second-tab-set`/`br-second-tab`, `br-vertical-tab-set`/`br-vertical-tab`.
