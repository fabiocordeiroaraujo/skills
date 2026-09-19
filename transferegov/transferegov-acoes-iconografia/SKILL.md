---
name: transferegov-acoes-iconografia
description: "Aplica o catalogo de verbos e icones do Transferegov: pesquisar, visualizar, detalhar, editar, excluir, download, upload, limpar, confirmar, fechar, incluir, ajuda, atualizar, acessar opcoes, imprimir, emitir, filtrar, copiar, enviar, estornar, link externo, ativar, inativar, exportar, assinar, cancelar, personalizar colunas e voltar. Use quando o usuario pedir icones de acao, botoes padrao Transferegov, acoes em tabela, verbos padronizados, Font Awesome, menu de opcoes ou iconografia DSGov/Transferegov."
---

# transferegov acoes e iconografia

## Quando usar

Use esta skill para escolher verbo, icone e posicionamento de acoes em botoes, barras de tabela, menus de opcoes, links externos e operacoes de formulario.

## Guia rapido

Leia `references/verbos-icones-acoes.md` para o catalogo completo de verbos, classes Font Awesome e regras de uso.

Consulte tambem:

- `ngx-dsgovbr-tabelas-listas` para acoes e templates de `br-table`.
- `ngx-dsgovbr-feedback-acoes` para modais, confirmacoes, alertas e loading associados a acoes.

Principios:

- Privilegie os verbos ja definidos pelo catalogo.
- Evite sinonimos para operacoes ja padronizadas.
- Para novo icone/verbo, valide com GT-UX antes de incorporar ao padrao.
- Em tabelas, mantenha ate 4 icones visiveis; acima disso, use menu de opcoes.
- Status/categorias devem virar tags, nao icones coloridos.

## Padroes de decisao

- Use texto em botoes principais de formulario: Salvar, Registrar, Assinar, Confirmar, Cancelar, Voltar.
- Use icones em acoes utilitarias compactas, especialmente em barra de tabela.
- Combine icone com `aria-label`, tooltip ou texto visivel quando o significado nao for obvio.
- Exportacoes devem ficar agrupadas em Acessar Opcoes quando forem opcoes do resultado.
- Para acoes destrutivas como Excluir, use confirmacao quando houver risco de perda de dados.

## Receita

Acoes compactas de linha:

```html
<button class="br-button circle small" type="button" aria-label="Visualizar">
  <i class="fas fa-eye" aria-hidden="true"></i>
</button>

<button class="br-button circle small" type="button" aria-label="Editar">
  <i class="fas fa-edit" aria-hidden="true"></i>
</button>

<button class="br-button circle small" type="button" aria-label="Excluir">
  <i class="fas fa-trash-alt" aria-hidden="true"></i>
</button>
```

Exportacao agrupada:

```html
<button class="br-button circle small" type="button" aria-label="Acessar opcoes">
  <i class="fas fa-ellipsis-v" aria-hidden="true"></i>
</button>
```

Dentro do menu, use `fa-file-csv`, `fa-file-pdf` e `fa-file-excel` para as opcoes de exportacao.

## Cuidados

- Nao crie sinonimos como "consultar" quando o padrao pede "Pesquisar" ou "Visualizar/Detalhar".
- Nao use icone colorido para situacao; use tag compacta.
- Nao deixe botoes icon-only sem nome acessivel.
- Nao assuma que toda tabela precisa de personalizacao de colunas.
- Valide a classe de Cancelar do guia antes de implementar, pois o documento registra `far a-times-circle`.

## Validacao

- O verbo existe no catalogo ou tem justificativa de dominio.
- A classe Font Awesome foi conferida.
- A acao tem nome acessivel.
- Acoes destrutivas pedem confirmacao quando necessario.
- Acoes de tabela respeitam limite visual e agrupamento.
- Detalhes tecnicos de `br-table`, modal e confirmation foram conferidos nas skills `ngx-dsgovbr-*`.
