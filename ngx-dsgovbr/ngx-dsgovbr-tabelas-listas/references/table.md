# br-table, paginacao e exportacao

## Indice

- `br-table`: seletor, import, inputs e outputs.
- Modelos: `BrTableColumn`, `BrTableAction`, `FilterTerm` e propriedades herdadas de `TableColumn`.
- Receitas de colunas: colunas básicas, pipes, `cellTemplate`, `headerTemplate`, ações, resumo, agrupamento, detalhe expansível e filtros.
- Exportacao: `DataExport`, formatos e dependências.
- Paginacao externa e `br-pagination-table`.
- Cuidados frequentes.

## br-table

- Seletor: `br-table`
- Import: `GovBrTableModule`
- Dependência visual/base: `@siemens/ngx-datatable`.

Inputs principais:

| Nome | Tipo/default | Uso |
| --- | --- | --- |
| `key` | `string` | Chave para customização de colunas. |
| `pageSizes` | `[100, 50, 20, 15, 10, 5]` | Opções de tamanho. |
| `pageSize` | `number` | Tamanho de página; tem `pageSizeChange`. |
| `customBody` | `boolean`, default `false` | Corpo customizado. |
| `data` | `any[]` | Linhas. |
| `columns` | `string[] | BrTableColumn[]` | Colunas. |
| `externalPaging` | `boolean`, default `false` | Paginação controlada pelo pai. |
| `itemsAmount` | `number` | Total externo. |
| `currentPage` | `number` | Página atual; tem `currentPageChange`. |
| `title` | `string` | Título. |
| `emptyMessageTitle` | `string` | Título vazio. |
| `emptyMessage` | `Nenhum item encontrado` | Mensagem vazia. |
| `virtualization` | `boolean` | Virtualização. |
| `headerHeight` | `50` | Altura header. |
| `footerHeight` | `number` | Altura footer. |
| `rowHeight` | `number | 'auto' | fn`, default `auto` | Altura linha. |
| `rowDetailHeight` | `number | fn` | Altura detalhe. |
| `fileExportName` | `dados` | Nome base da exportação. |
| `export` | `DataExport` | Alias público de `dataExport`. |
| `columnMode` | `ColumnMode.flex` | Modo de colunas. |
| `rowExpandableFn` | função | Habilita expansão por linha. |
| `detailTemplate` | `TemplateRef<any>` | Template de detalhe. |
| `expandRowOnActivate` | `boolean`, default `false` | Expande ao ativar. |
| `autoExpanded` | `boolean` | Expande/recolhe todas as linhas quando alterado. |
| `headerButtonDetail` | `boolean`, default `false` | Mostra botão de expandir/recolher no header quando há `detailTemplate`. |
| `summaryRow` | `boolean` | Linha resumo. |
| `summaryPosition` | `bottom` | Posição do resumo. |
| `summaryHeight` | `number` | Altura resumo. |
| `rowClass` | `any` | Classe por linha. |
| `scrollbarH` | `true` | Scroll horizontal. |
| `scrollbarV` | `boolean` | Scroll vertical. |
| `selectable` | `boolean`, default `false` | Seleção. |
| `headerSelectable` | `boolean`, default `false` | Checkbox no header. |
| `selected` | `any[]`, default `[]` | Linhas selecionadas; tem `selectedChange`. |
| `displayCheck` / `selectCheck` / `disableRowCheck` | função | Regras de seleção. |
| `showSelectedBar` | `boolean`, default `false` | Barra de selecionados. |
| `rowFilterAtTitleBar` | `boolean`, default `true` | Filtro de linha no título. |
| `filterRowFn` | função | Filtro de linha customizado. |
| `showFiltersStats` | `boolean`, default `true` | Estatísticas de filtros. |
| `sortable` | `boolean`, default `true` | Ordenação. |
| `externalSorting` | `boolean`, default `false` | Ordenação externa. |
| `selectAllRowsOnPage` | `boolean`, default `false` | Selecionar página. |
| `rowIdentity` | função | Identidade de linha. |
| `tableStyle` | objeto | Estilo inline. |
| `trackByProp` | `string` | TrackBy. |
| `actions` | `BrTableAction[]`, default `[]` | Ações da toolbar. |
| `footerText` | `string` | Texto de footer. |
| `loadingIndicator` | `boolean`, default `false` | Loading da tabela. |
| `paginationType` | `STANDARD | CONTEXTUAL`, default `CONTEXTUAL` | Tipo da paginação. |
| `responsive` | `boolean`, default `false` | Layout responsivo. |
| `sorts` | `any[]` | Estado de sort. |
| `sortType` | `SortType` | Tipo de sort. |
| `enableClearingSortState` | `boolean` | Limpa sort após asc/desc. |
| `selectionType` | `SelectionType.checkbox` | Tipo de seleção. |
| `filtered` | `boolean`, default `false` | Estado de filtro. |
| `filteredActive` | `boolean`, default `false` | Filtro aberto inicialmente. |
| `paginationPlacement` | `top | bottom | both | none`, default `bottom` | Posição. |
| `filterTerms` | `FilterTerm[]`, default `[]` | Filtros aplicados; tem `filterTermsChange`. |
| `groupRowsBy` | `BrTableColumn` | Agrupamento. |
| `groupExpansionDefault` | `boolean`, default `false` | Expansão de grupos. |

