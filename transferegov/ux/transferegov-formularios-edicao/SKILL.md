---
name: transferegov-formularios-edicao
description: "Aplica o padrao visual Transferegov para formularios de inclusao e edicao: titulo obrigatorio, subtitulo excepcional, cabecalho de parceria, fieldset, legend, agrupamento por cor, botoes sticky, salvar/cancelar/encaminhar, ajuda por tooltip/modal, abas, subabas, listas internas, inclusao em tabela e pesquisa interna. Use quando o usuario pedir formulario Transferegov, formulario de edicao, tela de inclusao, botoes padrao Transferegov, ajuda de campo, abas de formulario ou listagem dentro de formulario."
---

# transferegov formularios e edicao

## Quando usar

Use esta skill para criar, revisar ou corrigir formularios Transferegov de inclusao e edicao, especialmente quando houver muitos campos, agrupamentos, botoes de acao, ajuda contextual, abas ou tabelas internas.

## Guia rapido

Leia:

- `references/formularios.md` para estrutura geral, titulo, subtitulo e cabecalho de parceria.
- `references/agrupamentos-botoes-ajudas.md` para fieldset, cor, botoes e ajuda.
- `references/abas-listas-internas.md` para abas, subabas e listagens dentro de formularios.

Consulte tambem:

- `ngx-dsgovbr-formularios` para campos, reactive forms, template-driven forms, validadores, mascaras, mensagens, arquivos e datas.
- `ngx-dsgovbr-layout-navegacao` para tabs, breadcrumbs e estrutura de navegacao.
- `ngx-dsgovbr-tabelas-listas` para listagens internas com `br-table`.
- `ngx-dsgovbr-feedback-acoes` para modal, confirmation, alertas, loading, fieldset e toggle.

Componentes provaveis:

- `br-input`, `br-textarea`, `br-select`, `br-date-picker`, `br-file`, `br-checkbox`, `br-radio`, `br-switch`.
- `br-tab-set`/`br-tab`, `br-second-tab-set`/`br-second-tab`, `br-table`, `br-modal`, `br-confirmation`.

## Padroes de decisao

- Use um unico `h1` por tela; subtitulo so quando acrescentar orientacao real.
- Para formularios de Parceria, avalie o componente de cabecalho da Esteira de Parcerias antes de recriar informacoes.
- Use `fieldset` e `legend` na maioria dos agrupamentos; use fundo `#f8f8f8` apenas quando o grupo precisar de destaque.
- Posicione botoes principais abaixo e a direita; a area de botoes deve permanecer visivel em formularios longos.
- Use terciario para voltar/cancelar/limpar, secundario para continuidade nao principal e primario para continuidade principal.
- Use ajuda com icone `fa-question`: tooltip para texto curto, modal para texto longo.
- Use abas quando a quantidade de informacao prejudicar leitura em uma pagina unica.
- Em formularios complexos, subabas sao aceitas no Transferegov, mesmo sendo um uso que o DSGov recomenda evitar em geral.

## Receita

Formulario com agrupamento, ajuda e botoes:

```ts
import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { GovBrDatePickerModule, GovBrInputModule, GovBrSelectModule } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [ReactiveFormsModule, GovBrInputModule, GovBrSelectModule, GovBrDatePickerModule],
  templateUrl: './editar-parceria.component.html',
})
export class EditarParceriaComponent {
  form = new FormGroup({
    numero: new FormControl('', Validators.required),
    proponente: new FormControl('', Validators.required),
    inicioVigencia: new FormControl('', Validators.required),
  });

  salvar() {}
  cancelar() {}
}
```

```html
<h1>Editar parceria</h1>

<form [formGroup]="form">
  <fieldset>
    <legend>Dados da parceria</legend>

    <br-input label="Numero da parceria" formControlName="numero" required></br-input>
    <br-input label="Proponente" formControlName="proponente" required></br-input>
    <br-date-picker label="Inicio da vigencia" formControlName="inicioVigencia" required></br-date-picker>
  </fieldset>

  <section class="p-sm-2 p-md-4 p-lg-5 mt-4" style="background: var(--color-secondary-02)">
    <fieldset>
      <legend>Dados complementares</legend>
      <p class="mb-2">Use este agrupamento somente quando houver necessidade de destaque visual.</p>
    </fieldset>
  </section>

  <div class="d-flex justify-content-end mt-4">
    <button class="br-button tertiary" type="button" (click)="cancelar()">Cancelar</button>
    <button class="br-button primary ml-2" type="button" (click)="salvar()">Salvar</button>
  </div>
</form>
```

## Cuidados

- Nao use campo `disabled` para modo somente leitura; use detalhamento com labels ou `readonly`.
- Nao use cor de fundo como decoracao recorrente; reserve para grupos que precisam de destaque.
- Nao use tooltip com icone de exclamacao para informacao extra; o padrao usa interrogacao.
- Nao crie subabas por habito; use quando a complexidade do formulario exigir.
- Nao chame de "Confirmar" uma acao que persiste dados; prefira "Salvar", "Registrar" ou verbo de negocio equivalente.

## Validacao

- Titulo unico e subtitulo justificado.
- Campos agrupados por fieldset/legend sempre que fizer sentido.
- Botoes finais estao abaixo, a direita e com enfase correta.
- Ajuda curta/longa escolheu tooltip/modal corretamente.
- Abas ou subabas reduzem complexidade real, nao apenas decoram a tela.
- APIs de campos e validadores foram conferidas em `ngx-dsgovbr-formularios`.
