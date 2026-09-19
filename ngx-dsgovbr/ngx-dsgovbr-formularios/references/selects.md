# Select, multiselect e typeahead

## br-select

- Seletor: `br-select`
- Import: `GovBrSelectModule`
- Valor: `ControlValueAccessor`; aceita single e multiple.
- Dependências: `@ng-select/ng-select`, `ngx-bootstrap/tooltip`, diretivas GovBR e label.

Inputs públicos:

| Nome | Tipo/default | Uso |
| --- | --- | --- |
| `value` | `model<any>` | Valor atual quando usado como signal/two-way. |
| `compareWith` | função | Comparador; default usa `itemValue`, depois `id`, depois referência/valor. |
| `inline` | `boolean`, default `false` | Layout inline. |
| `label` | `string` | Label. |
| `description` | `string`, default `''` | Texto auxiliar. |
| `labels` | `string[]` | Labels alternativos para valores simples. |
| `name` | `string`, default `select` | Nome. |
| `clearable` | `boolean`, default `true` | Mostra limpar. |
| `clearableItem` | `boolean`, default `false` | Deseleciona clicando no item. |
| `selectClass` | `string` | Classe customizada. |
| `unselectedValue` | `any`, default `null` | Valor quando limpar. |
| `values` | `any[]`, default `[]` | Lista de opções. |
| `disabled` | `model<boolean>`, default `false` | Também vem do form control. |
| `itemLabel` | `any` | Propriedade exibida. |
| `itemValue` | `any` | Propriedade usada como valor. |
| `dropdownPosition` | `DropdownPosition`, default `bottom` | Posição. |
| `notFoundText` | `string`, default `Não encontrado` | Texto sem resultado. |
| `multiple` | `boolean`, default `false` | Seleção múltipla. |
| `maxSelectedItemsToShow` | `number`, default `1` | Quantos selecionados exibir. |
| `maxSelectedItems` | `number` | Limite de seleção. |
| `customBody` | `boolean`, default `false` | Corpo customizado. |
| `density` | `string`, default `medium` | Densidade. |
| `addNew` | `boolean | (term) => result` | Permite adicionar item. |
| `addNewText` | `string`, default `Adicionar ` | Prefixo da ação. |
| `appendTo` | `string` | Container do dropdown. |
| `placeholder` | `string` | Placeholder. |
| `clearSearchOnAdd` | `boolean`, default `true` | Limpa busca ao adicionar. |
| `searchable` | `boolean`, default `true` | Habilita busca. |
| `valueMaxWidth` | `number` | Corta texto do valor. |
| `inputAttrs` | `{ [key: string]: string }` | Atributos extras. |
| `required` | `boolean`, default `false` | Alias com boolean transform. |
| `showSelectAll` | `boolean`, default `false` | Selecionar todos. |
| `selectAllText` | `string`, default `Selecionar todos` | Texto da ação. |
| `trackByFn` | função | TrackBy. |
| `typeahead` | `Subject<any>` | Busca remota. |
| `minTermLength` | `number`, default `1` | Tamanho mínimo. |
| `typeToSearchText` | `string` | Texto de instrução. |
| `loading` | `boolean` | Estado de carregamento. |
| `loadingText` | `string`, default `Carregando...` | Texto loading. |
| `virtualScroll` | `boolean`, default `false` | Virtualização. |
| `labelForId` | `string | null` gerado | Id do label. |
| `searchFn` | `(term, item) => boolean` | Busca customizada. |
| `tooltipsTrigger` | `string`, default `hover` | Trigger de tooltip. |
| `keyDownFn` | `(e: KeyboardEvent) => boolean` | Hook de teclado. |

Outputs:

- `scrollChange: { start: number; end: number }`
- `scrollToEnd: void`
- `selectChange: any`
- `dropdownClose: void`

Templates:

- `[br-tpl-select-option]`
- `[br-tpl-select-header]`
- `[br-tpl-select-label]`
- `[br-tpl-select-multi-label]`

Exemplo single com objetos:

