# Fundamentos visuais UX do Haggyo

## Fontes de verdade

| Assunto | Arquivo local |
| --- | --- |
| Entrada global de estilos | `frontend/src/assets/styles/app/_app.scss` |
| Familias e tamanho base | `frontend/src/assets/styles/app/_variables.scss` |
| Tema ativo | `frontend/src/assets/styles/app/themes/_themes.scss` |
| Tema roxo atual | `frontend/src/assets/styles/app/themes/_lite-purple.scss` |
| Alternativa azul existente | `frontend/src/assets/styles/app/themes/_lite-blue.scss` |
| Globais e utilitarios UX | `frontend/src/assets/styles/app/globals/` |
| Bootstrap customizado | `frontend/src/assets/styles/vendor/bootstrap/` |
| Iconsmind | `frontend/src/assets/styles/iconsmind/iconsmind.css` |
| Catalogo visual de icones | `frontend/src/app/views/icons/iconsmind/` |
| Configuracao de carregamento | `frontend/angular.json` |

`angular.json` carrega Bootstrap 5.3.2, `_app.scss` e `src/styles.css`. `_app.scss` tambem importa Toastr, Angular Calendar, Highlight.js e Iconsmind.

## Tema atual

O tema importado e o roxo (`lite-purple`). Seus valores principais sao:

| Papel | Valor atual | Uso |
| --- | --- | --- |
| primary | `#663399` | acao principal, selecao, destaque de marca |
| info/blue | `#263db5` | informacao e dados neutros destacados |
| success | `#4CAF50` | conclusao e estado positivo |
| warning | `#FFC107` | atencao e acao pendente |
| danger | `#d22346` | erro e destruicao |
| background | `#fff` | superficies e shell |
| gray-100 | `#f8f9fa` | fundo de controles |
| gray-200 | `#eee` | divisores e hover leve |
| gray-400 | `#ced4da` | borda de controles |
| gray-500 | `#bbb` | placeholder/desabilitado |

Prefira classes Bootstrap semanticas (`text-primary`, `bg-success`, `btn-danger`) ou variaveis Sass do tema. Hexadecimal literal so e aceitavel ao configurar biblioteca que nao consome CSS/Sass; nesse caso, centralize a ponte em um helper, como `shared/echart-styles.ts`.

## Tipografia

- Familia de base e heading: `Nunito, sans-serif`.
- Tamanho base Sass: `.813rem`; o `html` global usa `16px`.
- Corpo: `letter-spacing: .3px`, `line-height: 1.6`.
- Titulos, `.card-title` e `.text-title` usam a cor heading.
- `.card-title`: `1.1rem` com `1.5rem` de margem inferior.
- `.text-small`: `.75rem`.
- Existem utilitarios UX `text-10` ate `text-78` e `font-weight-300` ate `font-weight-900`.

Use tamanhos UX pontualmente para metricas e icones. Para texto corrente, prefira a escala Bootstrap e a hierarquia semantica HTML. Nao use um `<p class="text-24">` como substituto automatico de heading quando o conteudo e um titulo.

## Superficies e elevacao

O card padrao possui:

- raio de `10px`;
- sem borda;
- sombra `0 4px 20px 1px rgba(0,0,0,.06), 0 1px 4px rgba(0,0,0,.08)`.

Composicao base:

```html
<section class="card mb-4" aria-labelledby="section-title">
  <div class="card-body">
    <h2 id="section-title" class="card-title">Titulo da secao</h2>
    <!-- conteudo -->
  </div>
</section>
```

Variantes disponiveis:

- `card-icon`, `card-icon-big`: destaque centralizado com icone.
- `card-icon-bg card-icon-bg-primary`: KPI com icone grande e baixa opacidade.
- `card-profile-1`: resumo de pessoa com avatar.
- `card-ecommerce-*`: modelos do template; reutilize somente se a estrutura fizer sentido no dominio educacional.
- `box-shadow-1`, `box-shadow-2`: elevacao explicita; nao empilhe sobre card sem necessidade.

Evite `card-zoom-in` em rotinas administrativas: a escala de `1.2` no hover pode causar sobreposicao e problemas de reflow.

## Espacamento e grade

O template usa intensamente Bootstrap:

- `row` + `col-lg-*`, `col-md-*`, `col-sm-*`;
- `mb-4` para separacao vertical entre cards;
- `mb-3` dentro de agrupamentos;
- `p-3`/`p-4` para secoes internas;
- `d-flex`, `align-items-center`, `justify-content-between`, `flex-grow-1`.

Comece pela composicao Bootstrap. CSS local com largura fixa deve ser excecao. Para conteudo denso, adapte a composicao em mobile em vez de apenas reduzir colunas.

## Botoes

| Intencao | Classe preferida |
| --- | --- |
| Acao primaria da tela | `btn btn-primary` |
| Acao secundaria | `btn btn-outline-primary` ou `btn btn-secondary` |
| Cancelar/voltar | `btn btn-outline-secondary` |
| Destruir apos confirmacao | `btn btn-danger` |
| Acao compacta por icone | `btn btn-icon` com nome acessivel |
| Icone + texto | `btn btn-icon-text` |
| Acao em andamento | componente `btn-loading` |

`btn-rounded` aplica raio de `40px`; `btn-wide` aumenta padding horizontal. Nao use somente icone sem `aria-label` ou texto acessivel.

## Icones

Iconsmind e carregado globalmente. Uso:

```html
<i class="i-Calendar-4" aria-hidden="true"></i>
```

Consulte o array `icons` em `frontend/src/app/views/icons/iconsmind/iconsmind.component.ts`. Alguns nomes uteis ao Haggyo:

- pessoas: `i-Student-Hat-2`, `i-Add-User`, `i-Checked-User`, `i-Conference`;
- calendario: `i-Calendar`, `i-Calendar-4`, `i-Clock`;
- documentos: `i-File-Edit`, `i-File-Search`, `i-File-CSV`, `i-File-Excel`;
- comunicacao: `i-Email`, `i-Mail-Send`, `i-Speach-Bubble-6`;
- status: `i-Check`, `i-Warning-Window`, `i-Information`, `i-Close`;
- financeiro: `i-Money-2`, `i-Receipt-4`, `i-Credit-Card`.

O icone e complementar. Inclua texto para a acao/estado e use `aria-hidden="true"` quando o texto ja der o significado.

## Padroes a nao copiar

- Links vazios ou `href="#"` usados como botoes.
- Estilos inline para largura, altura ou fonte que podem ser classes/SCSS.
- `float-right`, `text-left`, `pl-*` e outros nomes Bootstrap antigos; no Bootstrap 5 use `float-end`, `text-start`, `ps-*`/`pe-*`.
- Conteudo e imagens ficticios do template de demonstracao.
- Cor codificada diretamente em cada componente ECharts.
- Ausencia de texto alternativo, label, foco ou estado textual observada em demos.

## Referencias exemplares

- KPI e dashboard: `frontend/src/app/views/dashboard/dashboad-default/`.
- Variacoes de metricas: `frontend/src/app/views/ui-kits/card-metrics/`.
- Cards: `frontend/src/app/views/ui-kits/cards/` e `card-widgets/`.
- Botoes: `frontend/src/app/views/ui-kits/buttons/` e `buttons-loading/`.
- Feedback visual: `frontend/src/app/views/ui-kits/alerts/`.
