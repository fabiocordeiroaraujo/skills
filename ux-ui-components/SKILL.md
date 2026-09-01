---
name: ux-ui-components
description: "Selecionar, reutilizar, adaptar, criar ou revisar componentes e padroes de interacao UX no frontend Angular Haggyo: botoes com loading, formularios, validacao, tabelas, filtros, paginacao, cards, badges, alertas, toastr, modais, wizard, tabs, accordions, calendarios, graficos ECharts, listas e estados de tela. Use sempre que a tarefa envolver componente UI, formulario, campo, tabela, lista, modal, confirmacao, feedback, loading, vazio, erro, KPI, grafico, dashboard ou workflow em frontend/."
compatibility: Projeto Haggyo em frontend/ com Angular 19, NgModule, ng-bootstrap 18, Bootstrap 5.3, ngx-toastr, ECharts e componentes UX.
---

# UX UI Components

## Objetivo

Usar o catalogo real de componentes UX como base para interfaces Haggyo consistentes, acessiveis e completas. Reaproveite aparencia e primitives; substitua dados, comportamento demonstrativo e APIs fracas por implementacoes de produto.

## Fluxo

1. Classifique a necessidade: acao, entrada, exibicao de dados, feedback, overlay, jornada em etapas ou visualizacao.
2. Leia a secao correspondente em `references/catalogo-e-padroes.md`.
3. Inspecione o exemplo local indicado e seus imports no module.
4. Reuse primeiro ng-bootstrap, Bootstrap, um componente `shared` existente ou a composicao UX.
5. Para codigo novo, use formularios reativos tipados, tipos de dominio de tela e estado explicito.
6. Implemente os estados relevantes: inicial, loading, vazio, conteudo, erro, sem permissao, disabled e sucesso. Inclua conflito/offline quando a jornada exigir.
7. Preserve semantica, teclado, foco, labels e anuncios dinamicos. Corrija limitacoes do template de demonstracao.
8. Teste o risco principal do componente e rode `npm run build`.

## Regra de autoridade

- O catalogo UX define a aparencia e oferece exemplos de composicao.
- ng-bootstrap/Angular definem a API tecnica do componente.
- `requirements/tech/03-frontend-angular.md` define os requisitos Haggyo.
- O backend define validacao final, autorizacao e estado oficial.

Nao copie a logica de mock, `setTimeout`, arrays demonstrativos, `any`, `UntypedFormGroup`, links ficticios ou chamadas de dados em memoria como implementacao final.

## Selecao rapida

| Necessidade | Padrao preferido |
| --- | --- |
| Acao assincrona | `btn-loading` ou evolucao compativel com `loading`, disabled e texto |
| Formulario | Reactive Forms tipado + classes `.form-group`/`.form-control` |
| Busca/ordenacao/paginacao | card + toolbar + table + `ngb-pagination`; acesso a dados em facade/service da feature |
| Estado curto global | Toastr, sem dado sensivel |
| Erro/aviso persistente no contexto | `ngb-alert` + `alert-card` |
| Confirmacao destrutiva | `NgbModal` com impacto, cancelar e acao `btn-danger` |
| Jornada longa | form wizard/stepper adaptado e estado preservado |
| KPI | card metric ou `card-icon-bg` com texto e valor |
| Grafico | `ngx-echarts` + `echartStyles`, legenda e alternativa textual |
| Status | badge semantico com texto, nunca apenas cor |

## Componentes compartilhados

O template expoe atualmente:

- `btn-loading`;
- `app-feather-icon`;
- `form-wizard` e `wizard-step` via modulo proprio;
- `app-search`;
- componentes de layout.

Um novo componente vai para a futura `shared/ui` somente quando for generico, sem regra de dominio e usado ou projetado para uso por multiplas features. Caso contrario, mantenha-o em `features/<dominio>/components`.

## Formularios

- Prefira Reactive Forms tipado, mesmo quando o demo usa `ngModel` ou `UntypedFormGroup`.
- Associe `label` e controle; instrucao e erro devem ter IDs e `aria-describedby` quando necessario.
- Mostre erro de campo junto ao controle e erro de regra no contexto da acao.
- Mascara formata a apresentacao, mas nao muda o valor canonico enviado.
- Desabilite envio repetido e use idempotencia em acoes criticas.
- A resposta do backend prevalece sobre a validacao local.

## Dados e tabelas

- Use `<table>` para dados tabulares, com `scope` em headers e nomes acessiveis para ordenacao.
- Filtro, ordenacao e paginacao pertencem ao estado da feature/facade, nao ao componente visual generico.
- Cancele buscas obsoletas com RxJS e use debounce.
- Para mobile, ofereca composicao alternativa quando as colunas nao couberem.
- Inclua loading, linha vazia, erro e total/paginacao compreensiveis.
- Nao copie `CountryService` como client real; ele filtra arrays locais e serve apenas como demonstracao de estado.

## Feedback e acoes criticas

Use Toastr para confirmacao breve e nao bloqueante. Use alerta contextual para informacao que o usuario precisa ler ou resolver. Use modal apenas quando a decisao bloquear o fluxo ou exigir confirmacao.

Em exclusao/acao critica, descreva objeto e impacto, ofereca cancelar, aplique foco inicial seguro e mostre loading na confirmacao. Nao registre dados pessoais ou payloads no console.

## Resultado esperado

Entregue o componente ou composicao reutilizando a primitive UX correta, com imports minimos e estados completos. Cite o exemplo local usado como referencia e explicite qualquer melhoria de acessibilidade/API feita sobre o demo.

## Checklist

- Primitive existente foi considerada antes de criar outra.
- Imports pertencem ao modulo/feature que os usa.
- Estado e modelos nao usam `any` sem justificativa.
- Formulario novo e reativo e tipado.
- Loading impede repeticao indevida e e anunciado.
- Vazio, erro, sem permissao e sucesso estao tratados quando aplicaveis.
- Tabela funciona por teclado e tem alternativa responsiva quando necessaria.
- Modal gerencia foco e explica impacto.
- Badge/grafico nao comunica informacao somente por cor.
- Mock e conteudo demo nao vazaram para a feature.
