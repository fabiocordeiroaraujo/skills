# Tags

## Quando usar tag

Tag e um sinalizador para indicar status, quantidade ou informacao precisa e direta.

Use tags para:

- informar;
- rotular;
- chamar atencao;
- categorizar itens por palavras-chave, icones ou cores.

## Padrao Transferegov

Em listagens ou tabelas, use tags para diferenciar dados e facilitar compreensao.

Exemplos:

- ativo/inativo;
- pendente/aceito;
- repassador/recebedor;
- aguardando/nao iniciado/em andamento/encerrado.

Regra importante: em vez de icones coloridos, use tags.

## Densidade em tabela

Em listagens e tabelas, use tag com alta densidade, ou seja, compacta.

Exemplo:

```html
<span class="br-tag small success" aria-describedby="situacao-1">
  <span id="situacao-1">Em andamento</span>
</span>
```

## Decisao de cor

Use cores semanticas do DSGov quando elas estiverem previstas no componente ou no projeto.

Evite:

- criar paleta propria por modulo;
- usar cor como unica forma de transmitir status;
- trocar tag por icone colorido.

## Checklist

- Status/categoria relevante aparece como tag.
- A tag em tabela usa densidade alta/compacta.
- Texto da tag e curto e direto.
- Cor nao e a unica informacao.
- Icone colorido nao substitui tag.
