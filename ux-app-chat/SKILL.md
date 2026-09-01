---
name: ux-app-chat
description: "Reutilizar, adaptar, implementar ou revisar o padrao UX da app Chat no frontend Angular Haggyo: lista de contatos/conversas, presenca, selecao, historico rolavel, bolhas de mensagem, composer, anexos, loading, auto-scroll e layout sidebar responsivo. Use sempre que a tarefa envolver chat, conversa privada, mensagens em tempo real, atendimento conversacional, canal, grupo, contato, historico, composer, presenca online, nao lidos ou WebSocket/SSE de mensagens em frontend/."
compatibility: Projeto Haggyo em frontend/ com Angular 19, NgModule, RxJS, ngx-scrollbar, SharedDirectivesModule, SharedPipesModule e estilos UX de chat.
---

# UX App Chat

## Objetivo

Usar a app Chat como padrao visual e estrutural para conversas Haggyo, preservando lista lateral, topbar, historico, bolhas e composer. Substitua a simulacao HTTP/auto-reply por um modelo de conversa autorizado, moderavel e consistente com o canal real.

Use tambem `ux-visual-language`, `ux-layouts-navigation`, `ux-ui-components` e `ux-angular-feature` quando aplicaveis.

## Fluxo

1. Leia `references/padrao-chat.md` e inspecione `frontend/src/app/views/chat/`.
2. Defina o tipo: conversa privada, grupo institucional, atendimento/protocolo ou canal interno.
3. Modele conversa, participante, mensagem, entrega/leitura, cursor e permissao com IDs estaveis.
4. Separe client HTTP (historico/comandos), transporte em tempo real e facade/store da feature.
5. Carregue conversas e mensagens por cursor; cancele selecoes obsoletas e preserve scroll.
6. Implemente composer tipado com envio idempotente, estado pendente/falha/retry e anexos verificados.
7. Integre eventos de tempo real com reconexao, deduplicacao e ordenacao definidos.
8. Aplique consentimento, horario, fila, participantes, moderacao, encerramento e retencao conforme o canal.
9. Verifique mobile, teclado, foco, leitor de tela e anuncio de novas mensagens.

## Estrutura reutilizavel

```text
card.chat-sidebar-container
|-- appSidebarContent.chat-content-wrap
|   `-- app-chat-contents
`-- appSidebar="chat-sidebar".chat-sidebar-wrap
    `-- app-chat-left-sidebar
```

O painel lateral contem busca, recentes e contatos. O conteudo contem topbar do participante, area rolavel, loading/estado inicial e composer fixo.

## Modelo minimo

Evite o modelo demo em que `contactId` tambem representa o autor. Prefira conceitos explicitos:

```ts
interface ConversationMessage {
  id: string;
  clientMessageId?: string;
  conversationId: string;
  senderId: string;
  body: string;
  sentAt: string;
  status: 'pending' | 'sent' | 'delivered' | 'read' | 'failed';
}
```

O backend valida participante, escopo, tenant, anexo e permissao em toda leitura/envio.

## Tempo real

- Historico inicial e paginacao podem usar HTTP; atualizacoes podem usar WebSocket/SSE conforme arquitetura aprovada.
- Reconnect nao pode duplicar mensagens. Use ID oficial e `clientMessageId` para reconciliar envio otimista.
- Ordene por sequencia/instante confiavel do servidor, nao pelo relogio local isolado.
- Diferencie entregue, lido e apenas recebido pelo client.
- Presenca e digitacao sao efemeras e nao devem virar autoridade de disponibilidade.
- Limpe conexoes/subscriptions ao destruir a feature ou trocar contexto.

## Privacidade e moderacao

- Mensagem privada nao aparece em log, analytics, erro tecnico ou notificacao de tela bloqueada sem politica explicita.
- Restrinja conversas por participante, canal, assunto e periodo.
- Aplique horario de atendimento, ausencia, fila, moderacao e encerramento quando exigidos por `COM-005..006`.
- Anexos exigem tipo/tamanho, verificacao, storage protegido e download autorizado.
- Proteja menores, dados pedagogicos e compartimentos restritos; busca global nao deve indexar conteudo indevido.

## Resultado esperado

Entregue conversa responsiva com historico paginado, envio resiliente e atualizacao em tempo real coerente, mantendo o UX da app Chat e removendo comportamento de demo. Relate transporte escolhido, politica de deduplicacao/reconexao e controles de privacidade.

## Checklist

- Tipo de conversa e participantes estao explicitos.
- IDs de conversa, mensagem, autor e client message nao foram confundidos.
- Historico usa cursor/paginacao e loading incremental.
- Envio e idempotente, exibe pendente/falha e permite retry seguro.
- Reconnect deduplica e preserva ordem.
- Auto-scroll nao rouba posicao de quem esta lendo mensagens antigas.
- Composer funciona por teclado sem envio duplicado.
- Novas mensagens e erros sao anunciados de forma acessivel.
- Conteudo/anexos nao vazam para logs/telemetria.
- Permissao, moderacao, horario e encerramento foram avaliados.

