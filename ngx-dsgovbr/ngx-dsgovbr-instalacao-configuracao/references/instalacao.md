# Instalacao e compatibilidade

## Pacote publicado

Pacote publicado da biblioteca:

```json
"name": "@serpro/ngx-dsgovbr"
```

## Instalar em aplicacao consumidora

Para projetos consumidores, trate a versao instalada como fonte de verdade. Quando o projeto declarar `"@serpro/ngx-dsgovbr": "19.7.19"`, instale essa versao pelo registry configurado e confira `peerDependencies` em `node_modules/@serpro/ngx-dsgovbr/package.json` depois da instalação. Se precisar consultar antes de instalar, use o registry interno/Nexus do projeto.

Exemplo base:

```bash
npm install \
  @serpro/ngx-dsgovbr@19.7.19 \
  @govbr-ds/core@3 \
  @fortawesome/fontawesome-free@6 \
  bootstrap@5 \
  jquery@3 \
  moment@2
```

Depois instale os peers opcionais conforme os recursos usados e o major exigido pelo pacote instalado. Exemplos comuns:

```bash
npm install \
  @angular/cdk@<major-angular-compativel> \
  @ng-select/ng-select@<major-angular-compativel> \
  ngx-bootstrap@<major-angular-compativel> \
  @siemens/ngx-datatable@<major-compativel>
```

Adicione dependências opcionais conforme o recurso:

- `file-saver`: exportações/arquivos.
- `js-base64`: utilidades antigas.
- `jspdf` e `jspdf-autotable`: exportação PDF da tabela.
- `xlsx`: exportação XLS.
- `xml-js`: exportação XML.
- `jwt-decode`: `TokenService`.
- `angular-shepherd`: `br-onboarding`.
- `stream`: compatibilidade exigida pelo pacote quando indicada pelos peers.

Confirme a lista real de dependencias opcionais no `package.json` do pacote instalado.

## Registry/Nexus

Configure os escopos abaixo quando a organizacao exigir o registry interno:

```bash
npm config set @govbr:registry=https://nexus.aic.serpro.gov.br/repository/npm-group --location=project
npm config set @serpro:registry=https://nexus.aic.serpro.gov.br/repository/npm-group --location=project
```

Use somente quando a organização exigir o registry interno.

## Migracoes e nomes antigos

- Remova `@govbr/dsgov` se a aplicação usava a versão antiga do Design System.
- Para versões acima de 18.4, use `@siemens/ngx-datatable` em vez de referências antigas de `@swimlane/ngx-datatable`.
- Em atualizações major, alinhe Angular, Angular CDK, `@ng-select/ng-select`, `ngx-bootstrap`, `angular-shepherd`, `ngx-markdown` e `@siemens/ngx-datatable` ao major compatível.

## Locale pt-BR

Configure locale quando houver datas, moeda, pipes locais ou formatação textual:

```ts
import { ApplicationConfig, LOCALE_ID } from '@angular/core';
import { registerLocaleData } from '@angular/common';
import localePt from '@angular/common/locales/pt';

registerLocaleData(localePt);

export const appConfig: ApplicationConfig = {
  providers: [{ provide: LOCALE_ID, useValue: 'pt' }],
};
```

## Fonte Rawline

Opção por CDN no `index.html`:

```html
<link
  rel="stylesheet"
  href="https://cdngovbr-ds.estaleiro.serpro.gov.br/design-system/fonts/rawline/css/rawline.css" />
```

Opção recomendada para build controlada: baixar assets Rawline, colocar em `src/assets/rawline` e importar em `src/styles.css`:

```css
@import url('assets/rawline/css/rawline.css');
```

## Receita completa: aplicação consumidora standalone

Depois de instalar o pacote e peers necessários, configure locale e importe os módulos usados pelo componente.

```ts
// app.config.ts
import { ApplicationConfig, LOCALE_ID } from '@angular/core';
import { registerLocaleData } from '@angular/common';
import { provideAnimations } from '@angular/platform-browser/animations';
import { provideRouter } from '@angular/router';
import localePt from '@angular/common/locales/pt';

registerLocaleData(localePt);

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter([]),
    provideAnimations(),
    { provide: LOCALE_ID, useValue: 'pt' },
  ],
};
```

`exemplo-govbr.component.ts`

```ts
import { Component } from '@angular/core';
import { ReactiveFormsModule, FormControl, FormGroup } from '@angular/forms';
import { BrTableColumn, GovBrInputModule, GovBrSelectModule, GovBrTableModule } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [ReactiveFormsModule, GovBrInputModule, GovBrSelectModule, GovBrTableModule],
  templateUrl: './exemplo-govbr.component.html',
})
export class ExemploGovbrComponent {
  form = new FormGroup({
    nome: new FormControl(''),
    situacao: new FormControl('Ativo'),
  });

  situacoes = ['Ativo', 'Inativo'];
  rows = [{ nome: 'Ana', situacao: 'Ativo' }];
  columns: BrTableColumn[] = [
    { prop: 'nome', name: 'Nome', filterable: true },
    { prop: 'situacao', name: 'Situação', filterable: true },
  ];
}
```

`exemplo-govbr.component.html`

```html
<form [formGroup]="form">
  <br-input label="Nome" formControlName="nome"></br-input>
  <br-select label="Situação" formControlName="situacao" [values]="situacoes"></br-select>
</form>

<br-table title="Registros" [data]="rows" [columns]="columns"></br-table>
```
