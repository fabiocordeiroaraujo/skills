# Campos de entrada

## br-input

- Seletor: `br-input`
- Import: `GovBrInputModule`
- Valor: `ControlValueAccessor`; use `formControlName`, `[formControl]` ou `[(ngModel)]`.
- Módulo também importa diretivas internas de moeda, máscara e telefone.

Inputs públicos:

| Nome | Tipo/default | Observação |
| --- | --- | --- |
| `name` | `string` | Nome do campo. |
| `label` | `string` | Alias público de `labelSig`. |
| `description` | `string` | Texto auxiliar. |
| `placeholder` | `string` | Placeholder do input. |
| `disabled` | `boolean`, default `false` | Também pode vir do form control. |
| `readonly` | `boolean`, default `false` | Alias público. |
| `size` | `number` | Tamanho visual. |
| `icon` | `string`, default `''` | Ícone interno. |
| `clearable` | `boolean`, default `false` | Permite limpar. |
| `type` | `string`, default `text` | Tipo HTML do input. |
| `maxlength` / `maxLength` | `number` | Ambos são aceitos. |
| `showValidFeedback` | `boolean`, default `false` | Feedback visual de sucesso. |
| `faIcon` | `string | null` | Ícone Font Awesome acionável. |
| `faIconDisabled` | `boolean`, default `false` | Desabilita ícone auxiliar. |
| `faIconTip` | `string`, default `ícone auxiliar` | Tooltip do ícone. |
| `density` | `string`, default `medium` | Densidade visual. |
| `min` / `max` | `number` | Validação numérica. |
| `focus` | `boolean`, default `false` | Solicita foco. |
| `required` | `boolean | string` | Transformado para boolean. |
| `currency` | `number | string` | Ex: `"11.2"` para moeda com 11 inteiros e 2 decimais; desativa `mask`. |
| `labelForId` | `string` gerado | Id associado ao label. |
| `mask` | `string` | Máscara, ex: `999.999.999-99`. |
| `email` | `boolean | string` | Ativa validador de e-mail quando presente. |
| `brValidCnpj` | `boolean | string` | Ativa validação e máscara CNPJ. |
| `brValidCpf` | `boolean | string` | Ativa validação e máscara CPF. |
| `brValidCpfCnpj` | `boolean | string` | CPF/CNPJ dinâmico. |
| `pattern` | `string` | Pattern HTML/Angular. |
| `minLength` / `minlength` | `number` | Ambos são aceitos. |
| `autocomplete` | `string` | Atributo autocomplete. |

Outputs:

- `foco: EventEmitter<any>`
- `unmask: EventEmitter<string>`
- `faIconClick: EventEmitter<void>`

Exemplo:

```html
<br-input
  label="CNPJ"
  description="Informe apenas números ou cole o CNPJ formatado"
  formControlName="cnpj"
  brValidCnpj
  mask="AA.AAA.AAA/AAAA-99">
</br-input>
```

Cuidados:

- Não use o componente sem `NgControl`; o construtor usa `ngControl.valueAccessor`.
- Para CPF/CNPJ prefira os aliases `brValidCpf`, `brValidCnpj` e `brValidCpfCnpj`; não invente `cpf`, `cnpj` ou `validator`.

## br-textarea

- Seletor: `br-textarea`
- Import: `GovBrTextAreaModule`
- Valor: `ControlValueAccessor`.

Inputs:

- `readonly`, `label`, `description`, `placeholder`, `disabled`, `rows` default `3`, `cols`, `maxlength`, `remainingCharsLabel` default `Caracteres restantes:`, `showRemainingCharsAfter` default `0`, `required`, `labelForId`.

Exemplo:

```html
<br-textarea
  label="Justificativa"
  formControlName="justificativa"
  [maxlength]="500"
  [required]="true">
</br-textarea>
```

## br-checkbox

- Seletor: `br-checkbox`
- Import: `GovBrCheckboxModule`
- Valor: boolean via `ControlValueAccessor`.

Inputs:

- `labelForId`, `label`, `readonly`, `indeterminate`, `description`.

Exemplo:

```html
<br-checkbox label="Aceito os termos" formControlName="aceite"></br-checkbox>
```

## br-radio

- Seletor: `br-radio`
- Import: `GovBrRadioModule`
- Valor: item selecionado via `ControlValueAccessor`.
- Modelo: `BrRadioItem { value: any; label?: string; disabled?: boolean }`.

Inputs:

- `label`, `radioName`, `value`, `requiredInput`, `disabled`, `items`, `inline` default `true`, `clearable` default `false`, `description`.

Exemplo:

```ts
opcoes = [
  { value: 'S', label: 'Sim' },
  { value: 'N', label: 'Não' },
];
```

```html
<br-radio label="Ativo?" [items]="opcoes" formControlName="ativo"></br-radio>
```

## br-switch

- Seletor: `br-switch`
- Import: `GovBrSwitchModule`
- Valor: boolean via `ControlValueAccessor`.

Inputs:

- `label`, `labelOn`, `labelOff`, `density` default `medium`, `position` default `left`, `disabled`.

Exemplo:

```html
<br-switch label="Receber notificações" labelOn="Sim" labelOff="Não" formControlName="notificar"></br-switch>
```

## br-label

- Seletor: `br-label`
- Import: `GovBrLabelModule`
- Inputs: `texto`, `text`, `required`, `disabled`, `readonly`, `forId`.
- Use quando precisar renderizar label isolado; campos como `br-input` já usam label internamente.
