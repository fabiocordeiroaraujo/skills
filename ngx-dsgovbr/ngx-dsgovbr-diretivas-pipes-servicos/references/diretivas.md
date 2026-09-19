# Diretivas publicas

## Importacao

Agregador:

```ts
import { GovBrDirectivesModule } from '@serpro/ngx-dsgovbr';
```

O arquivo `directives.module.ts` marca `GovBrDirectivesModule` como deprecated e recomenda diretivas/components standalone, mas ele ainda é exportado e pode ser útil para compatibilidade.

## Validadores

| Seletor | Classe | Erro/efeito |
| --- | --- | --- |
| `[brValidCpf]` | `CpfValidatorDirective` | Valida CPF; erro `invalidCpf`; bloqueia caracteres não numéricos. |
| `[brValidCnpj]` | `CnpjValidatorDirective` | Valida CNPJ; erro `invalidCnpj`; máscara base `AA.AAA.AAA/AAAA-99`. |
| `[brValidCpfCnpj]` | `CpfCnpjValidatorDirective` | Usa CPF até 11 caracteres e CNPJ acima disso. |
| `[brMinDate]` | `MinDateValidatorDirective` | Valida `Date` ou `Date[]`; erro `invalidMinDate`. |
| `[brMaxDate]` | `MaxDateValidatorDirective` | Valida `Date` ou `Date[]`; erro `invalidMaxDate`. |
| `[brDisabledDays]` | `DisabledDaysValidatorDirective` | Bloqueia dias; erro `invalidDay`. |
| `[brDisabledMonths]` | `DisabledMonthsValidatorDirective` | Bloqueia meses; erro `invalidMonth`. |
| `[brDisabledYears]` | `DisabledYearsValidatorDirective` | Bloqueia anos; erro `invalidYear`. |
| `[brMaxFileSize]` | `MaxFileSizeValidatorDirective` | Valida `File`; erro `invalidFileSize`. |
| `br-file` | `BRFileValidatorDirective` | Valida `acceptedFiles`, `minFileSize`, `maxFileSize`, `maxFiles` do componente. |

Exemplo:

```html
<input name="cpf" [(ngModel)]="cpf" brValidCpf brInputMask="999.999.999-99" />
<br-date-picker formControlName="data" [brMinDate]="inicio" [brMaxDate]="fim"></br-date-picker>
```

## Mascaras e transformacoes

| Seletor | Inputs | Efeito |
| --- | --- | --- |
| `[brInputMask]` | `brInputMask`, `brInputMaskInvalidAllowed`, `brPartialFormat`, `brimNiDinamico` | Máscara em inputs template-driven. |
| `[brReactiveInputMask]` | `brReactiveInputMask`, `brReactiveInputMaskInvalidAllowed` | Máscara em reactive forms legado. |
| `[brCurrency]` | `brCurrency`, `brAllowNegative` | Moeda; formato `inteiros.decimais`, ex: `11.2`. |
| `[brPhoneMask]` | nenhum | Telefone, max length 15. |
| `[brNumbersOnly]` | boolean pelo seletor | Remove tudo exceto dígitos. |
| `[brUpperCase]` | boolean pelo seletor | Converte para maiúsculas. |
| `[brLowerCase]` | boolean pelo seletor | Converte para minúsculas. |
| `[brRemoveAcentos]` | nenhum | Remove acentos e reemite `input`. |

## Comportamento e UI

| Seletor | Inputs/outputs | Uso |
| --- | --- | --- |
| `[brClearMessages]` | nenhum | Limpa mensagens globais em cliques. |
| `[brHasError]` | `brHasError` | Deprecated; aplica classes `ng-invalid`/`ng-valid`. |
| `[brFocus]` | `brFocus`, `brFocusIndex` | Solicita foco em alvo retornado por `focusCssSelector`. |
| `[brLabelInfo]` | `icon`, `color`, output `infoClick` | Ícone de ajuda clicável junto ao label. |

## Templates de erro

Diretivas exportadas por `GovBrDirectivesModule`:

- `[br-tpl-err-required]`
- `[br-tpl-err-pattern]`
- `[br-tpl-err-minlength]`
- `[br-tpl-err-maxLength]`, `[br-tpl-err-maxlength]`
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

Várias estão marcadas como deprecated no código. Para componentes novos, prefira `br-tpl-err-customError`.

## Templates de componentes

Select:

- `[br-tpl-select-option]`
- `[br-tpl-select-header]`
- `[br-tpl-select-label]`
- `[br-tpl-select-multi-label]`

Tabela:

- `[brTableTplActions]`

Lista:

- `[br-tpl-list-item]`

Exemplo tabela:

```html
<ng-template brTableTplActions let-row="row">
  <button class="br-button circle small" type="button" (click)="abrir(row)">
    <i class="fas fa-eye" aria-hidden="true"></i>
  </button>
</ng-template>
```

## Receita completa: diretivas em formulário standalone

Use este padrão quando a tela combina validação CPF/CNPJ, máscara, caixa alta, números e limpeza de mensagens.

`diretivas-formulario.component.ts`

```ts
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { GovBrDirectivesModule } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [FormsModule, GovBrDirectivesModule],
  templateUrl: './diretivas-formulario.component.html',
})
export class DiretivasFormularioComponent {
  cpf = '';
  processo = '';
  telefone = '';
}
```

`diretivas-formulario.component.html`

```html
<form>
  <label class="br-label" for="cpf">CPF</label>
  <input
    id="cpf"
    class="br-input"
    name="cpf"
    [(ngModel)]="cpf"
    brValidCpf
    brInputMask="999.999.999-99" />

  <label class="br-label" for="processo">Processo</label>
  <input
    id="processo"
    class="br-input"
    name="processo"
    [(ngModel)]="processo"
    brUpperCase
    brRemoveAcentos />

  <label class="br-label" for="telefone">Telefone</label>
  <input
    id="telefone"
    class="br-input"
    name="telefone"
    [(ngModel)]="telefone"
    brPhoneMask />

  <button class="br-button secondary" type="button" brClearMessages>
    Limpar mensagens
  </button>
</form>
```
