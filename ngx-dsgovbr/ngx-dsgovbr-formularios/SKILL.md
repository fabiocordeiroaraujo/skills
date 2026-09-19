---
name: ngx-dsgovbr-formularios
description: "Cria, corrige e explica formulários Angular com @serpro/ngx-dsgovbr. Use quando o usuário pedir br-input, br-textarea, br-select, br-multiselect, br-typeahead, br-date-picker, br-daterange-picker, br-decendio-picker, br-file, br-checkbox, br-radio, br-switch, mensagens locais, validação CPF/CNPJ/data/arquivo, máscaras, template-driven forms ou reactive forms GovBR."
---

# ngx-dsgovbr formularios

## Quando usar

Use esta skill para montar campos GovBR, escolher entre `br-select` e componentes legados, integrar com `FormGroup`, validar dados e evitar nomes de inputs/outputs inventados.

## Guia rapido

Leia as referências conforme a tarefa:

- `references/inputs.md` para `br-input`, `br-textarea`, checkbox, radio e switch.
- `references/selects.md` para `br-select`, templates de select, multiselect e typeahead.
- `references/datas-arquivos.md` para date picker, daterange, decendio e file.
- `references/validadores-mensagens.md` para mensagens, máscaras, validações e receita completa de formulário reativo com input, select, data, arquivo, checkbox e switch.

Exemplo mínimo com reactive forms:

`exemplo-form.component.ts`

```ts
import { Component } from '@angular/core';
import { ReactiveFormsModule, FormControl, FormGroup, Validators } from '@angular/forms';
import { GovBrInputModule, GovBrSelectModule } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [ReactiveFormsModule, GovBrInputModule, GovBrSelectModule],
  templateUrl: './exemplo-form.component.html',
})
export class ExemploFormComponent {
  form = new FormGroup({
    cpf: new FormControl('', Validators.required),
    perfil: new FormControl(null, Validators.required),
  });
  perfis = ['Administrador', 'Atendente'];
}
```

`exemplo-form.component.html`

```html
<form [formGroup]="form">
  <br-input label="CPF" formControlName="cpf" brValidCpf mask="999.999.999-99"></br-input>
  <br-select label="Perfil" formControlName="perfil" [values]="perfis"></br-select>
</form>
```

## Decisoes importantes

- Prefira `br-select` para seleção simples, múltipla, busca, templates e typeahead. `br-multiselect` e `br-typeahead` estão marcados como deprecated no código.
- Para exemplos de componentes, prefira `templateUrl` e mostre o HTML em arquivo `.component.html`; evite colocar HTML em `template` inline dentro do `.ts`, salvo quando o projeto consumidor já seguir esse padrão.
- Use os nomes públicos dos aliases: `label`, `description`, `readonly`, `maxlength`, `maxLength`, `mask`, `currency`, `required`, `brValidCpf`, `brValidCnpj`, `brValidCpfCnpj`.
- Os componentes de campo principais implementam `ControlValueAccessor`; use `formControlName`, `formControl` ou `ngModel` para valor.
- `br-local-messages` e `br-form-error` estão marcados como deprecated; prefira mensagens embutidas dos componentes novos e `br-tpl-err-customError` quando precisar customizar.
- Quando gerar formulário real, inclua imports, `FormGroup`, controles, lista de opções e template em arquivo `.html`; não entregue apenas tags HTML soltas.

## Validacao

Antes de entregar código:

- O módulo correto foi importado de `@serpro/ngx-dsgovbr`.
- O campo com `ControlValueAccessor` está ligado a form control ou `ngModel`.
- Seletores, inputs e outputs correspondem aos arquivos da lib.
- Validações usam `brValidCpf`, `brValidCnpj`, `brValidCpfCnpj`, `brMinDate`, `brMaxDate`, `brDisabledDays`, `brMaxFileSize` ou propriedades reais do componente.
- Componentes deprecated foram evitados ou justificados.