Outputs:

- `pageSizeChange: number`
- `currentPageChange: number`
- `selectedChange`
- `rowExpanded`
- `sort`
- `activate`
- `filterTermsChange: FilterTerm[]`

## Modelos

`BrTableColumn extends TableColumn` adiciona:

- `order?: number`
- `hidden?: boolean`
- `filterable?: boolean`
- `filterFn?: (row, str, col?) => boolean`
- `hideable?: boolean`
- `colspan?: number`
- `colSpanText?: string`
- `$gerada?: boolean` interno.

Como `BrTableColumn` herda de `TableColumn` do `@siemens/ngx-datatable`, use também propriedades comuns como:

- `prop`: propriedade da linha usada na célula. Se omitido, a tabela tenta derivar de `name`.
- `name`: rótulo da coluna.
- `pipe`: instância de `PipeTransform` para formatar valor sem template.
- `cellTemplate`: `TemplateRef` para renderizar célula customizada.
- `headerTemplate`: `TemplateRef` para header customizado.
- `summaryFunc`: função para célula de resumo quando `summaryRow` está ativo.
- `width`, `minWidth`, `maxWidth`, `flexGrow`: tamanho.
- `headerClass`, `cellClass`: classes CSS.
- `sortable`, `resizeable`, `draggable`: comportamento de coluna.
- `checkboxable`, `headerCheckboxable`: seleção por checkbox quando precisar controlar a coluna de seleção manualmente.

`BrTableAction`:

- `actionType`: `filterCols`, `filterRows`, `customizeColumns` ou string customizada.
- `icon`, `actionDescription`, `actionLabel`, `disabled`, `active`, `callbackFn`, `selectionOnly`, `customClass`.

Constantes exportadas:

- `BA_TOGGLE_FILTERING`
- `BA_ROW_FILTER`
- `BA_CUSTOMIZE_COLUMNS`
- `ALL_BUILTIN_ACTIONS`

`FilterTerm`:

- `columnName: string`; use `null` para filtro geral de linhas.
- `value: string`.

## Receitas de colunas

### Colunas básicas com filtros, largura e classes

Use `BrTableColumn[]` quando precisar de filtro, classes, largura, hide/show ou qualquer recurso além de uma lista simples de nomes.

`servidores-table.component.ts`

