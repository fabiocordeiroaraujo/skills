# Agrupamentos, botoes e ajudas

## Agrupamento por fieldset e legend

Use `fieldset` com `legend` na maioria dos casos.

Vantagens:

- agrupa informacoes comuns;
- deixa o formulario limpo;
- tem pouco apelo visual;
- melhora leitura sem criar superficies pesadas.

Pode ser combinado com collapse quando o conteudo for extenso e o padrao DSGov de collapse fizer sentido.

## Agrupamento por cor

Use cor quando for necessario agrupar e tambem destacar um conjunto de dados.

Padrao:

- cor: `#f8f8f8`;
- variavel CSS: `--color-secondary-02`;
- padding alvo: 32px;
- classes responsivas: `p-sm-2 p-md-4 p-lg-5`.

Evite usar cor para todos os grupos. Se tudo esta destacado, nada esta destacado.

## Botoes de formulario

Operacoes principais ficam abaixo e a direita do formulario.

Exemplos de operacoes principais:

- Salvar.
- Cancelar.
- Encaminhar.
- Executar.
- Concluir.

Enfases:

- Terciaria: voltar, cancelar, limpar e acoes que retroagem ou tem menor importancia.
- Secundaria: continuidade que nao e a funcao principal ou precisa de menos atencao.
- Primaria: continuidade principal, como salvar, executar e concluir.

O guia referencia `br-button`, mas valide a API Angular na versao instalada. Se nao houver componente Angular confirmado, use o padrao CSS DSGov em botao nativo:

```html
<button class="br-button tertiary" type="button">Cancelar</button>
<button class="br-button primary" type="submit">Salvar</button>
```

## Area sticky de botoes

Em formularios longos, a area de botoes deve permanecer visivel no rodape da pagina.

Comportamento esperado:

- o conteudo rola por baixo da area de botoes;
- botao extra de voltar ao topo pode aparecer;
- esse botao nao deve sobrepor os botoes principais;
- ele deve ficar mais a direita.

## Navegacao apos acao

Depois de uma acao:

- permaneca na mesma pagina quando o usuario costuma continuar operando no mesmo registro;
- volte para a listagem quando a acao normalmente conclui o trabalho.

## Ajuda de campo

Use ajuda quando houver informacao extra ou regra de negocio que reduza duvida do usuario.

Padrao:

- icone de ajuda: `fa-question`;
- texto curto: tooltip;
- texto longo: modal;
- para ajuda longa, tooltip do icone: "Clique para ver informacoes de ajuda do campo".

Evite tooltip com icone de exclamacao para informacoes extras, salvo excecao validada.

## Checklist

- Fieldset/legend foi usado para grupos comuns.
- Fundo so aparece onde ha destaque real.
- Botoes finais estao abaixo e a direita.
- Enfases dos botoes correspondem ao tipo de acao.
- Area sticky nao sobrepoe o conteudo nem o voltar ao topo.
- Ajuda usa interrogacao, tooltip curto ou modal longo.
