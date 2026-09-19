# Padrao UX da app Inbox

## Mapa local

| Responsabilidade | Arquivo |
| --- | --- |
| Feature module | `frontend/src/app/views/inbox/inbox.module.ts` |
| Rota | `frontend/src/app/views/inbox/inbox-routing.module.ts` |
| Shell, lista e leitura | `frontend/src/app/views/inbox/messages/` |
| Compose modal | `frontend/src/app/views/inbox/compose-dialog/` |
| Estilos | `frontend/src/assets/styles/app/globals/views/_inbox.scss` |
| Diretivas de sidebar | `frontend/src/app/shared/directives/sidebar.directive.ts` |
| API demonstrativa | `frontend/src/app/shared/services/data-layer.service.ts` |
| Mensagens mock | `frontend/src/app/shared/inmemory-db/mails.ts` |

## Dependencias e modulo

`InboxModule` importa `CommonModule`, `NgbModule`, `SharedDirectivesModule` e routing. O compose atual nao importa forms porque e apenas HTML sem binding; codigo de produto deve importar `ReactiveFormsModule`.

## Composicao de tres paineis

O HTML aninha dois `appSidebarContainer`:

1. `inbox-main-sidebar` com largura de `180px`: Compose e categorias.
2. `inbox-secondary-sidebar` com largura de `360px` (`280px` abaixo de `767px`): lista de mensagens.
3. `inbox-secondary-sidebar-content`: toolbar e conteudo selecionado.

As diretivas adicionam classes e manipulam margens/lados. Em mobile, `SidebarDirective` fecha automaticamente usando `Utils.isMobile()`. Nao replique as larguras no componente; elas pertencem a `_inbox.scss`.

Uso estrutural:

```html
<div appSidebarContainer class="inbox-main-sidebar-container">
  <div appSidebarContent>
    <div appSidebarContainer class="inbox-secondary-sidebar-container">
      <div appSidebarContent><!-- detalhe --></div>
      <aside appSidebar="inbox-secondary-sidebar"><!-- lista --></aside>
    </div>
  </div>
  <aside appSidebar="inbox-main-sidebar"><!-- categorias --></aside>
</div>
```

Considere elementos semanticos (`aside`, `nav`, `main`) mantendo as classes/diretivas.

## Categorias

O demo mostra Inbox, Sent, Starred, Trash e Spam. No Haggyo, escolha categorias pela semantica real, por exemplo:

- nao lidos/todos;
- comunicados;
- conversas;
- notificacoes operacionais;
- arquivados.

Evite simular pastas de e-mail se o backend organiza por canal, assunto ou contexto. Contadores vem da API e precisam de nome acessivel.

## Lista

Cada `.mail-item` tem avatar (15%), detalhes (60%) e data (25%). Acrescente conforme necessidade:

- estado lido/nao lido com texto/semantica alem de peso/cor;
- remetente institucional e contexto;
- assunto e preview seguro;
- data relativa com valor completo acessivel;
- entrega/falha quando for caixa de enviados;
- selecao ativa e foco por teclado.

Use paginacao/cursor e atualizacao incremental. Nao carregue historico ilimitado.

## Detalhe

O demo mostra remetente, foto, data, assunto e `[innerHTML]="selected.message"`. Esta e uma fronteira de seguranca:

- prefira corpo estruturado/texto e renderer controlado;
- se HTML for requisito, sanitize no limite e aplique politica explicita;
- bloqueie links/recursos perigosos e imagens remotas quando aplicavel;
- nunca use `bypassSecurityTrustHtml` como atalho;
- preserve mensagem original/versionada quando traducao ou acessibilidade gerar variante.

A toolbar demo usa links vazios para Reply, Forward e Delete. Substitua por `<button type="button">`, nomes acessiveis, permissao e comandos reais.

## Compose

O modal atual possui email, assunto e textarea sem form binding. Para Haggyo, o compose pode exigir:

- tipo/categoria/template;
- publico segmentado autorizado;
- assunto e corpo;
- anexos verificados;
- canais e fallback;
- agendamento, expiracao e recorrencia;
- preview, revisao/aprovacao e estimativa de custo;
- idempotency key.

Use Reactive Form tipado e `btn-loading`. Cancelar deve ser `type="button"`; enviar deve respeitar validacao e fechar somente apos resultado confirmado.

## Estados

Modele separadamente:

- carregando categorias/lista/detalhe;
- lista vazia;
- nenhum item selecionado;
- detalhe indisponivel/removido;
- erro recuperavel;
- sem permissao;
- enviando/enviado/falha parcial;
- offline ou atualizacao pendente quando aplicavel.

## Antipadroes do demo

- `Observable<any>` e `selected: any`.
- `DataLayerService`/mails em memoria.
- `[innerHTML]` de mensagem sem contrato de confianca.
- `<a href="#">` para comandos.
- compose sem Reactive Forms, labels ou envio real.
- contadores fixos e categorias cenograficas.
- estilos inline e classes Bootstrap antigas.
- ausencia de paginacao, busca, loading e erro.

## Capacidades relacionadas

- `COM-001`: comunicado segmentado.
- `COM-002`: templates, anexos, aprovacao, agenda/expiracao.
- `COM-003`: inbox e canais externos.
- `COM-004`: entrega, falha, leitura e confirmacao.
- `COM-005..006`: conversa, participantes, moderacao e atendimento.
- `COM-009`: notificacoes de outros modulos.

