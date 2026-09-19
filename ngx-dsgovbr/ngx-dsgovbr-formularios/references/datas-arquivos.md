# Datas e arquivos

## br-date-picker

- Seletor: `br-date-picker`
- Import: `GovBrDatePickerModule`
- Valor: `ControlValueAccessor`, parseado/formatado por `DateService`.
- Dependências: `ngx-bootstrap/datepicker`, `ngx-bootstrap/timepicker`, Moment.

Inputs:

- `name`
- `value` alias para valor inicial
- `disabled`, `datedisabled`
- `autocomplete` default `off`
- `iconSize` default `32px`
- `outsideClick` default `true`
- `direction` default `bottom`
- `adaptivePosition` default `false`
- `format` default `DD/MM/YYYY`
- `inline` default `false`
- `label`, `description`
- `showInput` default `true`
- `withTime` default `false`
- `placeholder`
- `density` default `medium`
- `clearable` default `false`
- `required`
- `showWeeks` default `false`
- `brDisabledDays`, `brDisabledMonths`, `brDisabledYears`
- `brMaxDate`, `brMinDate`
- `labelForId`
- `dateCustomClasses`
- `dateTooltipTexts`

Output:

- `dateChange`

Exemplo:

```html
<br-date-picker
  label="Data de início"
  formControlName="inicio"
  [brMinDate]="hoje"
  [brDisabledDays]="feriados"
  required>
</br-date-picker>
```

## br-daterange-picker

- Seletor: `br-daterange-picker`
- Import: `GovBrDatePickerModule`
- Valor: `Date[]`.

Inputs:

- `labelForId`, `readonly`, `value`, `placeholder`, `outsideClick`, `direction`, `adaptivePosition`, `format`, `label`, `description`, `density`, `required`, `showWeeks`, `brDisabledDays`, `brDisabledMonths`, `brDisabledYears`, `brMaxDate`, `brMinDate`, `datedisabled`.

Output:

- `dateChange`

Exemplo:

```html
<br-daterange-picker
  label="Período"
  formControlName="periodo"
  [brMinDate]="dataMinima"
  [brMaxDate]="dataMaxima">
</br-daterange-picker>
```

## br-decendio-picker

- Seletor: `br-decendio-picker`
- Import: `GovBrDatePickerModule`
- Valor: `Date`.
- Formato default: `Do/MM/YYYY`.

Inputs:

- `name`, `value`, `autocomplete`, `iconSize`, `outsideClick`, `direction`, `adaptivePosition`, `format`, `label`, `description`, `showInput`, `placeholder`, `density`, `clearable`, `required`, `showWeeks`, `brMaxDate`, `brMinDate`, `labelForId`, `dateCustomClasses`, `dateTooltipTexts`, `datedisabled`.

Output:

- `dateChange`

## br-file

- Seletor: `br-file`
- Import: `GovBrFileModule`
- Valor: `File` quando `multiple=false`; `FileList`/lista quando `multiple=true`.
- O componente também tem validador associado no seletor `br-file`.

Inputs:

| Nome | Tipo/default | Uso |
| --- | --- | --- |
| `label` | `string`, default `''` | Label. |
| `description` | `string`, default `''` | Ajuda. |
| `acceptedFiles` | `string` | Extensões/MIME aceitos. |
| `minFileSize` | `number`, default `1` | Tamanho mínimo em bytes. |
| `maxFileSize` | `number`, default `0` | Tamanho máximo em bytes; `0` não limita. |
| `maxFiles` | `number`, default `1` | Quantidade máxima. |
| `disabled` | `boolean`, default `false` | Estado. |
| `multiple` | `boolean`, default `false` | Múltiplos arquivos. |
| `density` | `string`, default `medium` | Densidade. |
| `selectFileLabel` | `string` | Texto do botão. |
| `required` | `boolean` | Obrigatório. |
| `labelForId` | `string` gerado | Label. |

Output:

- `changeFile`

Exemplo:

```html
<br-file
  label="Anexo"
  formControlName="anexo"
  acceptedFiles=".pdf,.png"
  [maxFileSize]="5_000_000"
  [maxFiles]="1"
  required>
</br-file>
```

Cuidados:

- `acceptedFiles`, `minFileSize`, `maxFileSize` e `maxFiles` alimentam o validador do próprio `br-file`.
- Não use `brMaxFileSize` no `br-file` novo se já estiver passando `maxFileSize`; `brMaxFileSize` é diretiva legada separada para `File`.
