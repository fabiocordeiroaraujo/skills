---
name: transferegov-listagens-pesquisa
description: "Aplica o padrao visual Transferegov para telas de listagem, consulta e pesquisa: titulo, subtitulo, filtros, manter filtros apos retorno, parametros de pesquisa, tabela, ordenacao padrao, exportacao, acoes do resultado, icone de opcoes, busca em tabela e estados de resultado. Use quando o usuario pedir tela de listagem Transferegov, consulta a partir do menu, filtros Transferegov, tabela com acoes, exportacao de resultado, pesquisa com br-table ou preservar filtros."
---

# transferegov listagens e pesquisa

## Quando usar

Use esta skill quando a tela nasce de um item de menu e o foco e encontrar registros, aplicar filtros, listar resultados e acionar operacoes sobre linhas ou sobre o conjunto retornado.

## Guia rapido

Leia:

- `references/listagens.md` para estrutura da tela de consulta.
- `references/filtros-operacoes-tabela.md` para filtros, ordenacao, exportacao, acoes e preservacao de estado.

Consulte tambem:

- `ngx-dsgovbr-tabelas-listas` para APIs reais de `br-table`, colunas, paginacao, filtros, selecao, templates e exportacao.
- `ngx-dsgovbr-formularios` para APIs reais dos campos usados como filtros.
- `ngx-dsgovbr-feedback-acoes` para loading, alertas, confirmacoes e estados auxiliares.

Componentes provaveis:

- `br-table`, `br-pagination-table`, `br-input`, `br-select`, `br-date-picker`, `br-fieldset`, `br-loading`, `br-alert-messages`.

Estrutura padrao:

1. Bloco de topo com `br-title` e acao principal no canto superior direito.
2. `br-table` como container do resultado.
3. Filtros dentro de `br-fieldset bg slot-filter` no proprio `br-table`.
4. Botoes dos filtros: Pesquisar e Limpar, alinhados a direita.
5. Acoes do resultado em `tableActions`/template de acoes por linha.
6. Paginacao e ordenacao no `br-table`, local ou externa conforme regra de negocio.

Regra obrigatoria para botao de filtros:

- Configure `[filtered]="true"` no `br-table` para exibir o botao/icone de filtros na barra da tabela.
- Declare os filtros no `slot-filter` (`<br-fieldset bg slot-filter>...</br-fieldset>`).
- Quando a tela exigir filtros abertos por padrao, use tambem `[filteredActive]="true"`.
- Para manter o visual de Gestao Financeira, use `[showFiltersStats]="false"`.

Regra obrigatoria de grid para filtros:

- Monte os campos dentro de `div.row` com classes `col-sm-*`.
- Em cada `row`, a soma das colunas deve totalizar 12 (ex.: `3+3+3+3`, `4+4+4`, `6+6`, `2+4+3+3`).
- Nao use `class="col-sm"` sem tamanho numerico.
- Para linha de acoes dos filtros (Limpar/Pesquisar), use `col-sm-12` alinhado a direita.

## Padroes de decisao

- Em telas de consulta/listagem Transferegov, siga o padrao estrutural: topo com `br-title` e botao no canto direito + `br-table` com filtro em `slot-filter`.
- Evite estrutura de pagina (toolbar fora da tabela e `br-fieldset` envolvendo o resultado) quando o contexto for consulta padrao Transferegov.
- Nao omita `[filtered]="true"` quando houver filtros, pois sem isso o usuario pode ficar sem acesso visual ao painel de filtros.
- Nao monte filtros com colunas quebradas; cada linha precisa fechar em 12 para manter espacamento consistente.
- Se o usuario normalmente precisa filtrar para encontrar um registro, carregue os filtros expandidos.
- Se a tela retorna de edicao ou outra operacao, mantenha filtros e parametros aplicados.
- Defina ordenacao padrao para a tabela sempre que houver uma coluna natural para isso.
- Use ate 4 icones de acao utilitaria lado a lado na barra da tabela; acima disso, agrupe no menu de opcoes.
- Agrupe exportacoes no icone `fa-ellipsis-v`/Acessar Opcoes.
- Nao exponha personalizacao de colunas em toda tabela por padrao; avalie ganho real para o usuario.