```ts
import { Component } from '@angular/core';
import { BrTableColumn, GovBrTableModule } from '@serpro/ngx-dsgovbr';

interface Servidor {
  codigo: number;
  nome: string;
  cpf: string;
  situacao: 'Ativo' | 'Inativo';
  salario: number;
}

@Component({
  standalone: true,
  imports: [GovBrTableModule],
  templateUrl: './servidores-table.component.html',
})
export class ServidoresTableComponent {
  rows: Servidor[] = [
    { codigo: 1, nome: 'Ana Silva', cpf: '12345678909', situacao: 'Ativo', salario: 8500 },
  ];

  columns: BrTableColumn[] = [
    { prop: 'codigo', name: 'Código', maxWidth: 110, sortable: true, filterable: true },
    { prop: 'nome', name: 'Nome', filterable: true, hideable: false, flexGrow: 2 },
    { prop: 'cpf', name: 'CPF', filterable: true },
    { prop: 'situacao', name: 'Situação', filterable: true, width: 140 },
    {
      prop: 'salario',
      name: 'Salário',
      headerClass: 'text-right',
      cellClass: 'text-right',
      filterable: true,
    },
  ];
}
```

`servidores-table.component.html`

```html
<br-table
  title="Servidores"
  [data]="rows"
  [columns]="columns"
  [pageSize]="10"
  [filtered]="true">
</br-table>
```

### Pipes nas colunas

Use `pipe` quando só precisar formatar o valor textual da célula. Passe uma instância do pipe.

```ts
import { CurrencyPipe, DatePipe } from '@angular/common';
import { BrTableColumn, CpfCnpjPipe } from '@serpro/ngx-dsgovbr';

columns: BrTableColumn[] = [
  { prop: 'codigo', name: 'Código' },
  { prop: 'nome', name: 'Nome' },
  { prop: 'cpf', name: 'CPF', pipe: new CpfCnpjPipe() },
  {
    prop: 'nascimento',
    name: 'Nascimento',
    pipe: new DatePipe('pt-BR', undefined, {
      dateFormat: 'dd/MM/yyyy',
      timezone: 'America/Sao_Paulo',
    }),
  },
  {
    prop: 'salario',
    name: 'Salário',
    pipe: new CurrencyPipe('pt-BR', 'BRL'),
    headerClass: 'text-right',
    cellClass: 'text-right',
  },
];
```

### `cellTemplate` para conteúdo customizado

Use `cellTemplate` quando a célula precisa de HTML, botões, badges, ícones, pipes de template ou regras visuais.

`contratos-table.component.ts`

```ts
import { CurrencyPipe } from '@angular/common';
import { Component, OnInit, TemplateRef, ViewChild } from '@angular/core';
import { BrTableColumn, GovBrTableModule } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrTableModule, CurrencyPipe],
  templateUrl: './contratos-table.component.html',
})
export class ContratosTableComponent implements OnInit {
  @ViewChild('valorTpl', { static: true }) valorTpl!: TemplateRef<any>;
  @ViewChild('statusTpl', { static: true }) statusTpl!: TemplateRef<any>;

  rows = [
    { numero: 'CT-001', valor: 12500, status: 'Ativo' },
    { numero: 'CT-002', valor: 9800, status: 'Inativo' },
  ];

  columns: BrTableColumn[] = [];

  ngOnInit() {
    this.columns = [
      { prop: 'numero', name: 'Contrato', filterable: true },
      {
        prop: 'valor',
        name: 'Valor',
        cellTemplate: this.valorTpl,
        headerClass: 'text-right',
        cellClass: 'text-right',
      },
      { prop: 'status', name: 'Situação', cellTemplate: this.statusTpl, filterable: true },
    ];
  }
}
```

`contratos-table.component.html`

```html
<br-table [data]="rows" [columns]="columns" title="Contratos"></br-table>

<ng-template #valorTpl let-row="row">
  <strong>{{ row.valor | currency:'BRL':'symbol':'1.2-2':'pt-BR' }}</strong>
</ng-template>

<ng-template #statusTpl let-row="row">
  <span class="br-tag" [class.success]="row.status === 'Ativo'">
    {{ row.status }}
  </span>
</ng-template>
```

### `headerTemplate` para header customizado

Use `headerTemplate` quando o título da coluna precisa de tooltip, ícone, botão ou controle de ordenação customizado. O template pode receber `let-sort="sortFn"` e chamar `sort()`.

