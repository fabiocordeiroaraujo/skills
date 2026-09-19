# Breadcrumbs, tabs, title, img e wizard

## br-breadcrumbs

- Seletor: `br-breadcrumbs`
- Import: `GovBrBreadcrumbsModule`

Inputs:

- `homeTip`
- `home`, default `['/']`
- `homeName`
- `maxItems`

Modelo `BrBreadcrumbDef` para `Route.data.breadcrumb`:

- `label`
- `url`
- `target`
- `disabled`
- `tip`

Exemplos de rota:

```ts
{
  path: 'solicitacoes',
  loadChildren: () => import('./solicitacoes/solicitacoes.module').then(m => m.SolicitacoesModule),
  data: { breadcrumb: 'Solicitacoes' },
}
```

```ts
{
  path: 'externo',
  component: ExternoComponent,
  data: {
    breadcrumb: { label: 'Documentação', url: 'https://exemplo.gov.br', target: '_blank' },
  },
}
```

`BreadcrumbsService`:

- `setRoute(route: ActivatedRouteSnapshot)`
- `getBreadcrumbs(): Observable<Breadcrumbs>`
- `resetBreadrumbs(breadcrumbs: Breadcrumbs)`

## br-tab-set e br-tab

- Imports: `GovBrTabModule`
- Seletor container: `br-tab-set`
- Seletor item: `br-tab`

`br-tab-set`:

- Input: `second-tab` alias público, default `true`.
- Output: `activeChange: TabComponent`.

`br-tab`:

- Inputs: `name`, `link`, `icon`, `header`.

Exemplo:

```html
<br-tab-set (activeChange)="abaAtiva = $event">
  <br-tab name="Dados">
    Conteúdo da aba Dados
  </br-tab>
  <br-tab name="Histórico" icon="fas fa-clock">
    Conteúdo da aba Histórico
  </br-tab>
</br-tab-set>
```

## br-second-tab-set e br-second-tab

- Import: `GovBrSecondTabModule`
- Seletores: `br-second-tab-set`, `br-second-tab`.
- `br-second-tab` tem input `name`.

Use para abas secundarias quando houver uma segunda camada de organizacao dentro da tela.

## br-vertical-tab-set e br-vertical-tab

- Import: `GovBrVerticalTabModule`
- Seletores: `br-vertical-tab-set`, `br-vertical-tab`.
- `br-vertical-tab` inputs/model: `name`, `active`, `disabled`.

## br-title

- Seletor: `br-title`
- Import: `GovBrTitleModule`
- Inputs: `title`, `subtitle`, `info`, `info2`.

Exemplo:

```html
<br-title title="Solicitações" subtitle="Consulta e manutenção"></br-title>
```

## br-img

- Seletor: `br-img`
- Import: `GovBrImgModule`
- Inputs: `blob` default `true`, `alt` default `''`, `class`, `errorClass`, `src`.

`class` é alias público de `className`.

## br-wizard e br-wizard-step

- Import: `GovBrWizardModule`
- Seletores: `br-wizard`, `br-wizard-step`.

`br-wizard` inputs:

- `layout: 'vertical' | 'horizontal'`, default `horizontal`
- `collapsed` default `true`
- `scroll` default `false`
- `skipDisableds` default `false`

`br-wizard-step` inputs/model:

- `info`
- `showHeader` default `true`
- `active` model default `false`
- `disabled` model default `false`
- `statusIcon`
- `fullContent` default `false`

Exemplo:

```html
<br-wizard layout="horizontal" [collapsed]="false">
  <br-wizard-step info="Dados" [(active)]="passoDados">
    Dados básicos
  </br-wizard-step>
  <br-wizard-step info="Confirmação" [(disabled)]="passoConfirmacaoDesabilitado">
    Revisão
  </br-wizard-step>
</br-wizard>
```

## Cuidados

- Não misture containers e itens de famílias diferentes de tabs.
- Para `br-tab-set`, o input com hífen é `[second-tab]`, não `[secondTab]` no template.
- `br-img` é exportado publicamente; valide se o modulo agregador da sua aplicacao ja o importa.
- Use `br-wizard` quando a tarefa realmente tiver passos sequenciais.
