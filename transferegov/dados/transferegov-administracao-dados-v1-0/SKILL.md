---
name: transferegov-administracao-dados-v1-0
description: "Aplica a versão 1.0 do Manual de Padrões e Normas para Administração de Dados do Transferegov em modelagem relacional, nomenclatura de schemas, tabelas, colunas, constraints, índices, sequências, views, funções e triggers, auditoria, concorrência, scripts SQL, usuários e permissões. Use ao criar, alterar ou revisar estruturas de banco e migrações de projetos Transferegov."
---

# Administração de dados do Transferegov — manual v1.0

Use esta skill para projetar, implementar ou revisar objetos de banco de dados e scripts SQL conforme `MANUAL_PADRÕES_NORMAS_ADMINISTRAÇÃO_DADOS.md` (versão 1.0, janeiro de 2020). As referências abaixo extraem as regras do manual e acompanham esta skill de forma independente do arquivo de origem.

## Referências por tarefa

- Para nomes de schemas, tabelas, views, materialized views, funções, triggers, índices, sequências e constraints, leia [nomenclatura-objetos.md](references/nomenclatura-objetos.md).
- Para modelagem, colunas, siglas, comentários, auditoria, concorrência e índices de chaves estrangeiras, leia [modelagem-atributos.md](references/modelagem-atributos.md).
- Para arquivos `.sql`, cabeçalhos, sequência de execução, usuários, roles e privilégios, leia [scripts-acessos.md](references/scripts-acessos.md).
- Ao gerar ou revisar um script que cria ou altera tabelas, leia as três referências.

## Aplicação

1. Identifique no projeto o mnemônico já adotado, os schemas, a estrutura existente, os scripts anteriores, o ambiente e os dados da demanda. `cinfra` é apenas o exemplo do manual; não é um mnemônico presumido para todo o Transferegov.
2. Modele entidades, colunas e relacionamentos de acordo com a necessidade de negócio e as regras das referências. Considere compatibilidade com o modelo anterior e a exceção para objetos legados.
3. Defina nomes, comentários, auditoria, controle de concorrência, constraints, índices, usuários e permissões aplicáveis antes de concluir o SQL.
4. Em scripts, mantenha o padrão de arquivo, cabeçalho e ordem de execução. Confira o SQL contra o esquema real antes de aplicá-lo; aplique, corrija e versione apenas quando a tarefa e o ambiente autorizarem essas ações.
5. Verifique cada requisito pertinente das referências e informe ao usuário qualquer dado ausente ou divergência do próprio manual que afete a entrega. Não invente número de SS, mnemônico, iniciais do atendente, política de versionamento ou estrutura preexistente.

O manual define nomes e requisitos de estrutura, mas não fornece o corpo das funções genéricas, a implementação dos gatilhos nem o padrão externo de versionamento citado na seção 5.5. Nesses pontos, consulte o projeto ou explicite o que falta para produzir uma alteração executável.