`header-template-table.component.ts`

```ts
import { Component, OnInit, TemplateRef, ViewChild } from '@angular/core';
import { BrTableColumn, GovBrTableModule } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrTableModule],
  templateUrl: './header-template-table.component.html',
})
export class HeaderTemplateTableComponent implements OnInit {
  @ViewChild('codigoHeader', { static: true }) codigoHeader!: TemplateRef<any>;

  rows = [{ codigo: 10, nome: 'Ana' }];
  columns: BrTableColumn[] = [];

  ngOnInit() {
    this.columns = [
      { prop: 'codigo', name: 'Código', headerTemplate: this.codigoHeader },
      { prop: 'nome', name: 'Nome' },
    ];
  }
}
```

`header-template-table.component.html`

```html
<br-table [data]="rows" [columns]="columns"></br-table>

<ng-template #codigoHeader let-sort="sortFn">
  <button class="br-button small secondary" type="button" (click)="sort()">
    Código
    <i class="fas fa-sort" aria-hidden="true"></i>
  </button>
</ng-template>
```

### Ações por linha com coluna `cellTemplate`

Use uma coluna de ações com `cellTemplate` quando cada linha tiver comandos próprios.

`acoes-linha-table.component.ts`

```ts
import { Component, OnInit, TemplateRef, ViewChild } from '@angular/core';
import { BrTableColumn, GovBrConfirmationButtonModule, GovBrTableModule } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrTableModule, GovBrConfirmationButtonModule],
  templateUrl: './acoes-linha-table.component.html',
})
export class AcoesLinhaTableComponent implements OnInit {
  @ViewChild('acoesTpl', { static: true }) acoesTpl!: TemplateRef<any>;

  rows = [{ id: 1, nome: 'Ana', perfil: 'Administrador' }];
  columns: BrTableColumn[] = [];

  ngOnInit() {
    this.columns = [
      {
        name: 'Ações',
        cellTemplate: this.acoesTpl,
        sortable: false,
        resizeable: false,
        headerClass: 'text-center',
        cellClass: 'br-row-actions text-center',
        maxWidth: 130,
      },
      { prop: 'nome', name: 'Nome', filterable: true },
      { prop: 'perfil', name: 'Perfil', filterable: true },
    ];
  }

  editar(row: any) {}
  excluir(id: number) {
    this.rows = this.rows.filter(row => row.id !== id);
  }
}
```

`acoes-linha-table.component.html`

```html
<br-table [data]="rows" [columns]="columns" title="Usuários"></br-table>

<ng-template #acoesTpl let-row="row">
  <button class="br-button small circle" type="button" (click)="editar(row)">
    <span class="sr-only">Editar</span>
    <i class="fas fa-pencil-alt" aria-hidden="true"></i>
  </button>

  <br-confirmation-button title="Excluir" (primarySelection)="excluir(row.id)">
    <span class="sr-only">Excluir</span>
    <i class="fas fa-trash" aria-hidden="true"></i>
  </br-confirmation-button>
</ng-template>
```

### Ações por linha com `brTableTplActions`

Use `[brTableTplActions]` quando quiser usar o ponto de extensão próprio do `br-table` para ações por linha.

```html
<br-table [data]="rows" [columns]="columns">
  <ng-template brTableTplActions let-row="row">
    <button class="br-button circle small" type="button" (click)="editar(row)">
      <span class="sr-only">Editar</span>
      <i class="fas fa-pen" aria-hidden="true"></i>
    </button>
  </ng-template>
</br-table>
```

### Linha de resumo com `summaryRow` e `summaryFunc`

Use `summaryFunc` nas colunas que precisam totalizar, contar ou calcular média.

`resumo-table.component.ts`

