---
name: transferegov-detalhamento-dados
description: "Aplica o padrao visual Transferegov para detalhamento e apresentacao de dados: modo somente leitura, labels em vez de campos desabilitados, readonly quando reutilizar formulario, ofuscacao de dados pessoais, UF por sigla, numeros formatados, valores monetarios com moeda, alinhamento de colunas numericas e tags em tabelas. Use quando o usuario pedir tela de detalhamento, visualizar parceria, dados somente leitura, formatacao de dados Transferegov, valores monetarios, UF, tags de situacao ou leitura publica."
---

# transferegov detalhamento e dados

## Quando usar

Use esta skill para telas de visualizacao/detalhamento, apresentacao de dados sem edicao, leitura publica de informacoes de parceria e padronizacao de tipos de dado.

## Guia rapido

Leia:

- `references/detalhamento.md` para regras de modo somente leitura e dados pessoais.
- `references/apresentacao-tipos-dados.md` para UF, numeros e moeda.
- `references/tags.md` para tags em tabelas/listagens.

Consulte tambem:

- `ngx-dsgovbr-formularios` quando reutilizar campos em modo `readonly`.
- `ngx-dsgovbr-tabelas-listas` para tabelas de detalhamento e templates de coluna.
- `ngx-dsgovbr-diretivas-pipes-servicos` para pipes, mascaras e formatacoes reutilizaveis.

Componentes e recursos provaveis:

- Labels e texto sem componente de entrada para leitura.
- `br-label` quando confirmado pela versao instalada.
- `br-table` para dados tabulares.
- Pipes Angular ou `GovBrPipesModule` para mascara/formato quando aplicavel.
- Tag DSGov via `<span class="br-tag small ...">`.

## Padroes de decisao

- Prefira uma tela de detalhamento quando o usuario precisa ler informacoes sem editar.
- Use labels e conteudo textual para campos somente leitura.
- Se reutilizar formulario de edicao, use `readonly`; reserve `disabled` para campos que podem ser habilitados por dependencia.
- Em acesso publico ou sem autenticacao, ofusque dados pessoais conforme regra de negocio, seguranca e LGPD.
- Mostre UF apenas por sigla.
- Formate numeros com ponto para milhar e virgula para decimais.
- Em tabelas, alinhe numeros e cabecalhos numericos a direita.
- Para valores monetarios, inclua indicacao de moeda no rotulo do campo ou coluna.
- Para status/categorias, use tag em vez de icone colorido.

## Receita

Detalhamento simples:

```html
<h1>Detalhar parceria</h1>

<dl class="row">
  <dt class="col-sm-3">Numero da parceria</dt>
  <dd class="col-sm-9">123456</dd>

  <dt class="col-sm-3">UF</dt>
  <dd class="col-sm-9">PE</dd>

  <dt class="col-sm-3">Valor global (R$)</dt>
  <dd class="col-sm-9">1.250.000,00</dd>

  <dt class="col-sm-3">Situacao</dt>
  <dd class="col-sm-9">
    <span class="br-tag small success"><span>Em andamento</span></span>
  </dd>
</dl>
```

Coluna monetaria em tabela:

```ts
columns = [
  { name: 'Numero', prop: 'numero' },
  { name: 'Valor global (R$)', prop: 'valorGlobal' },
];
```

Ao renderizar ou montar os dados, formate `valorGlobal` como `1.250.000,00` e alinhe a coluna a direita usando a API real de coluna/template validada em `ngx-dsgovbr-tabelas-listas`.

## Cuidados

- Nao exponha dado pessoal bruto em detalhamento publico sem regra explicita.
- Nao use campos desabilitados como padrao visual de leitura.
- Nao use iconografia colorida para substituir tags de status.
- Nao omita a moeda de valores monetarios.
- Nao misture formatos numericos dentro da mesma coluna.

## Validacao

- A tela separa claramente leitura de edicao.
- Dados pessoais foram revisados para ofuscacao.
- UF aparece por sigla.
- Numeros usam formato brasileiro.
- Valores monetarios indicam moeda no rotulo/cabecalho.
- Tags sao compactas em tabela/listagem.
- APIs de tabela, pipes e labels foram conferidas nas skills tecnicas.
