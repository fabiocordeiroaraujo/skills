---
name: ngx-dsgovbr-tabelas-listas
description: "Cria, corrige e explica tabelas, paginação, listas, cards, accordion, carousel e componentes de dados da biblioteca @serpro/ngx-dsgovbr. Use quando o usuário pedir br-table, br-pagination-table, filtros, ordenação, paginação local ou externa, seleção de linhas, ações por linha, exportação txt/csv/xls/pdf/xml, templates brTableTplActions, br-list, br-collapsible-list, br-card, br-accordion ou br-carousel."
---

# ngx-dsgovbr tabelas e listas

## Quando usar

Use esta skill para telas de dados tabulares, listas navegáveis, cards de resumo e coleções visuais. Ela é especialmente importante para `br-table`, que envolve `@siemens/ngx-datatable`, modelos exportados e várias opções com nomes específicos.

## Guia rapido

Leia:

- `references/table.md` para `br-table`, paginação, filtros, seleção, ações, templates, exportação e receitas completas de `columns`, `pipe`, `cellTemplate`, `headerTemplate`, resumo, agrupamento e detalhe expansível.
- `references/listas.md` para lista, collapsible-list, accordion, card e carousel.

Exemplo mínimo de tabela:

`exemplo-tabela.component.ts`

```ts
import { Component } from '@angular/core';
import { GovBrTableModule, BrTableColumn } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrTableModule],
  templateUrl: './exemplo-tabela.component.html',
})
export class ExemploTabelaComponent {
  selected: any[] = [];
  rows = [{ nome: 'Ana', cpf: '00000000000', situacao: 'Ativo' }];
  columns: BrTableColumn[] = [
    { name: 'Nome', prop: 'nome', filterable: true },
    { name: 'CPF', prop: 'cpf' },
    { name: 'Situação', prop: 'situacao', filterable: true },
  ];
}
```

`exemplo-tabela.component.html`

```html
<br-table
  title="Servidores"
  [data]="rows"
  [columns]="columns"
  [pageSize]="10"
  [selectable]="true"
  [(selected)]="selected">
</br-table>
```

## Decisoes importantes

- Use `@siemens/ngx-datatable` nas configurações e tipos relacionados; evite referências antigas de `@swimlane/ngx-datatable`.
- Para exemplos de componentes, prefira `templateUrl` e mostre o HTML em arquivo `.component.html`; evite colocar HTML em `template` inline dentro do `.ts`, salvo quando o projeto consumidor já seguir esse padrão.
- Para paginação externa, combine `externalPaging`, `itemsAmount`, `currentPage`, `currentPageChange`, `pageSize` e `pageSizeChange`.
- Para exportação, use o input público `[export]` com `DataExport`, nao o nome interno `dataExport`.
- Para ações embutidas, use `BrTableAction` e tipos `filterCols`, `filterRows` ou `customizeColumns`; para ação customizada por linha, use `actions` e/ou template `brTableTplActions`.
- Quando gerar uma tabela com formatação ou ações, inclua o código de montagem de `columns`; não entregue apenas o HTML do `br-table`.

## Validacao

Antes de entregar:

- `GovBrTableModule` ou o módulo adequado foi importado.
- `columns` usa `BrTableColumn[]` quando há filtros, templates, largura, hideable ou agrupamento.
- Colunas com `pipe`, `cellTemplate`, `headerTemplate` ou `summaryFunc` mostram também os imports, `TemplateRef`/`ViewChild` quando necessário e a atribuição de `columns`.
- `selected`, `currentPage`, `pageSize` e `filterTerms` usam os pares `*Change` quando houver two-way binding.
- Dependências de exportação (`file-saver`, `jspdf`, `jspdf-autotable`, `xlsx`, `xml-js`) foram consideradas.
- Exemplos de lista não confundem `br-list` com `br-collapsible-list`.
