---
name: ux-visual-language
description: "Aplicar, revisar ou corrigir a linguagem visual UX do frontend Angular do Haggyo: cores semanticas, tipografia Nunito, espacamento Bootstrap, cards, sombras, bordas, icones Iconsmind, densidade e SCSS. Use sempre que a tarefa mencionar aparencia, estilo, tema, identidade visual, CSS/SCSS, cores, tipografia, icones, cards, dashboard, consistencia visual ou criacao de uma interface em frontend/."
compatibility: Projeto Haggyo em frontend/ com Angular 19, Bootstrap 5.3, SCSS UX e Iconsmind.
---

# UX Visual Language

## Objetivo

Manter novas interfaces Haggyo visualmente coerentes com o padrao UX sem copiar cegamente as telas de demonstracao. Reutilize os tokens, utilitarios e composicoes existentes antes de criar CSS novo.

O catalogo UX existente e a fonte visual; `requirements/tech/03-frontend-angular.md` e a fonte para acessibilidade, responsividade e arquitetura de produto. Quando houver conflito, preserve a intencao visual e corrija a implementacao para cumprir os requisitos Haggyo.

## Fluxo

1. Confirme que o alvo esta em `frontend/`. Nao aplique este padrao UX ao app Expo em `app/`.
2. Leia `references/fundamentos-visuais.md` antes de decidir cor, tipografia, sombra, raio, icone ou espacamento.
3. Inspecione uma pagina UX equivalente em `frontend/src/app/views/` e o SCSS que realmente define a classe.
4. Reuse classes Bootstrap/UX e componentes existentes. Crie SCSS local apenas para uma necessidade de dominio que nao possa ser composta com o vocabulario existente.
5. Use cores por significado, nao por decoracao. Inclua texto ou icone quando o estado nao puder depender somente de cor.
6. Preserve hierarquia, legibilidade, foco visivel, reflow e contraste. Corrija exemplos antigos do template quando necessario.
7. Verifique o resultado nos breakpoints relevantes e rode ao menos `npm run build` quando houver alteracao de codigo.

## Regras de composicao

- Use a pagina branca do shell autenticado como fundo e cards para agrupar blocos com responsabilidade clara.
- Prefira `card mb-4` e `card-body`; use variantes UX somente quando a semantica combinar com o conteudo.
- Use a grade Bootstrap (`row`, `col-*`) e utilitarios de espacamento. Evite margens e larguras magicas em estilos inline.
- Use `text-primary`, `text-success`, `text-warning`, `text-danger`, `text-muted` e equivalentes para preservar o tema.
- Use `btn-primary` para a acao principal, `btn-outline-*` para alternativas e `btn-danger` apenas para acao destrutiva confirmada.
- Use `btn-rounded` quando o contexto existente adotar o acabamento arredondado; mantenha consistencia dentro do fluxo.
- Use Iconsmind com uma classe existente, por exemplo `i-Calendar-4`; valide o nome no catalogo local antes de escolher o icone.
- Nao copie lorem ipsum, imagens de produtos, nomes de pessoas, links `href="#"`, moeda ou dados ficticios do template.

## Escolha entre reuso e extensao

Reutilize quando o catalogo UX ja fornecer a semantica e o comportamento visual. Estenda quando o Haggyo precisar de um estado de produto ausente, como conflito, offline, acesso negado ou verificacao documental.

Ao estender:

- derive cores dos tokens do tema em SCSS, sem duplicar hexadecimais;
- mantenha raio, sombra e escala tipografica compativeis com os componentes UX;
- coloque estilo generico na futura camada `shared/ui` e estilo especifico junto da feature;
- nao dependa de seletores internos de outra feature;
- documente estados normal, hover, focus, disabled, loading e erro quando aplicaveis.

## Resultado esperado

Entregue codigo aderente ao visual UX e relate quais primitives/classes foram reutilizadas. Se um padrao novo for necessario, explique por que o catalogo existente nao resolve e mantenha a extensao pequena e semantica.

## Checklist

- As cores vieram do tema ou de classes semanticas.
- A hierarquia usa titulos, texto secundario e agrupamento coerentes.
- Cards, botoes, campos e icones seguem o vocabulario UX.
- Nao ha valor visual arbitrario quando ja existe token/utilitario.
- O estado nao depende apenas de cor.
- Foco, contraste, zoom e mobile foram considerados.
- Conteudo demonstrativo do template nao foi promovido a produto.
