---
name: ux-app-inbox
description: "Reutilizar, adaptar, implementar ou revisar o padrao UX da app Inbox no frontend Angular Haggyo: navegacao por pastas/categorias, lista de mensagens, painel de leitura master-detail, acoes de responder/encaminhar/excluir, compose modal, contadores, lido/nao lido e sidebars responsivas. Use sempre que a tarefa envolver inbox, caixa de entrada, comunicados, central de mensagens, notificacoes, mensagens recebidas/enviadas, compose, leitura ou master-detail de correspondencia em frontend/."
compatibility: Projeto Haggyo em frontend/ com Angular 19, NgModule, ng-bootstrap, SharedDirectivesModule e estilos UX de inbox.
---

# UX App Inbox

## Objetivo

Usar a app Inbox como padrao para comunicacao assincrona e leitura master-detail, preservando suas tres regioes responsivas: categorias, lista e conteudo. Substitua os mocks e links cenograficos por capacidades Haggyo de comunicacao, entrega e leitura.

Use tambem `ux-visual-language`, `ux-layouts-navigation`, `ux-ui-components` e `ux-angular-feature` quando aplicaveis.

## Fluxo

1. Leia `references/padrao-inbox.md` e inspecione `frontend/src/app/views/inbox/`.
2. Defina se a jornada e comunicado, notificacao operacional, conversa, protocolo ou tarefa; nao force tudo a parecer e-mail.
3. Modele categorias, resumo, conteudo, destinatarios, entrega/leitura e acoes com tipos explicitos.
4. Preserve a composicao de sidebars apenas quando master-detail melhorar a jornada.
5. Implemente dados por feature facade/client, com paginacao, busca, loading, vazio, erro e selecao por ID.
6. Renderize conteudo com seguranca; nao injete HTML remoto nao confiavel.
7. Implemente compose como Reactive Form tipado, com destinatario/publico, assunto, corpo, anexos e revisao conforme capacidade.
8. Aplique permissoes, consentimento, horario, moderacao, idempotencia e protecao de destinatarios.
9. Verifique teclado, foco, leitor de tela e transicao mobile entre lista e detalhe.

## Estrutura reutilizavel

```text
Inbox shell
|-- sidebar principal: categorias/pastas e Compose
`-- container secundario
    |-- sidebar: lista/resumos de mensagens
    `-- content: toolbar + detalhe/estado inicial
```

O padrao usa `appSidebarContainer`, `appSidebarContent`, `appSidebar` e `appSidebarToggler`. IDs de toggler e sidebar devem coincidir.

## Comunicacao Haggyo

- `COM-001..009` orientam publico, template, canais, entrega, leitura, conversa e centralizacao.
- Mensagem deve respeitar tenant, unidade, papel, turma, aluno, consentimento e publico autorizado.
- Evite exposicao de destinatarios e disparo duplicado; mostre previa e estimativa de custo quando aplicavel.
- Registre entrega, falha, leitura e confirmacao sem rastreamento excessivo.
- Conteudo de mensagem e dado sensivel: nao envie a logs, analytics ou notificacao de tela bloqueada sem necessidade.
- Diferencie comunicado broadcast, mensagem privada, notificacao automatica e protocolo.

## Resultado esperado

Entregue uma inbox responsiva com categorias, lista, leitura e compose coerentes com o UX existente, integrada a dados reais e segura para comunicacao escolar. Explique qual semantica de comunicacao foi escolhida e quais acoes/estados foram implementados.

## Checklist

- Sidebar principal, lista e detalhe possuem papeis claros.
- Selecao usa ID estavel e e compartilhavel apenas quando seguro.
- Loading, vazio, erro, sem selecao e acesso negado estao completos.
- Conteudo HTML e sanitizado ou renderizado por formato controlado.
- Compose usa Reactive Form tipado e impede envio repetido.
- Publico/destinatarios, consentimento e permissao foram validados.
- Lido/nao lido e entrega/falha nao foram confundidos.
- Acoes sao botoes reais, nao `href="#"`.
- Mobile e teclado permitem alternar lista/detalhe com foco coerente.
- Dados e texto de mensagens nao vazam para logs/telemetria.

