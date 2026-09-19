---
name: ux-layouts-navigation
description: "Criar, integrar, revisar ou corrigir paginas, shells, rotas e navegacao UX do frontend Angular Haggyo: sidebar compacta autenticada, header, footer, layout publico de sessao, layout em branco, breadcrumb, grid responsivo, lazy loading e menu. Use sempre que a tarefa envolver nova pagina, tela, rota, modulo visual, sidebar, header, menu, breadcrumb, shell autenticado/publico, responsividade ou navegacao em frontend/."
compatibility: Projeto Haggyo em frontend/ com Angular 19 baseado em NgModule, Angular Router e layout UX sidebar-compact.
---

# UX Layouts and Navigation

## Objetivo

Compor paginas Haggyo dentro dos shells UX corretos, registrar rotas e navegacao de forma coerente e preservar a estrutura visual em desktop e mobile.

O shell atual e uma base de migracao. Mantenha o comportamento visual UX, mas siga a estrutura-alvo e as regras de permissao de `requirements/tech/03-frontend-angular.md` ao criar codigo de produto.

## Fluxo

1. Identifique o tipo da jornada: autenticada, publica de sessao ou pagina isolada.
2. Leia `references/layouts-rotas-e-menu.md` e inspecione os componentes locais citados ali.
3. Crie a pagina dentro da feature de dominio; nao adicione uma nova tela de produto em `views/ui-kits`.
4. Use o scaffold UX de cabecalho, separador, grid e cards.
5. Registre a rota por lazy loading no shell apropriado.
6. Adicione o item de menu por capacidade e permissao efetiva; nao derive navegacao apenas de um papel fixo.
7. Garanta que links usem `routerLink`, botoes sejam botoes e parametros nao exponham dados pessoais.
8. Verifique carregamento, vazio, erro, acesso negado e composicao mobile.
9. Rode `npm run build` e testes relevantes.

## Selecao de layout

| Contexto | Layout atual | Regra |
| --- | --- | --- |
| Produto autenticado | `AdminLayoutSidebarCompactComponent` | padrao para features administrativas/operacionais |
| Login, cadastro, recuperacao | `AuthLayoutComponent` | somente jornadas publicas de sessao |
| 404 e paginas sem chrome | `BlankLayoutComponent` | uso excepcional e explicito |

Nao replique header ou sidebar dentro de uma feature. A pagina renderizada no `router-outlet` deve conter apenas seu conteudo.

## Estrutura da pagina

Use como ponto de partida:

```html
<div class="breadcrumb">
  <h1>Titulo da pagina</h1>
  <ul aria-label="Breadcrumb">
    <li><a routerLink="/area">Area</a></li>
    <li aria-current="page">Pagina atual</li>
  </ul>
</div>

<div class="separator-breadcrumb border-top"></div>

<div class="row">
  <div class="col-12">
    <section class="card mb-4" aria-labelledby="content-title">
      <div class="card-body">
        <h2 id="content-title" class="card-title">Secao</h2>
        <!-- estados e conteudo -->
      </div>
    </section>
  </div>
</div>
```

Adapte a composicao ao fluxo; nao crie cards sem uma finalidade de agrupamento. Use heading semantico e nao deixe o breadcrumb ser o unico nome acessivel da pagina.

## Navegacao

- Use rotas e nomes de dominio estaveis em ingles no codigo; traduza apenas o texto apresentado.
- Use IDs opacos na URL. Filtros e paginacao compartilhavel podem usar query params.
- Nao coloque token, CPF, nome, email ou outro dado pessoal na URL.
- O guard melhora a experiencia, mas o backend continua autorizando cada operacao.
- Diferencie 403, 404 e indisponibilidade.
- Ao trocar tenant/unidade, descarte estado incompatível antes de navegar.
- Preserve destinos pos-login apenas quando forem internos e validados.

## Responsividade

O shell compact usa sidebar principal de `76px`, secundaria de `220px`, topbar de `80px` e conteudo com margem superior de `104px`. Em mobile, o conteudo deve ocupar a largura total e a navegacao fecha apos mudanca de rota.

Nao use esses numeros novamente em componentes. Eles pertencem ao SCSS do layout. Dentro da pagina:

- comece com `col-12` e aumente a densidade em `md`/`lg`;
- mantenha a acao primaria alcancavel;
- ofereca alternativa a tabelas largas;
- permita reflow e zoom de 200%;
- teste teclado virtual e orientacao nas jornadas mobile prioritarias.

## Resultado esperado

Entregue a pagina no shell correto, com rota lazy, navegacao coerente, breadcrumb funcional e comportamento responsivo. Relate os pontos de integracao alterados e qualquer dependencia de permissoes/capacidades ainda nao implementada.

## Checklist

- Layout escolhido corresponde ao contexto da jornada.
- Feature nao duplica chrome global.
- Pagina usa breadcrumb, separador e grade UX de modo semantico.
- Rota e feature sao lazy-loaded quando apropriado.
- Menu, rota e acoes consideram capacidade/permissao.
- Links internos usam `routerLink` e botoes nao simulam links.
- URL nao contem dados pessoais ou segredos.
- 403, 404, loading, vazio e erro nao foram confundidos.
- Desktop e mobile foram verificados.
