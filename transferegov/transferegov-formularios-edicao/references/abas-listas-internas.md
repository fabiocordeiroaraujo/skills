# Abas, subabas e listagens internas

## Quando usar abas

Use abas quando:

- ha informacao em excesso em uma pagina;
- e preciso organizar conteudo em partes menores;
- a divisao melhora usabilidade e compreensao.

## Densidade

- Use densidade padrao na maioria dos casos.
- Use densidade alta quando a aba estiver em espaco restrito.

No `@serpro/ngx-dsgovbr`, consulte `ngx-dsgovbr-layout-navegacao` para o par correto de componentes:

- `br-tab-set`/`br-tab`;
- `br-second-tab-set`/`br-second-tab`;
- `br-vertical-tab-set`/`br-vertical-tab`.

## Subabas

O DSGov recomenda evitar subabas, mas o guia Transferegov reconhece que formularios complexos muitas vezes precisam delas.

Padrao Transferegov:

- subabas podem ser usadas quando simplificam formulario complexo;
- devem ser horizontais;
- use componente `br-tab` conforme API validada na skill tecnica.

## Navegacao de parceria

Para padronizar opcoes de parceria e permitir navegacao fluida entre modulos, a Esteira de Parcerias possui componente de abas.

Caracteristicas:

- cada aba pode ter conteudo implementado por modulo diferente;
- ao clicar na aba, o sistema pode recarregar a tela e ir para outro modulo;
- visualmente o usuario deve perceber um sistema unico.

Nao invente API desse componente; valide na documentacao da Esteira.

## Listagens dentro de formularios

Listagens complexas em formularios de inclusao/edicao devem usar tabela.

A barra de titulo da tabela pode conter acoes utilitarias. As mais comuns:

- Inclusao.
- Pesquisa.

Demais operacoes devem seguir orientacoes DSGov e Transferegov para barra de tabela.

## Inclusao na listagem

Use icone `fa-plus`.

Comportamentos possiveis:

1. Abrir modal com formulario de inclusao.
2. Navegar para nova tela e voltar para a listagem apos persistir.
3. Incluir diretamente na tabela por grid editavel.

Nome do botao:

- Se persiste dados: `Salvar`, `Registrar`, `Assinar` ou verbo de negocio equivalente.
- Se nao persiste dados: `Confirmar`.

## Pesquisa na listagem interna

Use icone `fa-search`.

Ao acionar:

- apresente formulario de pesquisa junto ao cabecalho da tabela;
- inclua campos de filtro;
- inclua botoes `Pesquisar` e `Limpar`;
- inclua opcao para fechar o formulario de pesquisa.

## Checklist

- Abas reduzem complexidade real.
- Densidade padrao foi usada salvo restricao de espaco.
- Subabas foram justificadas por complexidade.
- Listagem interna complexa usa tabela.
- Inclusao usa `fa-plus`.
- Pesquisa usa `fa-search` e formulario junto ao cabecalho da tabela.
