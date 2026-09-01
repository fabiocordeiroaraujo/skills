# Padrao UX da app Calendar

## Mapa local

| Responsabilidade | Arquivo |
| --- | --- |
| Feature module | `frontend/src/app/views/calendar/calendar.module.ts` |
| Rota | `frontend/src/app/views/calendar/calendar-routing.module.ts` |
| View e interacoes | `frontend/src/app/views/calendar/calendar/` |
| Dialog de evento | `frontend/src/app/views/calendar/calendar-form-dialog/` |
| Service demo | `frontend/src/app/views/calendar/calendar-app.service.ts` |
| Modelo adapter | `frontend/src/app/shared/models/calendar-event.model.ts` |
| Estilos | `frontend/src/assets/styles/app/globals/components/_calendar.scss` |
| Eventos em memoria | `frontend/src/app/shared/inmemory-db/calendar-events.ts` |

## Dependencias

`CalendarAppModule` importa:

- `CalendarModule.forRoot()` com adapter `date-fns`;
- `ReactiveFormsModule`;
- `NgbModule`;
- `ColorPickerModule`;
- routing.

O projeto usa `angular-calendar` 0.31.0 e `date-fns` 2.30.0. Antes de alterar APIs da biblioteca, consulte a documentacao compativel com essas versoes ou o codigo/tipos instalados.

## Toolbar e views

O template demonstra:

- `mwlCalendarPreviousView`, `mwlCalendarToday`, `mwlCalendarNextView`;
- titulo com `calendarDate:(view + 'ViewTitle'):'en'`;
- alternancia entre `month`, `week` e `day`;
- botoes de icone arredondados;
- card sem padding em volta da view.

Melhorias necessarias:

- tipar `view` com o tipo da biblioteca/union;
- usar locale do usuario/tenant em vez de `'en'` fixo;
- adicionar `aria-label` aos botoes de icone;
- marcar view ativa com `aria-pressed`;
- manter uma lista/agenda textual alternativa;
- adaptar toolbar em mobile sem sobreposicao.

## View mensal, semanal e diaria

As tres views recebem `viewDate`, `events` e `refresh`. Mes tambem recebe `activeDayIsOpen` e `dayClicked`. Todas ligam `eventClicked` e `eventTimesChanged`.

Carregue eventos pelo intervalo da view:

- mes: grade visivel pode incluir dias do mes anterior/seguinte;
- semana: inicio/fim segundo locale institucional;
- dia: limites locais do fuso da instituicao.

Use `switchMap` ou mecanismo equivalente para cancelar intervalo antigo ao navegar rapidamente.

## Modelo e adapter

`CalendarAppEvent implements CalendarEvent` adiciona `_id` e `meta.location/notes`. O construtor atual tem armadilhas:

```ts
this.draggable = data.draggable || true;
```

Isso torna `false` impossivel. O mesmo ocorre em `resizable`. Use nullish coalescing:

```ts
this.draggable = data.draggable ?? false;
```

Prefira um modelo de dominio separado e funcao adapter:

```ts
interface AcademicCalendarItem {
  id: string;
  kind: 'class' | 'assessment' | 'holiday' | 'meeting';
  title: string;
  startsAt: string;
  endsAt?: string;
  allDay: boolean;
  timeZone?: string;
  editable: boolean;
}

function toCalendarEvent(item: AcademicCalendarItem): CalendarEvent { /* mapping */ }
```

Actions, cor e `draggable/resizable` derivam de tipo, estado e permissao; nao de defaults gerais.

## Dialog

`CalendarFormDialogComponent` usa form untyped com `_id`, title, start/end, allDay, color e meta. Ele inicializa duas vezes e usa `setTimeout(100)` para aguardar inputs.

Substitua por:

- `@Input`/dados de modal definidos antes da abertura e inicializacao unica;
- Reactive Form tipado;
- labels, erros e `aria-describedby`;
- validacao de inicio/fim, dia inteiro, conflito e limites;
- categoria/paleta semantica em vez de cor livre quando apropriado;
- botoes Cancelar/Salvar e delete separado conforme permissao;
- `btn-loading` e erro sem fechar o modal.

## CRUD e refresh

`CalendarAppService` mantem array em memoria e devolve toda a colecao apos add/update/delete. Para produto, crie client tipado por intervalo e facade de estado.

Comandos recomendados:

```text
GET    /calendar-items?from=...&to=...&filters=...
POST   /calendar-items
PATCH  /calendar-items/{id}
DELETE ou comando de cancelamento conforme dominio
```

O contrato real vem do backend/OpenAPI. Use versao/ETag quando edicoes concorrentes forem possiveis.

## Drag e resize

O demo muta `event.start/end` antes da API e nao faz rollback. Padrao seguro:

1. capture snapshot;
2. mostre previa/otimismo quando adequado;
3. envie comando com versao/idempotencia;
4. em sucesso, aplique resposta oficial;
5. em conflito/erro, reverta e explique;
6. notifique publico afetado apenas depois da confirmacao.

Desabilite drag/resize para item sem permissao, publicado imutavel ou tipo que exige workflow.

## Cores e acessibilidade

O SCSS usa tema para hoje, badges e eventos abertos. Cor de evento nao pode ser a unica classificacao. Inclua rotulo, icone, padrao visual ou texto.

Color picker livre pode quebrar contraste e identidade. Prefira paleta de categorias prevalidada; mantenha picker apenas quando o dominio realmente permitir personalizacao.

## Antipadroes do demo

- `any`, form untyped e `Subject<any>`.
- service global com arrays em memoria.
- HTML de actions em string (`label: '<i ...>'`).
- `console.log` de eventos.
- locale `'en'` fixo.
- defaults `x || true` que ignoram `false`.
- mutacao antes da API sem rollback.
- `setTimeout` para inicializar dialog.
- delete modal com classe `.close` antiga e autofocus destrutivo.
- ausencia de loading, erro, conflito, permissao e intervalo de consulta.

## Capacidades relacionadas

- `CAL-001..007` em `requirements/product/04-capabilities.md`.
- `EVT-001..005` para eventos e autorizacoes.
- `SRV-005..007` para agenda de atendimento.
- Stack atual em `requirements/tech/02-stack.md`.

