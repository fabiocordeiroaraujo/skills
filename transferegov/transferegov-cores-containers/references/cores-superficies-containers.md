# Cores, superficies e containers

## Principio

O DSGov define familias de cores para pontos especificos da interface. No Transferegov, a escolha de cores deve ser coerente com a funcionalidade da tela e congruente em todo o sistema.

## Regra Transferegov

Use as cores padroes dos componentes.

Mudancas de cor sao permitidas principalmente em:

- botoes circulares com enfase terciaria;
- icones.

Evite customizacao de cor fora desses casos sem validacao de UX.

## Superficie de agrupamento

Superficie de agrupamento e o recurso de cor usado para destacar um conjunto de dados em formulario.

Padrao permitido:

- cor: `#f8f8f8`;
- variavel CSS: `--color-secondary-02`.

Nao use outra cor para superficies de agrupamento.

## Espacamento

Quando usar cor de fundo no agrupamento, aplique padding para conforto visual.

Padroes:

- padding alvo: 32px;
- classe citada: `p5`;
- classes responsivas recomendadas: `p-sm-2 p-md-4 p-lg-5`.

## Quando usar fundo

Use fundo quando o grupo precisa ser destacado alem de organizado.

Nao use fundo quando:

- `fieldset` e `legend` ja resolvem a leitura;
- a area nao tem importancia maior;
- a cor seria apenas decoracao.

## Checklist

- Cores padrao dos componentes foram mantidas.
- Customizacao de cor esta limitada a icones ou botoes circulares terciarios.
- Superficie usa `#f8f8f8`/`--color-secondary-02`.
- Container com fundo tem padding responsivo.
- A cor transmite hierarquia real, nao decoracao.
