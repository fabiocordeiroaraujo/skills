# Validadores, mascaras e mensagens

## Validadores e mascaras nos campos

Diretivas úteis em formulários:

| Seletor | Função | Inputs/observações |
| --- | --- | --- |
| `[brValidCpf]` | Valida CPF e restringe digitação numérica. | Erro `invalidCpf`; vazio é válido. |
| `[brValidCnpj]` | Valida CNPJ e restringe máscara CNPJ. | Erro `invalidCnpj`; máscara `AA.AAA.AAA/AAAA-99`. |
| `[brValidCpfCnpj]` | Decide CPF ou CNPJ pelo tamanho. | Usa CNPJ quando passa de 11 caracteres sem símbolos. |
| `[brCurrency]` | Máscara de moeda. | `brCurrency="11.2"` define inteiros/decimais; `brAllowNegative`. |
| `[brInputMask]` | Máscara genérica. | `brInputMask`, `brInputMaskInvalidAllowed`, `brPartialFormat`. |
| `[brReactiveInputMask]` | Máscara para reactive forms legado. | `brReactiveInputMask`, `brReactiveInputMaskInvalidAllowed`. |
| `[brPhoneMask]` | Máscara de telefone. | Máximo 15 caracteres. |
| `[brNumbersOnly]` | Mantém apenas dígitos. | Aceita boolean pelo próprio seletor. |
| `[brUpperCase]` | Converte para maiúsculas. | Aceita boolean pelo próprio seletor. |
| `[brLowerCase]` | Converte para minúsculas. | Falso desativa. |
| `[brRemoveAcentos]` | Remove acentos. | Dispara evento `input`. |
| `[brMinDate]` / `[brMaxDate]` | Valida limite de data. | Recebe `Date`. |
| `[brDisabledDays]` | Bloqueia dias específicos. | Recebe `Date[]`; erro `invalidDay`. |
| `[brDisabledMonths]` | Bloqueia meses. | Recebe `Date[]`; erro `invalidMonth`. |
| `[brDisabledYears]` | Bloqueia anos. | Recebe `Date[]`; erro `invalidYear`. |
| `[brMaxFileSize]` | Valida tamanho de `File`. | Recebe bytes; erro `invalidFileSize`. |
| `[brFocus]` | Solicita foco em elemento interno. | Recebe objeto com `focusCssSelector(index?)`. |
| `[brClearMessages]` | Limpa alertas ao clicar. | Usa `AlertMessageService.dismissAll()`. |
| `[brLabelInfo]` | Ícone clicável de ajuda no label. | Inputs `icon`, `color`; output `infoClick`. |

## Templates de erro

`GovBrDirectivesModule` ainda exporta templates de erro legados:

- `[br-tpl-err-required]`
- `[br-tpl-err-pattern]`
- `[br-tpl-err-minlength]`
- `[br-tpl-err-maxLength]` e `[br-tpl-err-maxlength]`
- `[br-tpl-err-email]`
- `[br-tpl-err-invalidCnpj]`
- `[br-tpl-err-invalidCpf]`
- `[br-tpl-err-min]`
- `[br-tpl-err-max]`
- `[br-tpl-err-date]`
- `[br-tpl-err-day]`
- `[br-tpl-err-month]`
- `[br-tpl-err-year]`
- `[br-tpl-err-minDate]`
- `[br-tpl-err-maxDate]`
- `[br-tpl-err-customError]`

O arquivo `directives.module.ts` marca vários desses tokens como deprecated. Para componentes novos (`br-input`, `br-textarea`, `br-date-picker`, `br-file`, `br-radio`), prefira `br-tpl-err-customError` quando a necessidade for customização pontual.

Exemplo:

```html
<br-input label="Nome" formControlName="nome" required>
  <ng-template br-tpl-err-customError let-error>
    Verifique o preenchimento do nome.
  </ng-template>
</br-input>
```

## br-local-messages e br-form-error

Status:

- `br-local-messages`: marcado como `@deprecated`.
- `br-form-error`: marcado como `@deprecated será removido`.

`br-local-messages` inputs:

- `requiredMessage`, `patternMessage`, `minlengthMessage`, `maxlengthMessage`, `emailMessage`, `cnpjMessage`, `cpfMessage`, `dateMessage`, `dayMessage`, `monthMessage`, `yearMessage`, `minDateMessage`, `maxDateMessage`, `fileSizeMessage`, `minMessage`, `maxMessage`, `control`.

`br-form-error` inputs:

- `formControl`, `label` default `Campo`, `showValidFeedback` default `false`.

