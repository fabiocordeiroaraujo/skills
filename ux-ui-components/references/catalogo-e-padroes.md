# Catalogo de componentes e padroes UX

## Dependencias disponiveis

| Biblioteca | Versao no projeto | Uso |
| --- | --- | --- |
| Bootstrap | 5.3.2 | grade, utilitarios e primitives visuais |
| `@ng-bootstrap/ng-bootstrap` | 18.x | modal, dropdown, alert, pagination, datepicker, accordion, tabs, progress |
| `ngx-toastr` | 19.x | feedback global breve |
| `ngx-echarts` / ECharts | 19.x / 5.5 | graficos |
| `angular-calendar` | 0.31 | calendario |
| `ngx-mask` | 17.x | mascara de entrada |
| `ngx-pagination` | 6.x | paginacao do exemplo list/grid |
| `ngx-scrollbar` | 15.x | areas rolaveis do shell/apps |

Antes de adicionar outra biblioteca, confirme que essas primitives nao resolvem a necessidade.

## Botoes e loading

Fontes:

- estilos: `frontend/src/assets/styles/app/globals/components/_button.scss`;
- componente: `frontend/src/app/shared/components/btn-loading/`;
- exemplos: `frontend/src/app/views/ui-kits/buttons/` e `buttons-loading/`.

Uso atual:

```html
<btn-loading
  btnClass="btn-primary btn-rounded"
  [loading]="saving"
  loadingText="Salvando..."
  type="submit">
  Salvar
</btn-loading>
```

O componente atual desabilita o `<button>` e usa `.btn-spinner`. Ao evolui-lo, preserve compatibilidade de inputs ou migre consumidores no mesmo change. Adicione `aria-busy`, anuncio de estado e suporte claro a nome acessivel se a tarefa exigir robustez maior.

Nao dependa do `(click)` no elemento host `btn-loading` para controlar uma submissao; prefira o evento do formulario ou uma API de output explicita.

## Formularios e controles

Fontes:

- estilos: `_form.scss`;
- examples: `views/forms/basic-form/`, `form-layouts/`, `input-groups/`, `input-mask/`;
- imports: `views/forms/forms.module.ts`.

Classes UX principais:

- `.form-group` com label menor e margem inferior;
- `.form-control` com fundo `gray-100` e borda `gray-400`;
- `.form-control-rounded` para acabamento pill;
- `.checkbox.checkbox-<status>` e `.checkbox-outline-<status>`;
- `.radio.radio-<status>` e `.radio-outline-<status>`;
- `.switch.switch-<status>`.

Padrao recomendado para codigo novo:

```html
<form [formGroup]="form" (ngSubmit)="submit()" novalidate>
  <div class="form-group mb-3">
    <label for="student-name">Nome do aluno</label>
    <input
      id="student-name"
      class="form-control"
      formControlName="name"
      autocomplete="name"
      [class.is-invalid]="name.invalid && name.touched"
      aria-describedby="student-name-error" />
    @if (name.invalid && name.touched) {
      <div id="student-name-error" class="invalid-feedback">
        Informe o nome do aluno.
      </div>
    }
  </div>

  <btn-loading
    btnClass="btn-primary btn-rounded"
    [loading]="saving()"
    loadingText="Salvando...">
    Salvar
  </btn-loading>
</form>
```

Use `FormBuilder.nonNullable`/forms tipados quando compativel com o codigo da feature. Nao replique `UntypedFormGroup` dos demos.

## Wizard e etapas

Fontes:

- modulo: `frontend/src/app/shared/components/form-wizard/form-wizard.module.ts`;
- componentes: `.../form-wizard/wizard/` e `wizard-step/`;
- uso: `frontend/src/app/views/forms/wizard/`.

API demonstrada:

```html
<form-wizard>
  <wizard-step
    [title]="'Dados basicos'"
    [isValid]="basicForm.valid"
    (onNext)="continue()">
    <!-- formulario -->
  </wizard-step>
  <wizard-step [title]="'Revisao'" (onComplete)="complete()">
    <!-- resumo -->
  </wizard-step>
</form-wizard>
```

Antes de usar em matricula ou financeiro, verifique foco entre etapas, anuncio da etapa atual, persistencia de rascunho, retorno a etapa anterior e idempotencia na conclusao. O demo mistura template-driven e reactive forms; padronize a feature em reactive forms tipados.

## Tabelas, filtros e paginacao

Fontes:

- tabela Bootstrap: `frontend/src/app/views/data-tables/bootstrap-table/`;
- sort directive: `frontend/src/app/shared/directives/sortable.directive.ts`;
- estado demonstrativo: `frontend/src/app/shared/services/country.service.ts`;
- lista/grid: `frontend/src/app/views/data-tables/list-pagination/`;
- estilos de lista: `frontend/src/assets/styles/app/globals/views/_data-tables.scss`.

Composicao visual:

```html
<section class="card o-hidden mb-4" aria-labelledby="records-title">
  <div class="card-body border-bottom">
    <div class="d-flex flex-column flex-md-row gap-3 align-items-md-end">
      <!-- filtros com labels -->
    </div>
  </div>

  <div class="table-responsive">
    <table class="table table-hover mb-0">
      <!-- thead/tbody, loading/vazio -->
    </table>
  </div>

  <div class="d-flex flex-column flex-sm-row justify-content-between p-3">
    <ngb-pagination ... />
    <!-- page size/total -->
  </div>
</section>
```

Use `NgbdSortableHeader` apenas se sua API e acessibilidade forem adequadas; o exemplo aplica `role="button"` em `<th>`, mas uma implementacao robusta deve expor um botao focavel e `aria-sort`.