## Receita

Tela de consulta simples no padrao Transferegov:

```ts
import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { BrTableColumn, GovBrInputModule, GovBrSelectModule, GovBrTableModule } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [ReactiveFormsModule, GovBrInputModule, GovBrSelectModule, GovBrTableModule],
  templateUrl: './consulta-parcerias.component.html',
})
export class ConsultaParceriasComponent {
  filtros = new FormGroup({
    numero: new FormControl(''),
    situacao: new FormControl(null),
  });

  situacoes = ['Aguardando', 'Em andamento', 'Encerrado'];

  rows = [
    { numero: '123456', proponente: 'Municipio Exemplo', situacao: 'Em andamento', valor: 100000 },
  ];

  columns: BrTableColumn[] = [
    { name: 'Numero', prop: 'numero' },
    { name: 'Proponente', prop: 'proponente', filterable: true },
    { name: 'Situacao', prop: 'situacao', filterable: true },
    { name: 'Valor (R$)', prop: 'valor' },
  ];

  pesquisar() {}
  limpar() {
    this.filtros.reset();
  }

  incluir() {}
}
```

```html
<div style="position: relative;">
  <br-title title="Consultar parcerias"></br-title>
  <div style="position: absolute; top: 25px; right: 0px;">
    <button type="button" class="br-button is-primary" (click)="incluir()">
      Incluir
    </button>
  </div>
</div>

<br-table
  key="table-auto-filtro"
  [data]="rows"
  [columns]="columns"
  [filtered]="true"
  [filteredActive]="true"
  [showFiltersStats]="false"
  [sortable]="true"
  [pageSize]="10"
  paginationType="CONTEXTUAL">

  <br-fieldset bg slot-filter>
    <form [formGroup]="filtros" class="br-form">
      <div class="row">
        <div class="col-sm-6">
          <br-input label="Numero da parceria" formControlName="numero"></br-input>
        </div>
        <div class="col-sm-6">
          <br-select label="Situacao" formControlName="situacao" [values]="situacoes"></br-select>
        </div>
      </div>

      <div class="row">
        <div class="col-sm-12" style="text-align: right;">
          <hr />
          <button class="br-button secondary" type="button" (click)="limpar()">Limpar</button>
          <button class="br-button primary" type="button" (click)="pesquisar()">Pesquisar</button>
        </div>
      </div>
    </form>
  </br-fieldset>

</br-table>
```

## Cuidados

- Nao use subtitulo para repetir o titulo; use apenas para orientacao extra.
- Nao usar wrappers de layout (por exemplo classes e toolbar de resultado fora do `br-table`) para telas padrao de consulta Transferegov.
- Nao esconda filtros aplicados ao voltar de uma operacao.
- Nao espalhe exportacoes em varios botoes se o padrao da tela pede agrupamento em opcoes.
- Nao alinhe numeros como texto; em tabelas, alinhe numero e titulo da coluna a direita.

## Validacao

- A tela tem foco claro em filtros e resultado.
- Filtros usam padding responsivo `p-sm-2 p-md-4 p-lg-5`.
- A secao de filtros abre por padrao quando ha filtro aplicado ou quando filtrar e o fluxo comum.
- Estrutura da tela segue topo com `br-title` + acao principal e filtro dentro de `slot-filter` no `br-table`.
- Botao/icone de filtros esta visivel na barra da tabela.
- Cada `row` de filtros usa `col-sm-*` totalizando 12 colunas.
- Tabela tem ordenacao padrao quando aplicavel.
- Exportacao e acoes utilitarias respeitam limite de ate 4 icones visiveis.
- APIs de `br-table` foram conferidas em `ngx-dsgovbr-tabelas-listas`.
