---
name: ux-app-invoice
description: "Reutilizar, adaptar, implementar ou revisar o padrao UX da app Invoice no frontend Angular Haggyo: listagem de documentos financeiros, status, criacao/edicao, Reactive Form com FormArray de itens, calculo e resumo de totais, visualizacao, impressao e exclusao confirmada. Use sempre que a tarefa envolver invoice, fatura, cobranca, recibo, orcamento, nota, documento financeiro, itens cobrados, subtotal, desconto, juros, imposto, segunda via ou tela imprimivel em frontend/."
compatibility: Projeto Haggyo em frontend/ com Angular 19, NgModule, Reactive Forms, ng-bootstrap, Toastr e estilos UX de invoice.
---

# UX App Invoice

## Objetivo

Usar a app Invoice como padrao composto para documentos financeiros editaveis e imprimiveis, preservando listagem, formulario dinamico, resumo e modo de impressao. Adapte o modelo ao dominio Haggyo; a demonstracao nao e autoridade para cobranca, tributacao, conciliacao ou documento oficial.

Use tambem `ux-visual-language`, `ux-layouts-navigation`, `ux-ui-components` e `ux-angular-feature` quando a tarefa abranger suas responsabilidades.

## Fluxo

1. Leia `references/padrao-invoice.md` e inspecione `frontend/src/app/views/invoice/`.
2. Identifique o documento real: cobranca, recibo, declaracao, plano, orcamento ou outro.
3. Modele lista, detalhe, itens, valores e status com tipos de dominio; nao reutilize `any` nem nomes `order*` sem correspondencia.
4. Separe data-access, modelo de tela e calculo apresentado. O backend permanece autoridade financeira.
5. Implemente lista com loading, vazio, erro, filtros/paginacao quando necessarios e acoes permitidas.
6. Implemente detalhe com Reactive Form tipado e `FormArray` quando houver linhas dinamicas.
7. Diferencie claramente editar, visualizar e imprimir. Nao descarte alteracoes sem confirmacao.
8. Proteja save/delete contra repeticao e trate conflito, validacao e erro da API.
9. Formate moeda, data e numero pelo contexto do tenant/usuario.
10. Verifique impressao, mobile, teclado, foco e build.

## Estrutura reutilizavel

- Lista: breadcrumb, acao primaria, card com tabela, badge de status e acoes.
- Detalhe: card unico com toolbar contextual.
- Edicao: dados gerais, emissor/destinatario, `FormArray` de itens e resumo.
- Visualizacao: cabecalho do documento, partes, tabela de itens e totais.
- Impressao: `#print-area` e regras `@media print` isolando o chrome administrativo.
- Exclusao/cancelamento: modal com objeto, impacto e foco inicial seguro.

## Regras financeiras

- Nao use `number`/ponto flutuante como fonte oficial para valores monetarios. Receba valores canonicos do backend e use representacao definida pelo contrato.
- Nao calcule saldo, multa, juros, imposto ou total oficial apenas no componente. O calculo local serve para previa e deve ser reconciliado com a resposta da API.
- Preserve moeda, escala, arredondamento, memoria de calculo e versao do documento.
- Diferencie excluir rascunho, cancelar documento, estornar pagamento e emitir segunda via; nao converta tudo em `delete`.
- Acoes financeiras usam idempotencia, autorizacao no backend, auditoria e correlacao.
- Nao exponha dados financeiros desnecessarios em URL, log, Toastr ou analytics.

## Formularios e itens

Use Reactive Forms tipado. Cada item deve ter identificador estavel, descricao, quantidade/unidade, valor unitario e campos de ajuste definidos pelo dominio. Defina validadores para limites e sinal.

Use botoes `type="button"` em adicionar/remover linha para nao submeter o formulario. Confirme remocao quando a linha ja estiver persistida ou tiver efeito financeiro.

## Resultado esperado

Entregue a jornada financeira usando o padrao visual Invoice, com contratos tipados, estados completos e valores oficiais vindos do backend. Relate quais partes do demo foram preservadas e quais foram substituidas por regras Haggyo.

## Checklist

- Lista, detalhe e impressao usam o vocabulario UX existente.
- Tipos e nomes representam o documento real.
- `FormArray` e formulario sao tipados.
- Total exibido nao virou autoridade financeira local.
- Save/delete/cancelamento resistem a repeticao.
- Status tem texto e semantica, nao apenas cor.
- Loading, vazio, erro, conflito e acesso negado foram avaliados.
- Impressao nao inclui sidebar/header e preserva legibilidade.
- Moeda, data, fuso e arredondamento vem do contexto/contrato.
- Testes cobrem calculo de apresentacao, itens, estados e acoes criticas.

