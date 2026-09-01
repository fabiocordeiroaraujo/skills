# Layouts, rotas e menu UX

## Mapa do shell

| Responsabilidade | Arquivo |
| --- | --- |
| Definicao dos shells e lazy routes | `frontend/src/app/app-routing.module.ts` |
| Shell autenticado | `frontend/src/app/shared/components/layouts/admin-layout-sidebar-compact/` |
| Header autenticado | `.../header-sidebar-compact/` |
| Sidebar e submenu | `.../sidebar-compact/` |
| Layout de sessao | `frontend/src/app/shared/components/layouts/auth-layout/` |
| Layout sem chrome | `frontend/src/app/shared/components/layouts/blank-layout/` |
| Declaracao dos layouts | `frontend/src/app/shared/components/layouts/layouts.module.ts` |
| Modelo e itens de menu atuais | `frontend/src/app/shared/services/navigation.service.ts` |
| Estilos da sidebar compacta | `frontend/src/assets/styles/app/globals/layouts/sidebar-compact/` |
| Breadcrumb | `frontend/src/assets/styles/app/globals/components/_breadcrumb.scss` |

## Arvore atual de rotas

```text
AppRoutingModule
|-- AuthLayoutComponent
|   `-- sessions/*
|-- BlankLayoutComponent
|   `-- others/*
`-- AdminLayoutSidebarCompactComponent + AuthGaurd
    |-- dashboard/*
    |-- uikits/*
    |-- forms/*
    |-- invoice/*
    |-- inbox/*
    |-- calendar/*
    |-- chat/*
    |-- contacts/*
    |-- tables/*
    |-- pages/*
    `-- icons/*
```

As rotas demonstrativas devem ser removidas gradualmente. Nao use a taxonomia `uikits`, `forms` ou `tables` para features de produto; prefira o dominio, por exemplo `attendance`, `enrollment` ou `finance`.

## Estrutura-alvo

O requisito tecnico define:

```text
src/app/
  core/
  layouts/
    authenticated/
    public/
    operational/
  shared/
  features/
    attendance/
    enrollment/
    finance/
    ...
```

Enquanto a migracao nao move os shells para `layouts/`, integre com os componentes existentes. Nao duplique o layout apenas para satisfazer a estrutura-alvo.

## Registro de uma feature lazy

No roteamento raiz, mantenha apenas o limite da feature:

```ts
{
  path: 'attendance',
  loadChildren: () =>
    import('./features/attendance/attendance.module')
      .then((m) => m.AttendanceModule),
}
```

No routing module da feature:

```ts
const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'daily' },
  { path: 'daily', component: AttendanceDailyPageComponent },
  { path: ':classId', component: AttendanceClassPageComponent },
];
```

Inclua metadados de capacidade/permissao quando o core correspondente existir. Nunca trate a presenca da rota ou do item de menu como autorizacao suficiente.

## Modelo de menu atual

`NavigationService` publica `IMenuItem[]` em um `BehaviorSubject`. Tipos aceitos:

- `link`: navega diretamente;
- `dropDown`: abre painel secundario e pode conter `sub` recursivo;
- `extLink`: abre URL externa.

Exemplo atual:

```ts
{
  name: 'Academico',
  description: 'Rotinas academicas e registros.',
  type: 'dropDown',
  icon: 'i-Student-Hat-2',
  sub: [
    {
      name: 'Frequencia',
      state: '/attendance/daily',
      type: 'link',
      icon: 'i-Checked-User',
    },
  ],
}
```

No produto final, filtre ou construa esses itens a partir de capacidades habilitadas e permissoes efetivas. Nao crie listas separadas e rigidas por perfil como “menu de professor”.

## Comportamento do shell autenticado

`AdminLayoutSidebarCompactComponent` monta:

```html
<div class="app-admin-wrap layout-sidebar-compact ...">
  <app-sidebar-compact></app-sidebar-compact>
  <div class="main-content-wrap d-flex flex-column">
    <app-header-sidebar-compact></app-header-sidebar-compact>
    <div class="main-content"><router-outlet /></div>
    <app-footer></app-footer>
  </div>
</div>
```

O componente observa eventos de lazy loading e exibe `spinner-bubble-primary`. A sidebar fecha ao navegar em mobile. Preserve essas responsabilidades no shell, nao na pagina.

Dimensoes atuais em `_vars.scss`:

- topbar desktop: `80px`;
- topbar mobile: `70px`;
- sidebar principal: `76px`;
- sidebar secundaria: `220px`;
- margem lateral de abertura: `20px`.

## Header

O header demonstra logo, busca, notificacoes, fullscreen e menu do usuario. Para o Haggyo:

- substitua mega menu e links demo por acoes reais ou remova-os;
- conecte busca global somente quando houver escopo e contrato definidos;
- derive notificacoes do backend, sem arrays mockados;
- associe avatar e menu a sessao/contexto;
- mantenha nomes acessiveis nos icones clicaveis;
- nao persista token no browser para alimentar o header.

## Breadcrumb

O padrao UX usa `div.breadcrumb > h1 + ul` e `separator-breadcrumb border-top`. Preserve essa aparencia, mas melhore semantica e navegacao:

- use `routerLink` no ancestral navegavel;
- marque a pagina atual com `aria-current="page"`;
- nao use `href=""`;
- mantenha um unico `h1` que descreva a pagina.

## Padroes exemplares

- Scaffold de pagina: quase todas as telas em `frontend/src/app/views/ui-kits/`.
- Dashboard em grade: `frontend/src/app/views/dashboard/dashboad-default/`.
- Pagina densa com sidebar interna: `frontend/src/app/views/inbox/` e `chat/`; reuse apenas quando a jornada realmente precisar de master-detail.
- Sessao publica: `frontend/src/app/views/sessions/`.
- 404 sem chrome: `frontend/src/app/views/others/not-found/`.

## Armadilhas do template

- O guard atual chama-se `AuthGaurd` e e demonstrativo; nao o trate como seguranca real.
- O roteador usa `useHash: true`; nao altere essa estrategia incidentalmente em uma feature.
- O menu atual contem lorem ipsum e links de demo.
- O header usa imagens/nome mockados e elementos clicaveis em `<i>`.
- As rotas atuais misturam catalogo visual e produto; mantenha novas features isoladas.
