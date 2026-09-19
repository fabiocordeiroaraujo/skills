---
name: transferegov-cores-containers
description: "Aplica o padrao visual Transferegov para cores, superficies de agrupamento e containers: uso das cores padrao DSGov, limites para customizacao, fundo #f8f8f8/--color-secondary-02, padding responsivo p-sm-2 p-md-4 p-lg-5, botoes circulares terciarios, icones, contraste e hierarquia visual. Use quando o usuario pedir cores Transferegov, container com destaque, superficie de agrupamento, ajustar layout visual, fundo de secao, paleta DSGov ou padrao de cor."
---

# transferegov cores e containers

## Quando usar

Use esta skill para decidir se uma area pode receber fundo, quando aplicar cor em icones/botoes e como evitar variacoes visuais fora do padrao Transferegov.

## Guia rapido

Leia `references/cores-superficies-containers.md` para regras de cor, superficie e padding.

Consulte tambem:

- `ngx-dsgovbr-formularios` para aplicar agrupamentos em formularios reais.
- `ngx-dsgovbr-feedback-acoes` para fieldset, sub-fieldset e componentes auxiliares.

Regra central:

- Use cores padrao dos componentes DSGov.
- No Transferegov, mudancas de cor sao admitidas principalmente em botoes circulares com enfase terciaria e icones.
- Superficies de agrupamento devem usar somente `#f8f8f8`, correspondente a `--color-secondary-02`.
- Quando usar fundo de agrupamento, aplique espacamento interno de 32px ou as classes responsivas `p-sm-2 p-md-4 p-lg-5`.

## Padroes de decisao

- Se a area so precisa organizar campos, use `fieldset`/`legend` sem fundo.
- Se a area precisa tambem destacar um conjunto de dados, use superficie `--color-secondary-02`.
- Nao crie novas paletas por modulo.
- Use cor de icone para reforco semantico apenas quando estiver previsto pelo padrao do componente.
- Preserve contraste e leitura antes de adicionar destaque visual.

## Receita

Agrupamento com destaque:

```html
<section class="p-sm-2 p-md-4 p-lg-5" style="background: var(--color-secondary-02)">
  <fieldset>
    <legend>Dados complementares</legend>
    <!-- campos ou informacoes relacionadas -->
  </fieldset>
</section>
```

Agrupamento comum:

```html
<fieldset>
  <legend>Dados da parceria</legend>
  <!-- campos principais -->
</fieldset>
```

## Cuidados

- Nao use fundo colorido como moldura decorativa.
- Nao aplique cor diferente em containers de agrupamento.
- Nao use destaque visual para compensar falta de titulo, legenda ou organizacao.
- Nao altere cores padrao dos componentes se isso quebra consistencia entre modulos.

## Validacao

- O destaque por cor tem motivo claro.
- A superficie usa `#f8f8f8` ou `--color-secondary-02`.
- O container tem padding responsivo.
- O agrupamento simples usa fieldset/legend sem cor.
- Botoes e icones seguem o catalogo de acoes e as cores padrao dos componentes.
