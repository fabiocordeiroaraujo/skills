# Listas, accordion, card e carousel

## br-list

- Seletor: `br-list`
- Import: `GovBrListModule`
- Inputs: `title`, `items`, `selected`, `itemLabel`.
- Output/model: `selectedChange`.
- Template customizado: `[br-tpl-list-item]`.

Exemplo:

```html
<br-list
  title="Unidades"
  [items]="unidades"
  itemLabel="nome"
  [(selected)]="unidadeSelecionada">
</br-list>
```

Template:

```html
<br-list [items]="servidores" [(selected)]="selecionado">
  <ng-template br-tpl-list-item let-item>
    <strong>{{ item.nome }}</strong>
    <small>{{ item.matricula }}</small>
  </ng-template>
</br-list>
```

## br-collapsible-list

- Seletor: `br-collapsible-list`
- Import: `GovBrCollapsibleListModule`
- Inputs: `items: BrCollapsibleItem[]`, `headerImageSize` default `1px`.
- Output: `itemClick: BrCollapsibleItem`.

`BrCollapsibleItem`:

- `id`
- `title`
- `content`
- `cssClass`
- `expanded`
- `disabled`
- `children`
- `data`
- `link`

Exemplo:

```ts
items = [
  { title: 'Dados cadastrais', content: 'Nome, CPF e contato.' },
  { title: 'Documentos', content: 'Anexos enviados.', expanded: true },
];
```

```html
<br-collapsible-list [items]="items" (itemClick)="abrir($event)"></br-collapsible-list>
```

## br-accordion

- Seletor: `br-accordion`
- Import: `GovBrAccordionModule`
- Input obrigatório: `data: Accordion`.
- Output: `fieldExpand: AccordionItem`.

`Accordion`:

- `items: AccordionItem[]`
- `isSingle = true`
- `type: 'positive' | 'negative'`
- `faIcon = 'angle'` deprecated.

`AccordionItem`:

- `title`
- `content`
- `templateRef`
- `expanded`
- `expandeable`
- `data`
- `headerIcon`

Exemplo:

```ts
accordion = {
  isSingle: true,
  type: 'positive',
  items: [
    { title: 'Quem pode solicitar?', content: 'Usuários autenticados.' },
    { title: 'Prazo', content: 'Até cinco dias úteis.' },
  ],
};
```

```html
<br-accordion [data]="accordion" (fieldExpand)="onExpand($event)"></br-accordion>
```

## br-card

- Seletor: `br-card`
- Import: `GovBrCardModule`
- Inputs: `avatarImage`, `avatarTitle`, `title`, `subTitle`, `cardClass`.
- Output: `cardClick: CardData`.

`cardClass` aceita `CardType` com default `amplo` no componente.

`CardData`:

- `icone`
- `image`
- `titulo`
- `descricao`
- `botao`
- `numero`
- `rotuloNumero`

Exemplo:

```html
<br-card
  title="Solicitações"
  subTitle="Abertas"
  cardClass="amplo"
  (cardClick)="abrirResumo($event)">
  <p>12 solicitações pendentes.</p>
</br-card>
```

## br-carousel

- Seletor: `br-carousel`
- Import: `GovBrCarouselModule`
- Input: `carousel: CarouselComponent`.

O componente encapsula `ngx-bootstrap/carousel`. Valide a estrutura completa no pacote instalado quando precisar customizar comportamento alem dos inputs listados.

## br-picklist

- Seletor: `br-picklist`
- Import: `GovBrPickListModule`.
- Pode ser usado em cenarios template-driven e reactive forms; valide a API no pacote instalado antes de gerar codigo completo.
- A API não estava na lista principal do prompt, mas é exportada publicamente pelo entrypoint.

## Cuidados

- `br-list` seleciona itens planos; `br-collapsible-list` é para conteúdo expansível e pode ter filhos de primeiro nível.
- `br-accordion` recebe um objeto `Accordion`, não uma lista solta.
- `br-card` não substitui `br-table`; use para chamadas/resumos ou conteúdo destacado.
- Valide os templates customizados no pacote instalado quando esses componentes aceitarem conteudo projetado.
