# Feedback e acoes

## Indice

- Alertas: `br-alert-messages` e `AlertMessageService`.
- Confirmação: `br-confirmation` e `br-confirmation-button`.
- Janelas e estados: `br-modal`, `br-loading`, `br-cookie-bar`, `br-onboarding`.
- Header e ações auxiliares: `br-notifications`, `br-fab-pane`, `br-fieldset`, `br-toggle`.
- Receitas completas: salvar com loading/alerta/confirmação e modal de edição.

## br-alert-messages e AlertMessageService

- Seletor: `br-alert-messages`
- Import: `GovBrAlertMessagesModule`
- Input: `onlyFor?: string`.

Renderize uma vez na página/layout:

```html
<br-alert-messages></br-alert-messages>
```

API do serviço:

- `success(title, description?, details?, options?, target?)`
- `info(title, description?, details?, options?, target?)`
- `warn(title, description?, details?, options?, target?)`
- `error(title, description?, details?, options?, target?)`
- `apiError(erros: ApiError[])`
- `dismiss(message)`
- `dismissAll()`
- `showMore(message)`
- `messageClicked(message)`
- `onMessageClicked()`
- `onShowMore()`
- `pushAll(alertMessages)`
- `getMessages$()`

`AlertMessage`:

- `type: 'SUCCESS' | 'INFO' | 'WARN' | 'ERROR'`
- `title`
- `description`
- `details?: any[] | string[] | Resource[]`
- `count`
- `options`
- `target`

`AlertMessageOptions`:

- `dismissible`
- `delay`
- `cssTypeClass`
- `cssSize`
- `cssTypeIcon`
- `typeDescription`
- `hasMore` deprecated.

Exemplo:

```ts
this.alerts.error('Falha ao salvar', 'Verifique os campos obrigatórios.', [], {
  dismissible: true,
  delay: 0,
});
```

## br-confirmation

- Seletor: `br-confirmation`
- Import: `GovBrConfirmationsModule`
- Métodos públicos: `show(data?)`, `hide()`.

Inputs:

- `popupTitle`
- `ignoreBackdropClick` default `true`
- `includeBackdrop` default `true`
- `ignoreEscapeKey` default `false`
- `question`
- `acceptLabel` default `Sim`
- `rejectLabel` default `Não`
- `modalClass`

Outputs:

- `accept`
- `reject`

Exemplo:

```html
<br-confirmation
  #confirmacao
  popupTitle="Excluir registro"
  question="Confirma a exclusão?"
  (accept)="excluir($event)">
</br-confirmation>

<button class="br-button danger" type="button" (click)="confirmacao.show(registro)">
  Excluir
</button>
```

## br-confirmation-button

- Seletor: `br-confirmation-button`
- Import: `GovBrConfirmationButtonModule`

Inputs:

- `labels` default `['Não', 'Sim']`
- `labelsTips`
- `question` default `Confirma Operação?`
- `title`
- `disabled`
- `autoClose` default `true`
- `buttonTriggerClass` default `br-button small circle`

Outputs:

- `primarySelection`
- `secondarySelection`

Quando `autoClose=false`, o output emite `{ label, modalRef }` para o chamador fechar manualmente.

## br-modal

- Seletor: `br-modal`
- Import: `GovBrModalModule`
- Métodos públicos: `show()`, `close()`.
- `BrModalSize = 'lg' | 'md' | 'sm'`.

Inputs:

- `title` default `''`
- `buttonTriggerLabel` default `Abrir`
- `buttonTriggerClass` default `br-button primary`
- `modalClass` default `''`
- `icon` default `''`
- `size` default `md`
- `disabled` default `false`
- `closeButton` default `true`
- `includeBackdrop` default `true`
- `closeOnbackdropClick` default `true`
- `closeOnEscapeKey` default `true`
- `resizeable` default `true`

Outputs:

- `onShow`
- `onHide`

## br-loading

- Seletor: `br-loading`
- Import: `GovBrLoadingModule`

Inputs:

- `visible` default `false`
- `label` default `Carregando`
- `size` default `medium`
- `backdrop` default `true`

Exemplo:

```html
<br-loading [visible]="salvando" label="Salvando dados" size="medium"></br-loading>
```

## br-cookie-bar

- Seletor: `br-cookie-bar`
- Import: `GovBrCookieBarModule`
- Depende do objeto global `core.BRCookiebar`, normalmente fornecido por `@govbr-ds/core/dist/core-init.js`.

Inputs:

- `json`
- `lang` default `pt-br`
- `mode: 'default' | 'open'`, default `default`

Output:

- `callback`

Método:

- `open()`

Exemplo:

```html
<br-cookie-bar
  #cookies
  [json]="politicaCookiesJson"
  mode="default"
  (callback)="onCookie($event)">
</br-cookie-bar>
```

## br-onboarding

- Seletor: `br-onboarding`
- Import: `GovBrOnBoardingModule`
- Dependências: `angular-shepherd`, `shepherd.js`, `ngx-bootstrap/modal`.

Inputs:

- `wellcomeModal?: BrWellcomeModal`
- `modalMode` default `true`
- `autoStart` default `true`
- `showModalCloseButton` default `false`
- `defaultStepOptions?: StepOptions`
- `steps: StepOptions[]`

Outputs:

- `next: number`
- `back: number`
- `skip`
- `complete`

`BrWellcomeModal`:

