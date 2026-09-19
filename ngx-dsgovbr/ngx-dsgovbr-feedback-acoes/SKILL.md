---
name: ngx-dsgovbr-feedback-acoes
description: "Cria e corrige feedback visual e ações interativas com @serpro/ngx-dsgovbr. Use quando o usuário pedir br-alert-messages, AlertMessageService, mensagens de sucesso/erro, confirmação, br-confirmation, br-confirmation-button, br-modal, br-loading, br-cookie-bar, br-onboarding, br-notifications, br-fab-pane, br-fieldset, br-sub-fieldset ou br-toggle."
---

# ngx-dsgovbr feedback e acoes

## Quando usar

Use esta skill para mensagens, confirmações, modais, loading, onboarding, barra de cookies, painéis fixos e agrupadores de formulário. Ela cobre componentes que normalmente aparecem como suporte a uma tela principal.

## Guia rapido

Leia `references/feedback-acoes.md` para APIs completas e receitas de salvar com loading/alerta/confirmação e modal de edição.

Exemplo de mensagens e loading:

`feedback.component.ts`

```ts
import { Component, inject } from '@angular/core';
import { GovBrAlertMessagesModule, GovBrLoadingModule, AlertMessageService } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrAlertMessagesModule, GovBrLoadingModule],
  templateUrl: './feedback.component.html',
})
export class FeedbackComponent {
  private alerts = inject(AlertMessageService);
  carregando = false;
  salvar() {
    this.alerts.success('Registro salvo', 'As alterações foram gravadas.');
  }
}
```

`feedback.component.html`

```html
<br-alert-messages></br-alert-messages>
<br-loading [visible]="carregando" label="Salvando"></br-loading>
<button class="br-button primary" type="button" (click)="salvar()">Salvar</button>
```

## Decisoes importantes

- Para mensagens globais, renderize `br-alert-messages` e injete `AlertMessageService`.
- Para exemplos de componentes, prefira `templateUrl` e mostre o HTML em arquivo `.component.html`; evite colocar HTML em `template` inline dentro do `.ts`, salvo quando o projeto consumidor já seguir esse padrão.
- Para confirmação programática, `br-confirmation` expõe método `show(data?)` via `ViewChild` e emite `accept`/`reject`.
- Para botão com confirmação embutida, `br-confirmation-button` emite `primarySelection` e `secondarySelection`.
- `br-cookie-bar` depende do JS global `@govbr-ds/core/dist/core-init.js` ou inicialização equivalente do Design System GovBR.
- `br-onboarding` depende de `angular-shepherd` e usa `StepOptions` do Shepherd.
- Quando gerar uma ação real, inclua `ViewChild` para `br-confirmation`/`br-modal` quando necessário e injete `AlertMessageService` em vez de simular mensagens manualmente.

## Validacao

Antes de entregar:

- O módulo `GovBrAlertMessagesModule` foi importado quando `AlertMessageService` for usado na tela.
- Modais e confirmações usam inputs reais (`includeBackdrop`, `ignoreBackdropClick`, `closeOnEscapeKey`, etc.).
- Loading recebe `[visible]`, nao chamadas imperativas inexistentes.
- Onboarding recebe `steps: StepOptions[]` e considera `autoStart`/`wellcomeModal`.
- Componentes de ação têm handlers para outputs críticos.
