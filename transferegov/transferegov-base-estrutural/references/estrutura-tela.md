# Estrutura minima de tela

## Objetivo

O guia busca fazer o usuario perceber os modulos como um unico sistema Transferegov, nao como aplicacoes separadas.

## Areas estruturais

Uma tela Transferegov deve se encaixar na base estrutural do modulo:

- Cabecalho.
- Menu principal.
- Conteudo.
- Rodape.

## Titulo e subtitulo

Padrao:

- A tela deve possuir apenas um titulo principal.
- Use `h1` para o titulo.
- Subtitulo e excecao; use apenas quando houver orientacao adicional util.

Evite:

- Repetir o titulo no subtitulo.
- Criar varios `h1` em secoes internas.
- Usar subtitulo para instrucao que deveria estar perto do campo ou acao.

## Conteudo

Use a estrutura de conteudo conforme o tipo de tela:

- Listagem: filtros e resultado sao o foco; operacoes sao secundarias.
- Formulario: campos e agrupamentos sao o foco; acoes principais ficam abaixo e a direita.
- Detalhamento: leitura e compreensao sao o foco; evite componentes de entrada desabilitados.

## Integracao com skills tecnicas

Consulte:

- `ngx-dsgovbr-layout-navegacao` para `br-main-layout`, `br-header`, `br-footer`, `br-side-menu`, breadcrumbs e tabs.
- `ngx-dsgovbr-instalacao-configuracao` para estilos, scripts, Rawline, locale e dependencias.

## Checklist

- A tela usa a casca padronizada.
- Existe somente um `h1`.
- Subtitulo, se existir, orienta o usuario.
- A organizacao do conteudo corresponde ao tipo de tela.
- O usuario nao percebe quebra visual entre modulos.
