# Verbos, icones e acoes

## Regra geral

Use os verbos e icones ja selecionados pelo Transferegov. Evite sinonimos para operacoes existentes. Quando precisar de novo icone, valide com GT-UX antes de incorporar ao catalogo.

## Catalogo

| Acao/verbo | Classe Font Awesome |
| --- | --- |
| Pesquisar | `fa-search` |
| Visualizar/Detalhar | `fa-eye` |
| Editar | `fa-edit` |
| Excluir | `fa-trash-alt` |
| Baixar Arquivo/Download | `fa-download` |
| Subir Arquivo/Upload | `fa-upload` |
| Limpar | `fa-eraser` |
| Confirmar | `fa-check` |
| Fechar | `fa-times` |
| Incluir | `fa-plus` |
| Ajuda | `fa-question` |
| Atualizar | `fa-sync` |
| Acessar Opcoes | `fa-ellipsis-v` |
| Imprimir | `fa-print` |
| Emitir | `fa-file-lines` |
| Filtrar | `fas fa-filter` |
| Copiar | `fa-copy` |
| Enviar | `fa-share` |
| Estornar | `fa-undo-alt` |
| Link externo | `fa-external-link-alt` |
| Ativar/Reativar | `fa-check-circle` |
| Inativar | `fas fa-ban` |
| Exportar CSV | `fa-file-csv fas` |
| Exportar PDF | `fa-file-pdf fas` |
| Exportar XLS | `fa-file-excel fas` |
| Assinar | `fa-file-signature fas` |
| Cancelar | `far a-times-circle` no guia; validar classe real antes de usar |
| Personalizar colunas | `fa-sliders-h` |
| Voltar | `fa-chevron-left` |

## Observacoes de uso

- `Imprimir` representa imprimir documento pela impressora ou atalho equivalente.
- `Emitir` gera arquivos imprimiveis, como PDF de recibo.
- `Filtrar` aparece junto a tabela.
- `Acessar Opcoes` deve agrupar acoes quando houver muitas opcoes na barra de tabela.

## Acoes em tabela

Use a barra de titulo da tabela para acoes utilitarias.

Padroes:

- ate 4 icones visiveis;
- acima disso, agrupe em menu flutuante;
- exportacoes ficam agrupadas em Acessar Opcoes;
- personalizacao de colunas so quando trouxer ganho real.

## Acoes de formulario

Use texto nos botoes principais e mantenha os verbos padronizados:

- Salvar, Registrar, Assinar quando persistem dados.
- Confirmar quando nao persistem dados.
- Cancelar, Voltar ou Limpar para retroacao.

## Acessibilidade

Para botoes so com icone:

- informe `aria-label`;
- use tooltip quando necessario;
- mantenha o icone com `aria-hidden="true"`;
- nao dependa apenas da cor.

## Checklist

- Verbo padrao foi usado.
- Classe de icone foi validada.
- Novo verbo/icone tem aprovacao ou justificativa.
- Acao destrutiva tem confirmacao quando necessario.
- Botao icon-only tem nome acessivel.
