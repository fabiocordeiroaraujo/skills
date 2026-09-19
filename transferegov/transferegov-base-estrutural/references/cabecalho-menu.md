# Cabecalho e menu Transferegov

## Cabecalho

O cabecalho agrupa componentes que ajudam o usuario a acessar as funcionalidades principais do sistema.

Elementos esperados:

- Logo do Transferegov.
- Titulo `Transferegov.br` com link para a pagina inicial do modulo.
- Subtitulo com versao do modulo.
- Botao de menu.
- Area de links com `Legislacao` e `Integracoes`.
- Area de funcionalidades com link para `Termo de Uso`, quando aplicavel.
- Botao `Autenticar` quando o usuario nao esta logado.
- Avatar/dropdown quando autenticado.

Dropdown do usuario autenticado:

- Lista de vinculos do usuario.
- Nome do usuario logado.
- Vinculo selecionado.
- Opcao para encerrar a sessao.

O guia registra que a Esteira de Parcerias possui servicos e componente pronto para apoiar essa estrutura. Nao invente API desses componentes; valide no projeto da Esteira quando for necessario.

## Comportamento sticky

O cabecalho deve ter comportamento sticky: ao rolar a pagina para cima, fixa no topo da area visivel e aparece reduzido enquanto o conteudo continua rolando.

Ao implementar com `@serpro/ngx-dsgovbr`, consulte `ngx-dsgovbr-layout-navegacao` para os inputs reais de `br-main-layout` e `br-header`.

## Menu principal

O menu principal e acionado pelo icone de menu localizado no cabecalho.

Padroes:

- Os itens aparecem na lateral da pagina.
- A apresentacao fica sobreposta ao conteudo.
- O comportamento segue o padrao DSGov de menu flutuante com preenchimento.
- A densidade adotada no Transferegov e media.
- Todos os modulos devem apresentar todos os itens de menu disponiveis conforme usuario logado ou acesso livre.

## Decisao tecnica

Quando o modulo usar a Esteira de Parcerias, avalie o componente de layout da Esteira, citado no guia como recomendacao para cabecalho, menu e rodape.

Quando o modulo usar `@serpro/ngx-dsgovbr` diretamente:

- Use `br-main-layout` como casca quando fizer sentido.
- Use `Application`, `Menu`, `MenuItem` e `User` importados de `@serpro/ngx-dsgovbr`.
- Valide `menu.itens` e demais modelos na skill `ngx-dsgovbr-layout-navegacao`.

## Checklist

- Cabecalho mostra identidade Transferegov.
- Estado deslogado tem autenticacao.
- Estado logado tem avatar/dropdown com dados de vinculo.
- Menu e acionado no cabecalho e aparece lateralmente sobre o conteudo.
- Densidade do menu e media.
- Sticky header foi avaliado.
