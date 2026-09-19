# Filtros, operacoes e tabela

## Area de filtros

Use espacamento interno em torno do grupo de filtros:

- padding alvo: 32px;
- classe simples citada pelo guia: `p5`;
- classes responsivas recomendadas: `p-sm-2 p-md-4 p-lg-5`.

Se houver muitos filtros, organize em subgrupos com `fieldset`.

Padrao de grid dos filtros:

- use `div.row` para cada faixa horizontal de campos;
- use somente classes `col-sm-*` para distribuir largura dos campos;
- feche cada linha com soma 12 (ex.: `3+3+3+3`, `4+4+4`, `2+4+3+3`, `6+6`);
- nao use `class="col-sm"` sem tamanho numerico;
- mantenha botoes de acao em `col-sm-12` alinhado a direita.

## Visibilidade do botao de filtros

Para o botao/icone de filtros aparecer na barra da tabela e permitir o acesso ao painel:

- use `[filtered]="true"` no `br-table`;
- defina os campos no `slot-filter` (ex.: `<br-fieldset bg slot-filter>`);
- use `[filteredActive]="true"` quando precisar abrir os filtros por padrao;
- use `[showFiltersStats]="false"` quando quiser o mesmo acabamento visual adotado no Gestao Financeira.

Sem `[filtered]="true"`, o usuario pode nao ter acesso visual ao painel de filtros.

## Filtro expandido ou retraido

Use filtros expandidos quando:

- o usuario normalmente precisa filtrar para chegar ao registro desejado;
- a tela carrega com algum filtro aplicado.

Use filtros retraidos quando:

- a consulta padrao e util sem filtros;
- a area de filtros ocupa espaco demais para uso frequente.

## Preservacao de filtros

Depois de aplicar filtros e realizar uma operacao, como editar um registro, ao voltar para a consulta os filtros e parametros aplicados devem ser mantidos.

O guia cita o `FiltroService` da biblioteca `maisbrasil-ep-base-web` para guardar filtros. Se o projeto nao usa essa biblioteca, implemente preservacao equivalente em rota, query params, store ou servico local.

## Ordenacao

Toda tabela deve ter ordenacao padrao quando houver criterio natural.

Regras:

- A coluna padrao deve mostrar indicativo no cabecalho.
- O criterio deve ser coerente com a tarefa do usuario.
- Nao use ordenacao arbitraria se isso atrapalhar localizar registros.

## Acoes na barra da tabela

O DSGov permite icones utilitarios na barra de titulo da tabela.

Padrao Transferegov:

- Ate 4 icones lado a lado.
- Mais de 4 icones: usar botao de acesso ao menu flutuante.
- Exportacoes ficam agrupadas no icone `Acessar Opcoes` (`fa-ellipsis-v`).
- Personalizar colunas nao deve aparecer em toda tabela por padrao.

## Exportacao

Padrao inicial:

- Acesso livre: exportar apenas pagina atual.
- Usuario logado com perfil de consulta: exportar todo o resultado quando viavel.

Antes de implementar, avalie:

- desempenho;
- limite de registros;
- exportacao batch;
- exportacao a partir da pagina corrente;
- controle de acesso;
- volume de uso de recursos.

## Checklist

- Filtros possuem padding responsivo.
- Botao/icone de filtros esta visivel na barra da tabela.
- Filtros usam `col-sm-*` e cada `row` totaliza 12 colunas.
- Estado dos filtros e preservado apos operacoes.
- Tabela tem ordenacao padrao quando aplicavel.
- Exportacao esta agrupada em opcoes.
- Limites de volume e permissao foram avaliados.
- APIs de `br-table` e `DataExport` foram conferidas em `ngx-dsgovbr-tabelas-listas`.