Lista/grid serve para entidades visuais com thumbnail ou resumo. Para registros administrativos densos, tabela ou lista responsiva costuma ser mais clara.

## Cards, KPIs e dashboards

Fontes:

- estilos: `_card.scss`;
- dashboard: `views/dashboard/dashboad-default/` e `dashboard-v2..v4/`;
- catalogos: `views/ui-kits/card-metrics/`, `card-widgets/`, `cards/`.

KPI basico:

```html
<div class="card card-icon-bg card-icon-bg-primary o-hidden mb-4">
  <div class="card-body text-center">
    <i class="i-Student-Hat-2" aria-hidden="true"></i>
    <div class="content">
      <p class="text-muted mt-2 mb-0">Alunos ativos</p>
      <p class="text-primary text-24 line-height-1 mb-2">1.248</p>
    </div>
  </div>
</div>
```

Forneca contexto temporal/unidade e nao transforme toda informacao em KPI. Metric cards devem responder a uma decisao ou monitoramento real.

## Badges e status

Fontes:

- `_badges.scss`;
- `views/ui-kits/badges/`.

Use `badge` com variante semantica e texto de estado. O template contem sintaxe antiga como `badge-primary` e `badge-pill`; como Bootstrap 5 usa `bg-primary` e `rounded-pill`, confirme qual classe e efetiva no build antes de copiar.

Exemplo robusto:

```html
<span class="badge bg-success rounded-pill">
  Ativo
</span>
```

## Alertas e Toastr

Fontes:

- estilos: `_alerts.scss`;
- exemplos: `views/ui-kits/alerts/`;
- configuracao global: `ToastrModule.forRoot()` em `shared.module.ts`.

Escolha:

- `ngb-alert alert-card`: erro, aviso ou regra contextual persistente;
- Toastr: confirmacao breve de sucesso/erro geral depois de uma acao;
- erro de campo: junto ao controle, nao em Toastr;
- indisponibilidade de pagina: estado completo dentro do conteudo.

Toastr nao deve conter documento, mensagem privada, dado financeiro detalhado ou outro dado pessoal desnecessario.

## Modais e confirmacao

Fontes:

- `frontend/src/app/views/ui-kits/modals/`;
- estilos: `_modals.scss`;
- API: `NgbModal`.

Estrutura:

```html
<ng-template #confirmDialog let-modal>
  <div class="modal-header">
    <h2 class="modal-title" id="confirm-title">Excluir registro</h2>
    <button class="btn-close" type="button" aria-label="Fechar"
      (click)="modal.dismiss('close')"></button>
  </div>
  <div class="modal-body">
    <p>Explique o objeto e o impacto da acao.</p>
  </div>
  <div class="modal-footer">
    <button class="btn btn-outline-secondary btn-rounded" type="button"
      (click)="modal.dismiss('cancel')">Cancelar</button>
    <btn-loading btnClass="btn-danger btn-rounded" [loading]="deleting">
      Excluir
    </btn-loading>
  </div>
</ng-template>
```

Abra com `ariaLabelledBy` apontando para o titulo. Para acao destrutiva, o foco inicial deve favorecer cancelar/fechar, nao confirmar automaticamente.

## Tabs, accordion, popover e dropdown

Exemplos em `views/ui-kits/accordions/`, `popover/` e demais UI kits. Use primitives ng-bootstrap, pois elas gerenciam comportamento e boa parte do teclado.

- Tabs separam visoes equivalentes, nao etapas obrigatorias.
- Accordion reduz conteudo secundario, mas nao esconda erro/acao critica.
- Popover complementa contexto; nao coloque informacao indispensavel somente nele.
- Dropdown agrupa acoes relacionadas; mantenha a principal visivel.

## Loaders

Fontes:

- `_loader.scss`;
- `views/ui-kits/loaders/`;
- loader de lazy route em `AdminLayoutSidebarCompactComponent`.

Variantes: `spinner`, `spinner-glow`, `spinner-bubble`, `loader-bubble` com sufixos de cor. Para pagina, prefira skeleton quando a estrutura e previsivel; para acao, use loading no botao. Anuncie loading dinamico com `aria-live` ou `role="status"`.

## Graficos ECharts

Fontes:

- `frontend/src/app/shared/echart-styles.ts`;
- `views/dashboard/`;
- `views/ui-kits/card-metrics/`.

O module registra somente os tipos ECharts necessarios com `echarts.use(...)` e inicializa `NgxEchartsModule.forRoot({ echarts })`. Reuse `echartStyles` para grid, tooltip e linhas.

Requisitos adicionais:

- unidade e periodo claros;
- legenda compreensivel;
- paleta semantica consistente;
- alternativa textual/tabela para os dados;
- resize responsivo;
- nada de informacao distinguida apenas por cor.

## Calendario

Fontes em `frontend/src/app/views/calendar/` e `_calendar.scss`. O calendario e um exemplo visual. Ao adaptar, trate datas civis no fuso da instituicao e instantes com referencia explicita. Nao converta automaticamente dia letivo ou nascimento como instante UTC.

## Estados que o demo nao cobre bem

Novas interfaces devem completar, quando aplicavel:

- skeleton/loading;
- vazio com explicacao e proxima acao;
- erro recuperavel com retry idempotente;
- erro de campo e de regra de negocio;
- conflito de concorrencia;
- sessao expirada;
- acesso negado;
- offline/sincronizando;
- sucesso e estado salvo.

Extraia primitives compartilhadas para esses estados quando surgirem em mais de uma feature, preservando cards, tipografia e cores UX.