Use só para manutenção de código legado. Para código novo, confie nas mensagens embutidas dos componentes e no `DefaultsService.messages`.

## DefaultsService para mensagens

`DefaultsService.messages` define mensagens padrão como:

- `required`
- `invalid`
- `minLengthMessage`
- `maxLengthMessage`
- `date`, `day`, `month`, `year`
- `minDate`, `maxDate`
- `email`, `cnpj`, `cpf`
- `min`, `max`
- `fileType`, `fileSize`, `maxFileSize`, `minFileSize`, `maxFiles`
- `forbidden`, `unauthenticated`

Pode usar `:label` em mensagens customizadas para referenciar o label do campo.

## Receita completa: formulario reativo

Use este padrão quando a tela precisar combinar campos, selects, datas, upload, máscaras e mensagens em um `FormGroup`.

`cadastro-servidor.component.ts`

```ts
import { Component } from '@angular/core';
import { ReactiveFormsModule, FormControl, FormGroup, Validators } from '@angular/forms';
import {
  GovBrCheckboxModule,
  GovBrDatePickerModule,
  GovBrFileModule,
  GovBrInputModule,
  GovBrSelectModule,
  GovBrSwitchModule,
  GovBrTextAreaModule,
} from '@serpro/ngx-dsgovbr';

interface Unidade {
  id: number;
  nome: string;
  sigla: string;
}

@Component({
  standalone: true,
  imports: [
    ReactiveFormsModule,
    GovBrInputModule,
    GovBrTextAreaModule,
    GovBrSelectModule,
    GovBrDatePickerModule,
    GovBrFileModule,
    GovBrCheckboxModule,
    GovBrSwitchModule,
  ],
  templateUrl: './cadastro-servidor.component.html',
})
export class CadastroServidorComponent {
  dataMinima = new Date(2020, 0, 1);
  dataMaxima = new Date();

  unidades: Unidade[] = [
    { id: 1, sigla: 'CGTI', nome: 'Coordenação de Tecnologia' },
    { id: 2, sigla: 'CGADM', nome: 'Coordenação Administrativa' },
  ];

  form = new FormGroup({
    cpf: new FormControl('', { nonNullable: true, validators: [Validators.required] }),
    email: new FormControl('', { nonNullable: true, validators: [Validators.required, Validators.email] }),
    unidadeId: new FormControl<number | null>(null, Validators.required),
    dataIngresso: new FormControl<Date | null>(null, Validators.required),
    documento: new FormControl<File | null>(null, Validators.required),
    observacao: new FormControl('', { nonNullable: true, validators: [Validators.maxLength(500)] }),
    confirmado: new FormControl(false, { nonNullable: true, validators: [Validators.requiredTrue] }),
    notificar: new FormControl(true, { nonNullable: true }),
  });

  salvar() {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    const payload = this.form.getRawValue();
  }
}
```

`cadastro-servidor.component.html`

```html
<form [formGroup]="form" (ngSubmit)="salvar()">
  <br-input
    label="CPF"
    description="Informe somente números ou cole o CPF formatado"
    formControlName="cpf"
    brValidCpf
    mask="999.999.999-99"
    required>
    <ng-template br-tpl-err-customError>
      CPF inválido ou não informado.
    </ng-template>
  </br-input>

  <br-input
    label="E-mail"
    type="email"
    formControlName="email"
    email
    required>
  </br-input>

  <br-select
    label="Unidade"
    formControlName="unidadeId"
    [values]="unidades"
    itemLabel="nome"
    itemValue="id"
    placeholder="Selecione a unidade"
    required>
    <ng-template br-tpl-select-option let-item>
      <strong>{{ item.sigla }}</strong>
      <span>{{ item.nome }}</span>
    </ng-template>
  </br-select>

  <br-date-picker
    label="Data de ingresso"
    formControlName="dataIngresso"
    [brMinDate]="dataMinima"
    [brMaxDate]="dataMaxima"
    required>
  </br-date-picker>

  <br-file
    label="Documento"
    description="Envie PDF com até 5 MB"
    formControlName="documento"
    acceptedFiles=".pdf"
    [maxFileSize]="5_000_000"
    required>
  </br-file>

  <br-textarea
    label="Observação"
    formControlName="observacao"
    [maxlength]="500">
  </br-textarea>

  <br-checkbox label="Confirmo os dados informados" formControlName="confirmado"></br-checkbox>
  <br-switch label="Receber notificações" labelOn="Sim" labelOff="Não" formControlName="notificar"></br-switch>

  <button class="br-button primary" type="submit" [disabled]="form.invalid">
    Salvar
  </button>
</form>
```
