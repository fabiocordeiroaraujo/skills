# angular.json, estilos, scripts e assets

## Styles globais

Configuracao sugerida de estilos globais para uma aplicacao consumidora:

```json
[
  "node_modules/bootstrap/dist/css/bootstrap.min.css",
  "node_modules/@fortawesome/fontawesome-free/css/all.min.css",
  "node_modules/prismjs/themes/prism-coy.min.css",
  "node_modules/@siemens/ngx-datatable/index.css",
  "node_modules/@siemens/ngx-datatable/themes/material.css",
  "node_modules/@siemens/ngx-datatable/assets/icons.css",
  "node_modules/@govbr-ds/core/dist/core.min.css",
  "src/styles.css"
]
```

`prismjs` costuma ser necessário apenas se a app exibir snippets de código. Para `br-table`, mantenha os três CSS de `@siemens/ngx-datatable`.

## Ajuste CSS da lib

Adicione o ajuste CSS publicado pela própria biblioteca:

```json
"node_modules/@serpro/ngx-dsgovbr/assets/styles/br-ngx.css"
```

Inclua esse CSS especialmente quando a aplicação não usa `br-header`.

## Scripts globais

Scripts globais comuns quando a aplicação usa recursos que dependem de JS global:

```json
[
  "node_modules/moment/min/moment-with-locales.min.js",
  "node_modules/jquery/dist/jquery.min.js",
  "node_modules/bootstrap/dist/js/bootstrap.bundle.min.js",
  "node_modules/prismjs/prism.js",
  "node_modules/prismjs/components/prism-typescript.min.js",
  "node_modules/prismjs/components/prism-bash.min.js",
  "node_modules/prismjs/components/prism-markup.min.js",
  "node_modules/prismjs/components/prism-markdown.min.js",
  "node_modules/jspdf/dist/jspdf.umd.min.js",
  "node_modules/jspdf-autotable/dist/jspdf.plugin.autotable.js",
  "node_modules/@govbr-ds/core/dist/core-init.js"
]
```

Para aplicação consumidora, avalie por recurso:

- `moment-with-locales`: date pickers e validações que usam Moment.
- `jquery` e `bootstrap.bundle`: componentes que dependem de Bootstrap/DS GovBR global.
- `jspdf` e `jspdf-autotable`: exportação PDF de tabela.
- `@govbr-ds/core/dist/core-init.js`: inicialização de componentes JS do Design System, importante para `br-cookie-bar`.
- `prismjs`: somente se a aplicação renderizar exemplos de código.

## Assets

Em uma aplicacao consumidora, procure assets publicados em `node_modules/@serpro/ngx-dsgovbr/assets`. Copie apenas os assets que a aplicacao realmente usa.

## Configuracao minima sugerida

```json
"styles": [
  "node_modules/bootstrap/dist/css/bootstrap.min.css",
  "node_modules/@fortawesome/fontawesome-free/css/all.min.css",
  "node_modules/@siemens/ngx-datatable/index.css",
  "node_modules/@siemens/ngx-datatable/themes/material.css",
  "node_modules/@siemens/ngx-datatable/assets/icons.css",
  "node_modules/@govbr-ds/core/dist/core.min.css",
  "node_modules/@serpro/ngx-dsgovbr/assets/styles/br-ngx.css",
  "src/styles.css"
],
"scripts": [
  "node_modules/moment/min/moment-with-locales.min.js",
  "node_modules/jquery/dist/jquery.min.js",
  "node_modules/bootstrap/dist/js/bootstrap.bundle.min.js",
  "node_modules/jspdf/dist/jspdf.umd.min.js",
  "node_modules/jspdf-autotable/dist/jspdf.plugin.autotable.js",
  "node_modules/@govbr-ds/core/dist/core-init.js"
]
```

Remova itens que a aplicação não usa, mas não remova estilos de tabela se houver `br-table`.
