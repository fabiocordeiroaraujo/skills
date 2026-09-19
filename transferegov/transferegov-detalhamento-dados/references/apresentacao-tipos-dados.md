# Apresentacao por tipo de dado

## UF

Quando trabalhar com UF, apresente uma listagem somente com as siglas.

Exemplos:

- `PE`
- `SP`
- `DF`

Evite mostrar nome completo junto da sigla quando o padrao da tela pede campo UF compacto.

## Numeros

Numeros devem ser apresentados formatados:

- ponto como separador de milhar;
- virgula como separador decimal.

Exemplos:

- `1.000`
- `1.250,75`
- `10.000.000,00`

Em tabelas:

- alinhe campos numericos a direita;
- aplique a mesma formatacao em todos os registros da coluna;
- alinhe o titulo da coluna como o conteudo.

## Valores monetarios

Sempre apresente indicacao de moeda quando o dado for monetario.

Onde indicar:

- no rotulo do campo;
- no rotulo da coluna, quando for tabela.

Exemplos de rotulos:

- `Valor global (R$)`
- `Valor repassado (R$)`
- `Saldo disponivel (R$)`

## Implementacao

Use pipes Angular, `Intl.NumberFormat`, pipes de `@serpro/ngx-dsgovbr` ou formatacao no backend conforme o padrao do projeto.

Antes de escolher, confira:

- `ngx-dsgovbr-diretivas-pipes-servicos` para pipes disponiveis;
- `ngx-dsgovbr-instalacao-configuracao` para locale `pt-BR`;
- `ngx-dsgovbr-tabelas-listas` para templates/alinhamento de coluna.

## Checklist

- UF aparece como sigla.
- Numeros usam formato brasileiro.
- Colunas numericas estao alinhadas a direita.
- Valores monetarios indicam moeda no rotulo.
- Locale e pipes foram configurados quando necessario.
