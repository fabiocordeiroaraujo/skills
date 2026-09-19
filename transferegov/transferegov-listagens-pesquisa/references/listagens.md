# Listagens a partir do menu

## Quando uma tela e listagem

Na maioria dos acionamentos a partir do menu, o sistema apresenta uma tela de consulta para selecionar um registro que sera mantido. O foco da tela e:

- conjunto de filtros;
- listagem de registros;
- selecao do registro;
- operacoes relacionadas ao resultado.

Demais operacoes sao secundarias.

## Elementos da tela

Elementos esperados:

1. Bloco de topo com `br-title`.
2. Botao com operacao de destaque no canto superior direito do topo, quando existir acao principal.
3. `br-table` como container principal da consulta.
4. Filtros dentro do `slot-filter` do `br-table`, usando `br-fieldset bg`.
5. Botoes dos filtros de pesquisa (Pesquisar/Limpar) alinhados a direita.
6. Operacoes por linha na tabela e listagem do resultado.

## Padrao estrutural de consulta Transferegov

Para telas de consulta/listagem no contexto Transferegov, use a mesma estrutura aplicada nas telas de Banco e OPP:

- topo com `br-title` e botao de incluir no canto direito;
- filtros no `slot-filter` do `br-table`;
- resultado e paginacao no proprio `br-table`.

Para o usuario conseguir acessar os filtros de forma visual, trate como obrigatorio:

- `br-table` com `[filtered]="true"`;
- bloco de filtro no `slot-filter`;
- opcionalmente `[filteredActive]="true"` quando filtros devem iniciar expandidos;
- `[showFiltersStats]="false"` para manter o mesmo visual adotado no Gestao Financeira.

Para manter espacamento e alinhamento padrao dos filtros:

- organize os campos com `div.row` + `class="col-sm-*"`;
- faca a soma de cada linha totalizar 12;
- nao use `class="col-sm"` sem sufixo numerico.

Evite padrao alternativo para esse contexto (ex.: wrapper `listagem`, `br-fieldset` envolvendo o resultado e toolbar principal fora do `br-table`).

## Titulo

- Use apenas um titulo por tela.
- Use subtitulo so como excecao, para orientacao extra.
- Em consultas Transferegov, prefira `br-title` como titulo da pagina.

## Componentes relacionados

Consulte `ngx-dsgovbr-tabelas-listas` para:

- `br-table`;
- `BrTableColumn`;
- paginacao local/externa;
- filtros;
- ordenacao;
- selecao;
- exportacao;
- templates e acoes por linha.

Consulte `ngx-dsgovbr-formularios` para os componentes de filtro:

- `br-input`;
- `br-select`;
- `br-date-picker`;
- mascaras e validadores.

## Checklist

- A listagem esta claramente orientada para consulta.
- A acao de destaque nao compete com filtros e resultado.
- Filtros e resultado estao visualmente separados.
- Filtros estao no `slot-filter` do `br-table`.
- Botao/icone de filtros esta visivel e funcional na barra da tabela.
- Cada linha de filtros fecha 12 colunas com `col-sm-*`.
- A tabela/lista e o elemento principal apos os filtros.
