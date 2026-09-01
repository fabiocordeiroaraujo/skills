# Padrao UX da app Invoice

## Mapa local

| Responsabilidade | Arquivo |
| --- | --- |
| Feature module | `frontend/src/app/views/invoice/invoice.module.ts` |
| Rotas lista/novo/edicao | `frontend/src/app/views/invoice/invoice-routing.module.ts` |
| Lista | `frontend/src/app/views/invoice/invoice-list/` |
| Edicao, visualizacao e print | `frontend/src/app/views/invoice/invoice-detail/` |
| Estilos de resumo e impressao | `frontend/src/assets/styles/app/globals/views/_invoice.scss` |
| API demonstrativa | `frontend/src/app/shared/services/data-layer.service.ts` |
| Dados em memoria | `frontend/src/app/shared/inmemory-db/invoices.ts` |

## Dependencias atuais

`InvoiceModule` importa `CommonModule`, `FormsModule`, `ReactiveFormsModule`, `SharedComponentsModule`, `NgbModule` e o routing module. A feature usa:

- Angular Router;
- Reactive Forms e `FormArray`;
- `NgbModal` para confirmacao;
- `ToastrService` para sucesso;
- `btn-loading` para salvar;
- `ngbDatepicker`;
- `window.print()`.

Codigo novo deve importar apenas o necessario e evitar `FormsModule` se toda a feature for reativa.

## Rotas demonstradas

```text
/invoice             lista
/invoice/new         novo documento
/invoice/edit/:id    visualizar/editar
```

Em produto, prefira nomes de dominio estaveis e separe verbos apenas quando ajudam a navegacao. O ID deve ser opaco. Nao coloque nome, documento, valor ou outro dado pessoal/financeiro na URL.

## Lista

`InvoiceListComponent` demonstra:

- breadcrumb e botao de criacao;
- tabela em card sem borda;
- numero, origem, destino, status e acoes;
- status com `text-bg-success`, `text-bg-warning` e `text-bg-danger`;
- navegacao para detalhe;
- modal de exclusao seguido de Toastr e reload.

Ao adaptar:

- envolva a tabela em `.table-responsive`;
- adicione loading, vazio, erro, total, filtro e paginacao conforme volume;
- use uma union/enumeracao de status e um mapeamento central de rotulo/classe;
- derive acoes de estado e permissao;
- diferencie visualizar, editar, cancelar, estornar e excluir;
- nao use `ngbAutofocus` na acao destrutiva.

## Detalhe e modos

O componente usa `viewMode: 'edit' | 'print'`. Para uma implementacao robusta, modele ao menos:

```ts
type DocumentMode = 'create' | 'view' | 'edit' | 'print';
```

Estados assincronos ficam separados do modo:

```ts
type SaveState = 'idle' | 'saving' | 'saved' | 'error' | 'conflict';
```

Nao use “Cancel” para apenas alternar para print se isso puder descartar mudancas. Compare `dirty`, confirme descarte e restaure o snapshot persistido.

## Formulario dinamico

O demo possui:

- `orderNumber`, `orderStatus`, `currency`, `vat`, `orderDate`;
- grupos `billFrom` e `billTo`;
- `items` como `FormArray` de `name`, `unit`, `unitPrice`;
- subtotal recalculado em `valueChanges`;
- adicionar/remover linha.

Padrao tipado sugerido:

```ts
interface LineForm {
  id: FormControl<string | null>;
  description: FormControl<string>;
  quantity: FormControl<number>;
  unitAmount: FormControl<string>;
}

interface FinancialDocumentForm {
  reference: FormControl<string>;
  issueDate: FormControl<string | null>;
  lines: FormArray<FormGroup<LineForm>>;
}
```

A representacao de dinheiro (`string`, minor units ou objeto) deve seguir o contrato. Nao escolha implicitamente com base no demo.

Evite reconstruir o formulario e subscriptions manualmente sem teardown. Prefira streams derivados, signals ou ciclo de vida controlado compativel com o entorno.

## Resumo financeiro

`_invoice.scss` define `.invoice-summary` com `220px` e `.invoice-summary-input` com `320px`. O bloco alinha rotulos e valores com flex.

Reutilize a composicao, mas adapte em mobile e para textos longos/moedas. Mostre explicitamente:

- subtotal;
- descontos/acrescimos individualizados;
- impostos/taxas quando aplicaveis;
- total;
- valor pago e saldo quando o documento exigir;
- referencia da memoria de calculo/versao.

Nao use `.toFixed(2)` como regra universal. Formate com pipes/Intl e use valores oficiais retornados.

## Impressao

O SCSS atual oculta todo o `body` e torna `#print-area` visivel em `@media print`. Ao reutilizar:

- mantenha `#print-area` unico;
- remova botoes, controles e chrome;
- defina quebra de pagina de tabelas longas;
- repita cabecalho quando necessario;
- garanta contraste em preto e branco;
- inclua identificacao/versao verificavel do documento;
- teste preview real do browser.

Documento oficial/PDF gerado no servidor pode ser necessario para integridade. A impressao do browser nao substitui assinatura, numeracao, armazenamento ou emissao oficial.

## Antipadroes do demo

- `any[]`, `UntypedFormGroup` e `UntypedFormArray`.
- `DataLayerService` generico com endpoints mockados.
- `Utils.genId()` no browser.
- calculo monetario com `number` e `.toFixed(2)`.
- falta de tratamento de erro e finalizacao de `saving` em erro.
- IDs HTML duplicados/vazios.
- classes Bootstrap antigas (`float-right`, `text-right`, `pl-0`).
- botao host com `(click)` em `btn-loading`.
- delete generico onde o dominio pode exigir cancelamento/estorno.

## Capacidades Haggyo relacionadas

Use Invoice como composicao visual para `APP-004`, financeiro/cobranca, recibos e declaracao anual. Leia as capacidades `FIN`/`BIL` e o MVP aplicavel antes de definir campos e acoes. O template nao define contrato de negocio.