```ts
import { CurrencyPipe } from '@angular/common';
import { Component, OnInit, TemplateRef, ViewChild } from '@angular/core';
import { BrTableColumn, GovBrTableModule } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrTableModule, CurrencyPipe],
  templateUrl: './resumo-table.component.html',
})
export class ResumoTableComponent implements OnInit {
  @ViewChild('valorTpl', { static: true }) valorTpl!: TemplateRef<any>;
  private currency = new CurrencyPipe('pt-BR');

  rows = [
    { item: 'A', quantidade: 2, valor: 100 },
    { item: 'B', quantidade: 3, valor: 250 },
  ];

  columns: BrTableColumn[] = [];

  ngOnInit() {
    this.columns = [
      { prop: 'item', name: 'Item' },
      {
        prop: 'quantidade',
        name: 'Qtd.',
        summaryFunc: (cells: number[]) => `Total: ${cells.reduce((sum, value) => sum + value, 0)}`,
      },
      {
        prop: 'valor',
        name: 'Valor',
        cellTemplate: this.valorTpl,
        summaryFunc: (cells: number[]) =>
          'Total: ' + this.currency.transform(cells.reduce((sum, value) => sum + value, 0), 'BRL'),
      },
    ];
  }
}
```

`resumo-table.component.html`

```html
<br-table
  [data]="rows"
  [columns]="columns"
  [summaryRow]="true"
  summaryPosition="bottom">
</br-table>

<ng-template #valorTpl let-row="row">
  {{ row.valor | currency:'BRL':'symbol':'1.2-2':'pt-BR' }}
</ng-template>
```

### Agrupamento de linhas

Use `groupRowsBy` apontando para uma das colunas.

```ts
import { CurrencyPipe, DatePipe } from '@angular/common';
import { BrTableColumn } from '@serpro/ngx-dsgovbr';

groupRowsBy: BrTableColumn = { prop: 'idade', name: 'Idade' };

columns: BrTableColumn[] = [
  { prop: 'codigo', name: 'Código' },
  this.groupRowsBy,
  { prop: 'nascimento', name: 'Nascimento', pipe: new DatePipe('pt-BR') },
  { prop: 'nome', name: 'Nome' },
  {
    prop: 'salario',
    name: 'Salário',
    pipe: new CurrencyPipe('pt-BR', 'BRL'),
    headerClass: 'text-right',
    cellClass: 'text-right',
  },
];
```

```html
<br-table
  [data]="rows"
  [columns]="columns"
  [groupRowsBy]="groupRowsBy"
  [groupExpansionDefault]="true">
</br-table>
```

### Detalhe expansível por linha

Use `detailTemplate` para renderizar conteúdo abaixo da linha. Combine com `rowExpandableFn` quando nem toda linha deve expandir.

`detalhe-table.component.ts`

```ts
import { Component, TemplateRef, ViewChild } from '@angular/core';
import { BrTableColumn, GovBrTableModule } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrTableModule],
  templateUrl: './detalhe-table.component.html',
})
export class DetalheTableComponent {
  @ViewChild('detalheTpl', { static: true }) detalheTpl!: TemplateRef<any>;

  expandirTodas = false;
  rows = [
    { id: 1, nome: 'Ana', unidade: 'SEDE', permiteDetalhe: true },
    { id: 2, nome: 'Bruno', unidade: 'REGIONAL', permiteDetalhe: false },
  ];

  columns: BrTableColumn[] = [
    { prop: 'nome', name: 'Nome' },
    { prop: 'unidade', name: 'Unidade' },
  ];

  podeExpandir = (row: any) => row.permiteDetalhe;

  onRowExpanded(event: { expanded: boolean; row: any }) {}
}
```

`detalhe-table.component.html`

```html
<br-table
  [data]="rows"
  [columns]="columns"
  [detailTemplate]="detalheTpl"
  [rowExpandableFn]="podeExpandir"
  [expandRowOnActivate]="true"
  [headerButtonDetail]="true"
  [autoExpanded]="expandirTodas"
  (rowExpanded)="onRowExpanded($event)">
</br-table>

<button class="br-button secondary" type="button" (click)="expandirTodas = !expandirTodas">
  Alternar detalhes
</button>

<ng-template #detalheTpl let-row="row">
  <div class="p-3">
    <strong>{{ row.nome }}</strong>
    <p class="mb-0">Unidade: {{ row.unidade }}</p>
  </div>
</ng-template>
```