- `title`
- `text`
- `image`

Exemplo:

```ts
steps = [
  {
    id: 'campo-busca',
    attachTo: { element: '#busca', on: 'bottom' },
    title: 'Busca',
    text: 'Use este campo para localizar registros.',
  },
];
```

```html
<br-onboarding [steps]="steps" [autoStart]="false" (complete)="onTourFim()"></br-onboarding>
```

## br-notifications

- Seletor: `br-notifications`
- Normalmente usado dentro do header.
- Inputs: `route`, `icon` default `fas fa-envelope`, `user`, `showNotifications`.
- Outputs: `logout`, `close`.
- Dados via `NotificationService`.

## br-fab-pane

- Seletor: `br-fab-pane`
- Import: `GovBrFabPaneModule`
- Inputs: `height` default `4rem`, `zIndex` default `2`, `marginLeft` default `0px`.

Use para barra fixa de ações flutuantes.

## br-fieldset e br-sub-fieldset

`br-fieldset`:

- Import: `GovBrFieldsetModule`
- Input: `fieldsetTitle`.

`br-sub-fieldset`:

- Import: `GovBrSubFieldsetModule`
- Input: `fieldsetTitle` default `''`.

## br-toggle

- Seletor: `br-toggle`
- Import: `GovBrToggleModule`
- Model: `show` default `false`.
- Input: `title` default `Expandir/Contrair`.
- Output: `expanded: boolean`.

Exemplo:

```html
<br-toggle [(show)]="mostrarFiltros" (expanded)="onExpandiu($event)" title="Filtros"></br-toggle>
<section *ngIf="mostrarFiltros">...</section>
```

## Cuidados

- `br-confirmation` e `br-modal` são imperativos por `ViewChild`; não invente inputs como `[open]`.
- `br-loading` é declarativo com `[visible]`.
- `br-cookie-bar` precisa dos scripts globais do GovBR core para funcionar.
- `AlertMessageService.pushAll()` limpa mensagens anteriores antes de inserir as novas.
- Para alertas com links navegáveis, `details` pode receber `Resource[]`.

## Receita completa: salvar com loading, alerta e confirmação

Use este padrão quando uma ação precisa pedir confirmação, bloquear a tela e exibir retorno global.

`salvar-com-feedback.component.ts`

```ts
import { Component, ViewChild } from '@angular/core';
import {
  AlertMessageService,
  GovBrAlertMessagesModule,
  GovBrConfirmationsModule,
  GovBrLoadingModule,
} from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrAlertMessagesModule, GovBrConfirmationsModule, GovBrLoadingModule],
  templateUrl: './salvar-com-feedback.component.html',
})
export class SalvarComFeedbackComponent {
  salvando = false;

  constructor(private alertMessages: AlertMessageService) {}

  async salvarConfirmado() {
    this.salvando = true;
    this.alertMessages.dismissAll();

    try {
      await this.salvarNoBackend();
      this.alertMessages.success('Registro salvo', 'As alterações foram gravadas com sucesso.');
    } catch (error) {
      this.alertMessages.error('Falha ao salvar', 'Tente novamente ou acione o suporte.', [], {
        dismissible: true,
        delay: 0,
      });
    } finally {
      this.salvando = false;
    }
  }

  private salvarNoBackend(): Promise<void> {
    return Promise.resolve();
  }
}
```

`salvar-com-feedback.component.html`

```html
<br-alert-messages></br-alert-messages>

<br-loading [visible]="salvando" label="Salvando registro"></br-loading>

<br-confirmation
  #confirmacaoSalvar
  popupTitle="Salvar registro"
  question="Confirma o salvamento das alterações?"
  acceptLabel="Salvar"
  rejectLabel="Cancelar"
  (accept)="salvarConfirmado()">
</br-confirmation>

<button class="br-button primary" type="button" (click)="confirmacaoSalvar.show()">
  Salvar
</button>
```

## Receita completa: modal de edição

Use `br-modal` por `ViewChild` quando a abertura/fechamento depende de eventos da tela.

`modal-edicao.component.ts`

```ts
import { Component, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { GovBrModalModule, ModalComponent } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [FormsModule, GovBrModalModule],
  templateUrl: './modal-edicao.component.html',
})
export class ModalEdicaoComponent {
  @ViewChild('modalEdicao') modalEdicao!: ModalComponent;

  usuario = { id: 1, nome: 'Ana' };
  selecionado = { ...this.usuario };

  abrir(usuario: any) {
    this.selecionado = { ...usuario };
    this.modalEdicao.show();
  }

  salvar() {
    this.usuario = { ...this.selecionado };
  }

  limparSelecao() {
    this.selecionado = { ...this.usuario };
  }
}
```

`modal-edicao.component.html`

```html
<button class="br-button secondary" type="button" (click)="abrir(usuario)">
  Editar
</button>

<br-modal #modalEdicao title="Editar usuário" size="lg" (onHide)="limparSelecao()">
  <div>
    <label class="br-label" for="nome">Nome</label>
    <input id="nome" class="br-input" name="nome" [(ngModel)]="selecionado.nome" />
  </div>

  <div brModalFooter>
    <button class="br-button secondary" type="button" (click)="modalEdicao.close()">Cancelar</button>
    <button class="br-button primary" type="button" (click)="salvar(); modalEdicao.close()">Salvar</button>
  </div>
</br-modal>
```
