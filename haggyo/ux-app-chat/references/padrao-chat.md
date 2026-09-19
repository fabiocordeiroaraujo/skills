# Padrao UX da app Chat

## Mapa local

| Responsabilidade | Arquivo |
| --- | --- |
| Feature module | `frontend/src/app/views/chat/chat.module.ts` |
| Rota | `frontend/src/app/views/chat/chat-routing.module.ts` |
| Shell | `frontend/src/app/views/chat/chat/` |
| Lista lateral | `frontend/src/app/views/chat/chat-left-sidebar/` |
| Historico e composer | `frontend/src/app/views/chat/chat-contents/` |
| Estado/API demo | `frontend/src/app/views/chat/chat.service.ts` |
| Estilos | `frontend/src/assets/styles/app/globals/views/_chat.scss` |
| Dados em memoria | `frontend/src/app/shared/inmemory-db/chat-db.ts` e `users.ts` |
| Sidebar generica | `frontend/src/app/shared/directives/sidebar.directive.ts` |

## Dependencias

`ChatModule` importa `CommonModule`, `FormsModule`, `NgScrollbarModule`, `SharedDirectivesModule`, `SharedPipesModule` e routing.

Codigo novo deve preferir Reactive Forms tipado no composer. `NgScrollbar` pode ser mantido para a area de mensagens se preservar acessibilidade e comportamento nativo esperado.

## Shell e dimensoes

`ChatComponent` apenas compoe:

```html
<div appSidebarContainer class="card chat-sidebar-container">
  <div appSidebarContent class="chat-content-wrap">
    <app-chat-contents></app-chat-contents>
  </div>
  <div appSidebar="chat-sidebar" class="chat-sidebar-wrap">
    <app-chat-left-sidebar></app-chat-left-sidebar>
  </div>
</div>
```

`_chat.scss` define:

- container: `calc(100vh - 140px)`;
- topbar: `52px`;
- conteudo: `calc(100vh - 335px)`;
- sidebar: `260px`;
- contatos rolaveis: `calc(100vh - 190px)`.

Nao replique esses numeros na feature; reuse classes e ajuste o SCSS central se a composicao global mudar. Teste viewport pequeno e teclado virtual.

## Lista de conversas/contatos

O componente demonstra:

- busca visual sem binding;
- secoes Recent e Contacts;
- avatar, nome, ultima data;
- ponto online via classe `.online`;
- selecao por clique;
- lookup de contato por pipe `getValueByKey`.

Ao adaptar:

- use busca com debounce/cancelamento;
- liste conversas como entidade principal, nao derive tudo de contatos;
- inclua preview, nao lidos, estado de atendimento e contexto autorizado;
- use botao/link focavel por item com selecao ativa;
- forneca nome acessivel ao indicador de presenca;
- pagine por cursor;
- evite lookup repetido por pipe em cada render; modele um view model pronto.

## Historico e bolhas

`ChatContentsComponent` alterna duas composicoes pela comparacao de `chat.contactId` e `activeContact.id`. As bolhas usam `.message`, avatar, nome e data.

Para produto:

- determine autoria por `senderId`/identidade da sessao;
- use `track message.id`;
- agrupe visualmente sem perder nome/timestamp acessiveis;
- preserve quebras de linha de texto sem renderizar HTML arbitrario;
- carregue mensagens anteriores ao chegar no topo, mantendo offset de scroll;
- mostre separadores de data e estado de envio;
- anuncie nova mensagem com `aria-live` sem reler todo o historico.

## Composer

O demo usa `NgForm`, textarea e dois botoes de icone. Ele liga tanto `(ngSubmit)` quanto `(keyup.enter)`, o que pode duplicar envio, e nao valida mensagem vazia.

Padrao recomendado:

- Reactive Form tipado;
- Enter envia e Shift+Enter quebra linha, com preferencia/configuracao acessivel;
- um unico caminho de submit;
- botao de enviar com `aria-label` e loading/estado;
- trim e limite coerentes com o backend;
- `clientMessageId` gerado por operacao;
- preview/remocao/upload de anexo;
- retry de falha sem duplicar.

## Scroll e foco

O demo chama `setTimeout()` para resetar, focar e rolar ao fim. Substitua por eventos de render/ciclo de vida previsiveis.

Regras:

- ao selecionar conversa, posicione no fim depois do primeiro carregamento;
- ao receber mensagem, role apenas se o usuario ja estiver perto do fim ou se a mensagem for propria;
- se estiver lendo historico, mostre indicador “novas mensagens”;
- preserve scroll ao prepend de paginas antigas;
- nao roube foco a cada atualizacao.

## Service demonstrativo

`ChatService` mantem arrays e Subjects publicos, carrega `contacts`, `chat-collections` e `chat-user` da API em memoria, cria ID com `Math.random()` e simula resposta com `setTimeout`.

Substitua por:

```text
chat-api.service.ts       historico, comandos e anexos HTTP
chat-realtime.service.ts  conexao/eventos/reconnect
chat.facade.ts            estado de lista, selecao, mensagens e composer
models/                   DTOs e view models tipados
```

Nao exponha Subjects mutaveis. Exponha Observables/signals somente leitura e metodos de comando.

## Estados necessarios

- carregando lista;
- lista vazia/sem resultados;
- nenhuma conversa selecionada;
- carregando historico inicial/anterior;
- conversacao encerrada ou sem permissao;
- conectando/reconectando/offline;
- mensagem pendente/enviada/entregue/lida/falha;
- participante indisponivel;
- erro recuperavel.

## Antipadroes do demo

- `BehaviorSubject<any>` e `Subject<any>` publicos.
- ID com `Math.random()`.
- envio e update de colecao inteira por PUT.
- auto-reply e `setTimeout` de demo.
- `console.log` com objetos de conversa.
- busca sem funcionalidade.
- formulario template-driven e envio duplicavel.
- subscriptions e estado espalhados entre dois componentes.
- ausencia de paginacao, deduplicacao, reconexao e estado de entrega.

## Capacidades relacionadas

- `COM-005`: conversa privada e grupos internos.
- `COM-006`: horario, ausencia, fila, participantes, moderacao e encerramento.
- `APP-006`: conversa/atendimento sem telefonar.
- `COM-004`: entrega, leitura, falha e reprocessamento.

