# Formularios de inclusao e edicao

## Conceito

Formulario e um grupo de controles de entrada relacionados que permite fornecer dados ou configurar opcoes. Pode aparecer como:

- pagina dedicada;
- painel lateral;
- dialogo/modal.

A escolha depende do caso de uso e da situacao.

## Elementos previstos

O guia Transferegov destaca:

1. Titulo e subtitulo obrigatorio no modelo, com subtitulo usado somente quando necessario.
2. Agrupamento por cor.
3. Agrupamento por fieldset e legend.
4. Agrupamento por fieldset e legend colapsado.
5. Ajuda.
6. Botoes das operacoes principais.
7. Botoes das operacoes secundarias.
8. Abas e subabas.
9. Listagens.

## Titulo e subtitulo

- Use apenas um titulo principal.
- Use `h1`.
- Subtitulo e excecao para orientacao adicional.

## Cabecalho de parceria

Para formularios que tratam de Parceria, o guia orienta usar o componente de cabecalho da Esteira de Parcerias.

Informacoes previstas na primeira versao:

- Titulo.
- Dados da Parceria: Codigo da Parceria, Ente Recebedor/Proponente, Situacao e Subsituacao.
- Dados do Repassador: Codigo do Programa, Ente Repassador/Concedente, Nome do Programa.

Nao recrie esse cabecalho manualmente se o projeto disponibiliza o componente da Esteira. Se a API nao estiver no pacote `@serpro/ngx-dsgovbr`, valide na documentacao da Esteira.

## Componentes relacionados

Consulte `ngx-dsgovbr-formularios` para:

- campos;
- reactive forms;
- template-driven forms;
- validadores;
- mascaras;
- mensagens;
- arquivos e datas.

Consulte `ngx-dsgovbr-feedback-acoes` para:

- `br-modal`;
- `br-confirmation`;
- `br-alert-messages`;
- `br-loading`;
- `br-fieldset` e `br-sub-fieldset`, se usados pelo projeto.

## Checklist

- O formulario tem um unico titulo.
- O subtitulo orienta de fato.
- Formulario de parceria avaliou cabecalho da Esteira.
- O tipo de apresentacao (pagina, painel ou modal) combina com o volume de dados e risco da acao.