### Filtros programáticos e ações embutidas

Use `ALL_BUILTIN_ACTIONS` para expor filtro de colunas, filtro de linhas e customização de colunas. Use `filterTerms` para controlar filtros pela tela pai.

```ts
import {
  ALL_BUILTIN_ACTIONS,
  BrTableAction,
  BrTableColumn,
  FilterTerm,
} from '@serpro/ngx-dsgovbr';

actions: BrTableAction[] = [...ALL_BUILTIN_ACTIONS];

columns: BrTableColumn[] = [
  { prop: 'codigo', name: 'Código', filterable: true, hideable: false },
  { prop: 'nome', name: 'Nome', filterable: true },
  { prop: 'situacao', name: 'Situação', filterable: true },
];

filterTerms: FilterTerm[] = [];

filtrarAtivos() {
  this.filterTerms = [{ columnName: 'Situação', value: 'Ativo' }];
}

limparFiltros() {
  this.filterTerms = [];
}
```

```html
<button class="br-button secondary" type="button" (click)="filtrarAtivos()">Ativos</button>
<button class="br-button secondary" type="button" (click)="limparFiltros()">Limpar</button>

<br-table
  [data]="rows"
  [columns]="columns"
  [actions]="actions"
  [filtered]="true"
  [(filterTerms)]="filterTerms">
</br-table>
```

## Exportacao

Input público: `[export]="dataExport"`.

`DataExport`:

- `columns: string[]`
- `data: any[] | (filteredData, columns) => any[] | Promise<any[]>`
- `headerColumns`, `headerData`, `footerColumns`, `footerData`
- `enabledTypes`: default `['txt','csv','xls','pdf','xml']`
- `config?: ExportOptions`

`ExportOptions`:

- `csvColumnSeparator`, `csvLineSeparator`, `csvBom`
- `txtColumnSeparator`, `txtLineSeparator`
- `pdfFontSize`
- `icons`, `labels`

Dependências por formato:

- TXT/CSV: serviços internos e browser.
- XLS: `xlsx`.
- PDF: `jspdf` e `jspdf-autotable`.
- XML: `xml-js`.
- Download: `file-saver`.

Exemplo:

```ts
import { DataExport } from '@serpro/ngx-dsgovbr';

exportar = new DataExport(
  ['Nome', 'Situação'],
  (filteredData) => filteredData.map(row => [row.nome, row.situacao]),
);
exportar.enabledTypes = ['csv', 'xls', 'pdf'];
```

```html
<br-table [data]="rows" [columns]="columns" [export]="exportar"></br-table>
```

## Paginacao externa

Use quando os dados vêm do backend:

```html
<br-table
  [data]="rows"
  [columns]="columns"
  [externalPaging]="true"
  [itemsAmount]="total"
  [(currentPage)]="page"
  [(pageSize)]="pageSize"
  (currentPageChange)="carregar()"
  (pageSizeChange)="carregar()">
</br-table>
```

## br-pagination-table

- Seletor: `br-pagination-table`
- Import: `GovBrPaginationModule`
- Inputs/models: `responsive`, `pageSizes`, `pageSize`, `itemsAmount`, `currentPage`, `paginationType`, `dropdownPosition`.
- `pageSize` e `currentPage` são `model()`, então two-way binding é válido.
- `PaginationType = 'STANDARD' | 'CONTEXTUAL'`.

Normalmente `br-table` já usa esse componente internamente; use diretamente apenas em casos customizados.

## Cuidados frequentes

- Não use `[dataExport]`; o alias público é `[export]`.
- Não use `items` em `br-table`; o input de linhas é `data`.
- Para colunas simples, `string[]` funciona; para filtros, templates, agrupamento ou hideable, use `BrTableColumn[]`.
- Para paginação local, não marque `externalPaging`.
- Para filtros controlados, use `[(filterTerms)]` com `FilterTerm[]`.
