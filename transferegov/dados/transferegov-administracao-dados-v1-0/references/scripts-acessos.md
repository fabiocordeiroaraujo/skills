# Scripts SQL, usuários e permissões

Fonte: `MANUAL_PADRÕES_NORMAS_ADMINISTRAÇÃO_DADOS.md`, versão 1.0, seções 3.3, 4 e 5. Para geração de DDL, leia também [nomenclatura-objetos.md](nomenclatura-objetos.md) e [modelagem-atributos.md](modelagem-atributos.md).

## Nome de scripts de definição de dados (seção 3.3.1)

Scripts de criação ou alteração de objetos devem usar:

```text
<mn>_<aaaammdd>_SS<número SS>_<nn>_<descrição>_<iniciais>.sql
```

| Campo | Significado |
| --- | --- |
| `mn` | Mnemônico do sistema. |
| `aaaammdd` | Data em que o script foi gerado. |
| `número SS` | Número da SS da demanda. |
| `nn` | Sequencial do script segundo a ordem de execução. |
| `descrição` | Descrição sucinta do objetivo do script. |
| `iniciais` | Iniciais do nome do atendente, em letras maiúsculas. |

Exemplo literal do manual: `CINFRA_20200103_SS1234567_01_script_exemplo_CRSL.sql`. A regra geral de minúsculas refere-se aos nomes de objetos do banco; o exemplo de arquivo usa mnemônico e iniciais em maiúsculas. Verifique no projeto qual caixa é empregada nos arquivos, mantendo o molde e a ordem dos componentes.

## Cabeçalho obrigatório (seção 3.3.2)

Todo arquivo `.sql` deve possuir este cabeçalho, preenchido com dados reais:

```sql
/*
* ======================= DADOS DO SCRIPT ====================================
* AUTOR: <NOME>
* OBJETIVO: <breve descricao do objetivo da alteracao>
* PRE-REQUISITOS: <arquivos a serem aplicados em ordem>
*/
```

Use `PRE-REQUISITOS` para indicar os arquivos que precisam ser aplicados antes e ordene scripts pelo sequencial `nn`. Se SS, autor, data, iniciais ou pré-requisitos não forem conhecidos, obtenha-os dos artefatos da demanda ou do usuário; não preencha valores fictícios como se fossem finais.

## Usuários/roles por ambiente (seção 4.1)

`mn` é o mnemônico do sistema; `n` é o sequencial que identifica a numeração daquele ambiente de banco de dados. Nomes de usuários de aplicação e proprietários seguem:

| Ambiente | Usuário da aplicação | Usuário proprietário |
| --- | --- | --- |
| Desenvolvimento | `usr_<mn><n>_d` | `owner_<mn><n>_d` |
| Homologação | `usr_<mn><n>_h` | `owner_<mn><n>_h` |
| Produção | `usr_<mn><n>_p` | `owner_<mn><n>_p` |

## Privilégios (seção 4.2)

- Conceda a usuários da aplicação, nas tabelas de negócio, privilégios de consulta, exclusão, atualização, inserção e referências (`SELECT`, `DELETE`, `UPDATE`, `INSERT`, `REFERENCES`); conceda `USAGE` nas sequências quando aplicável.
- Nas tabelas de auditoria, conceda a usuários da aplicação apenas consulta e inserção (`SELECT`, `INSERT`), além de `USAGE` nas sequências quando aplicável.
- Conceda todos os privilégios aos usuários proprietários.
- As concessões devem considerar os objetos relacionados e as necessidades do usuário da base. O manual não define privilégios de schema, funções ou outras classes de objeto; consulte a política efetiva do projeto para esses casos.

## Conclusão do script (seções 5.2–5.5)

Gere scripts de alteração de estrutura e dados conforme os padrões de objeto e nome de arquivo. Crie índice para cada FK, incluindo suas colunas, e outros índices quando o desempenho exigir. Aplique no banco adequado, corrija no script os erros encontrados e versione após a correção conforme o padrão de versionamento do projeto. Esse padrão de versionamento é citado no manual, mas não está definido nele.
