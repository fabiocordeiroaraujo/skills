# Detalhamento

## Objetivo

No Transferegov, pelo principio da transparencia, usuarios logados ou nao logados podem acessar informacoes das parcerias, com cuidado para ofuscar dados pessoais.

## Quando criar detalhamento

Um formulario de inclusao/edicao pode ter um correspondente somente leitura, chamado detalhamento.

Discuta com o cliente quando:

- o usuario precisa consultar sem editar;
- ha acesso publico ou amplo;
- o formulario de edicao e complexo e a leitura ficaria ruim;
- ha diferenca clara entre fluxo de manutencao e fluxo de transparencia.

## Como apresentar

Padrao preferencial:

- use labels e texto para rotulo/conteudo;
- nao use componentes de entrada desabilitados para leitura.

Se a equipe reutilizar o formulario de edicao:

- use `readonly`;
- evite `disabled`.

Use `disabled` apenas quando existe perspectiva de habilitar o campo em algum momento, como Municipio habilitado apos preencher UF.

## Dados pessoais

Antes de exibir em detalhamento:

- identifique dados pessoais;
- defina regra de ofuscacao;
- diferencie usuario logado, perfil autorizado e acesso livre;
- valide LGPD e regra de negocio.

## Checklist

- A tela e claramente de leitura.
- Labels sao legiveis e nao parecem campos bloqueados.
- Campos desabilitados foram evitados.
- Dados pessoais foram ofuscados quando necessario.
- A necessidade do modo detalhamento foi validada com o cliente.