```html
<br-select
  label="Unidade"
  formControlName="unidade"
  [values]="unidades"
  itemLabel="nome"
  itemValue="id"
  placeholder="Selecione">
</br-select>
```

Exemplo multiple:

```html
<br-select
  label="Perfis"
  formControlName="perfis"
  [values]="perfis"
  itemLabel="nome"
  itemValue="id"
  [multiple]="true"
  [showSelectAll]="true"
  [maxSelectedItems]="5">
</br-select>
```

Exemplo com opção customizada:

```html
<br-select label="Servidor" formControlName="servidor" [values]="servidores" itemLabel="nome">
  <ng-template br-tpl-select-option let-item>
    <strong>{{ item.nome }}</strong>
    <small>{{ item.matricula }}</small>
  </ng-template>
</br-select>
```

## br-multiselect

Status: `@deprecated use br-select`.

- Seletor: `br-multiselect`
- Import: `GovBrMultiselectModule`
- Inputs: `infoLabel`, `selected`, `disabled`, `list`, `filter`, `searchService`, `name`, `label`, `form`, `minTermLength`, `maxSelectedItems`, `formControlName`, `labelForId`, `options`, `placeholder`.
- Output: `change`.

Use apenas para compatibilidade com código legado. Para código novo, use `br-select` com `[multiple]="true"`.

## br-typeahead

Status: `@deprecated use br-select com typeahead`.

- Seletor: `br-typeahead`
- Import: `GovBrTypeaheadModule`
- Inputs: `selected`, `disabled`, `list`, `filter`, `searchService`, `name`, `label`, `form`, `options`, `minTermLength`, `formControlName`, `placeholder`, `maxlength`, `maxLength`.
- Output: `change`.

Use apenas para legado. Para código novo, use `br-select` com `typeahead`, `loading`, `minTermLength` e `typeToSearchText`.

## SearchService

`br-multiselect` e `br-typeahead` usam a interface `SearchService`; para `br-select`, prefira a API do próprio `ng-select` exposta por inputs do componente.

## Receita: `br-select` com busca remota

Use `typeahead` com `Subject` quando as opções vêm de backend. Controle `loading` e atualize `values` com o retorno da busca.

`busca-servidor.component.ts`

```ts
import { Component, OnDestroy } from '@angular/core';
import { ReactiveFormsModule, FormControl, FormGroup } from '@angular/forms';
import { GovBrSelectModule } from '@serpro/ngx-dsgovbr';
import { Subject, Subscription, debounceTime, distinctUntilChanged, switchMap, of } from 'rxjs';

interface Servidor {
  id: number;
  nome: string;
  matricula: string;
}

@Component({
  standalone: true,
  imports: [ReactiveFormsModule, GovBrSelectModule],
  templateUrl: './busca-servidor.component.html',
})
export class BuscaServidorComponent implements OnDestroy {
  form = new FormGroup({
    servidorId: new FormControl<number | null>(null),
  });

  buscaServidor$ = new Subject<string>();
  servidores: Servidor[] = [];
  carregando = false;

  private sub: Subscription = this.buscaServidor$
    .pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(term => {
        this.carregando = true;
        return this.buscarServidores(term);
      }),
    )
    .subscribe(resultado => {
      this.servidores = resultado;
      this.carregando = false;
    });

  buscarServidores(term: string) {
    return of([
      { id: 1, nome: `Servidor ${term}`, matricula: '1234567' },
    ]);
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }
}
```

`busca-servidor.component.html`

```html
<form [formGroup]="form">
  <br-select
    label="Servidor"
    formControlName="servidorId"
    [values]="servidores"
    itemLabel="nome"
    itemValue="id"
    [typeahead]="buscaServidor$"
    [loading]="carregando"
    [minTermLength]="3"
    typeToSearchText="Digite pelo menos 3 caracteres"
    loadingText="Buscando servidores...">
    <ng-template br-tpl-select-option let-item>
      <strong>{{ item.nome }}</strong>
      <small>{{ item.matricula }}</small>
    </ng-template>
  </br-select>
</form>
```
