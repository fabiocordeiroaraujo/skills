---
name: ux-app-calendar
description: "Reutilizar, adaptar, implementar ou revisar o padrao UX da app Calendar no frontend Angular Haggyo: calendario mensal/semanal/diario, navegacao temporal, eventos, modal de criacao/edicao, datepicker, cores, drag-and-drop, resize, exclusao e atualizacao da agenda. Use sempre que a tarefa envolver calendar, calendario, agenda, evento, horario, aula, prova, feriado, reuniao, agendamento, dia/semana/mes, angular-calendar ou conflito de horario em frontend/."
compatibility: Projeto Haggyo em frontend/ com Angular 19, angular-calendar 0.31, date-fns 2.30, ng-bootstrap, Reactive Forms e ngx-color-picker.
---

# UX App Calendar

## Objetivo

Usar a app Calendar como base visual e interativa para calendarios e agendas Haggyo, preservando views, navegacao, dialog e interacoes temporais. Defina primeiro a semantica: calendario academico, evento institucional, horario de aula, agenda de atendimento ou agenda individual possuem regras diferentes.

Use tambem `ux-visual-language`, `ux-layouts-navigation`, `ux-ui-components` e `ux-angular-feature` quando aplicaveis.

## Fluxo

1. Leia `references/padrao-calendar.md` e inspecione `frontend/src/app/views/calendar/`.
2. Identifique capacidade e escala temporal: `CAL`, `EVT`, `SRV` ou outra.
3. Defina data civil, instante, fuso, recorrencia, publico, permissao e politica de conflito.
4. Modele evento e filtros com tipos de dominio; use adapter para `CalendarEvent`.
5. Carregue apenas o intervalo visivel e cancele requisicoes obsoletas.
6. Implemente views e navegacao com labels acessiveis, estado de loading/vazio/erro e alternativa textual.
7. Implemente dialog com Reactive Form tipado, validacao temporal e acoes coerentes.
8. Trate drag/resize como comando sujeito a validacao, conflito, confirmacao e rollback.
9. Formate no idioma/fuso do contexto e teste mudanca de horario/fuso quando aplicavel.
10. Verifique desktop, mobile, teclado, leitor de tela e build.

## Estrutura reutilizavel

- Toolbar: anterior, hoje, proximo, titulo do periodo e alternancia mes/semana/dia.
- Card de calendario: `mwl-calendar-month-view`, `week-view` ou `day-view`.
- Evento: clique para detalhe/edicao; actions opcionais.
- Dialog: titulo, cores/categoria, inicio, fim, dia inteiro, local e observacoes.
- Exclusao: modal de confirmacao.
- Refresh: stream/signal que atualiza a biblioteca apos mutacao.

## Semantica temporal

- Nascimento, dia letivo e feriado sao datas civis; nao os converta como instante UTC.
- Reuniao online, aula com hora e auditoria sao instantes/intervalos com fuso explicito.
- A visualizacao usa o fuso da instituicao/contexto, nao necessariamente o do dispositivo.
- Valide `end >= start`, dia inteiro, sobreposicao, limites e recorrencia.
- Mudanca de evento publicado pode exigir versao, notificacao do publico afetado e historico.

## Capacidades Haggyo

- `CAL-001..007`: calendarios, dias letivos, horarios, conflitos, publicacao e alteracoes.
- `EVT-001..005`: evento, publico, capacidade, agenda, autorizacao e presenca.
- `SRV-005..007`: agenda de atendimento, reserva, reagendamento e lembrete.

Nao misture essas entidades somente porque todas aparecem no calendario. Use adapter/view model comum quando a visualizacao agregar fontes distintas.

## Resultado esperado

Entregue um calendario responsivo e acessivel que reutiliza a app Calendar, mas respeita fuso, permissao, conflito, publicacao e contrato do dominio escolhido. Relate intervalo carregado, semantica temporal e comportamento de drag/resize/rollback.

## Checklist

- Dominio do evento/calendario foi definido.
- Datas civis e instantes nao foram confundidos.
- Fuso e locale vem do contexto.
- Consulta usa intervalo visivel, nao o calendario inteiro.
- Dialog e modelo sao tipados e validam inicio/fim.
- Drag/resize trata erro, conflito e rollback.
- Excluir, cancelar e despublicar nao foram tratados como sinonimos.
- Cores possuem categoria/rotulo alternativo.
- Views e botoes tem nomes acessiveis e alternativa textual.
- Mudancas publicadas notificam somente o publico afetado quando exigido.

