# Nomenclatura de objetos

Fonte: `MANUAL_PADRÕES_NORMAS_ADMINISTRAÇÃO_DADOS.md`, versão 1.0, seções 3, 3.1 e 3.2.1–3.2.4, Tabelas 1 e 3 e seção 3.2.6. Use também [modelagem-atributos.md](modelagem-atributos.md) para nomes de colunas e regras de FK.

## Convenção básica

- Use letras minúsculas, palavras no singular, sem acentos nem caracteres especiais como `@`, `#`, `$`, `%` e `&`.
- Use componentes alfanuméricos; se o nome tiver mais de uma palavra, separe-as com `_`. Não use preposições, artigos ou conectivos como `o`, `a` e `de`.
- Acrônimos, abreviações e siglas são permitidos e aconselhados, desde que não tornem o significado ambíguo. Se abreviar para caber no limite, preserve a identificação do conteúdo.
- Números podem constar do nome, mas não devem iniciar a denominação ou o complemento denominativo do objeto.
- O nome do objeto deve ter valor semântico. Prefixos ou sufixos classificadores são recomendados e, quando a Tabela 1 define um padrão para a natureza do objeto, siga-o.
- Formas gerais registradas no manual: `<prefixo-mnemônico-sistema>_<nome-objeto>` (`cinfra_proposta`); `<prefixo-tipo-objeto>_<nome-objeto>` (`fn_calcula_dv`); `<nome-objeto>_<sufixo-tipo-objeto>` (`responsavel_legal_seq`).

## Mnemônico e limites

- O mnemônico deve identificar o sistema inequivocamente e ter no máximo **6 caracteres**. Todas as suas tabelas usam o mesmo prefixo; os demais objetos que preveem mnemônico também o usam.
- Nome de schema: no máximo **20 caracteres**.
- Nome de tabela: no máximo **63 caracteres** (limite padrão do PostgreSQL).
- Nome de atributo/coluna: no máximo **50 caracteres**.
- Toda tabela e toda coluna devem receber uma descrição de sua finalidade. Consulte [modelagem-atributos.md](modelagem-atributos.md) para a aplicação.

## Padrões por natureza de objeto (Tabela 1)

Os espaços nos marcadores `<mnemônico sistema>` representam um único componente do nome; os nomes finais usam `_` conforme mostrado nos exemplos.

| Objeto | Padrão do manual | Exemplo do manual | Finalidade |
| --- | --- | --- | --- |
| Function geral | `fn_<mnemônico sistema>_<nome-função>` | `fn_cinfra_calcula_dv` | Funções gerais. |
| Function genérica de auditoria | `fn_generic_audit_trigger` | `fn_generic_audit_trigger()` | Chamada por trigger para registrar auditoria das tabelas. |
| Function genérica de concorrência | `fn_generic_concurrent_trigger` | `fn_generic_concurrent_trigger()` | Chamada por trigger no controle de concorrência de atualizações. |
| Materialized view | `mv_<mnemônico sistema>_<nome-view-materialized>` | `mv_cinfra_situacao_proposta` | Visão materializada de dados. |
| Tabela de negócio | `<mnemônico-sistema>_<tabela-negocio>` | `cinfra_proposta` | Dados de negócio. |
| Tabela temporária | `<mnemônico-sistema>_<tabela-negocio>_tmp` | `cinfra_contrato_tmp` | Dados temporários. |
| Tabela de auditoria | `<mnemônico-sistema>_<tabela-negocio>_audit` | `cinfra_proposta_audit` | Histórico de operações. |
| Trigger de tabela de negócio | `tg_<mnemônico sistema>_<tabela-negocio>` | `tg_cinfra_proposta` | Trigger de negócio. |
| Trigger de auditoria | `tg_audit_<mnemônico sistema>_<tabela-negocio>` | `tg_audit_cinfra_proposta` | Aciona auditoria. |
| Trigger de concorrência | `tg_concurrent_<mnemônico sistema>_<tabela-negocio>` | `tg_concurrent_cinfra_proposta` | Controle de concorrência. |
| View | `vw_<mnemônico sistema>_<nome-view>` | `vw_cinfra_situacao_proposta` | Visão de dados. |
| Index | `idx_<mnemônico sistema>_<tabela-negocio>_<coluna-indice>` | `idx_cinfra_proposta_convenio_fk` | Índice de desempenho. |
| Sequence | `<mnemônico sistema>_<tabela-negocio>_seq` | `cinfra_proposta_seq` | Valores sequenciais de registros. |
| Schema de negócio | `<nome-esquema>` | `cinfra` | Abriga objetos de negócio. |
| Schema de auditoria | `<nome-esquema>_audit` | `cinfra_audit` | Abriga objetos de auditoria, separado do schema de negócio. |

Nomes de tabelas de negócio devem aludir aos dados armazenados, com substantivo significativo: `cinfra_especificacao_projeto_basico`. O mnemônico é obrigatório como prefixo da tabela e agrupa suas tabelas no modelo relacional. A tabela de auditoria tem exatamente o nome da tabela de negócio correspondente seguido de `_audit`, por exemplo `cinfra_especificacao_projeto_basico_audit`.

## Chaves e constraints (seção 3.2.6, Tabela 3)

O manual determina que a coluna de chave estrangeira seja formada a partir do nome da tabela de destino com `_fk`: `<nome-tabela-destino>_fk`. Seu exemplo é `conta_bancaria_fk` para a tabela `cinfra_conta_bancaria`. Confira os nomes reais do projeto antes de aplicar esta formação.

| Constraint | Padrão transcrito do manual | Exemplo transcrito do manual |
| --- | --- | --- |
| Primary Key (`pk`) | `<mnemônico sistema><tabela-negocio>_pk` | `cinfra_situacao_proposta_pk` |
| Foreign Key (`fk`) | `fk_<mnemônico sistema>_<tabela-negocio>_<coluna-estrangeira>` | `fk_cinfra_situacao_proposta_contrato_fk` |
| Unique Key (`uk`) | `uk__<mnemônico sistema>_<tabela-negocio>_<coluna-chave>` | `uk_cinfra_situacao_proposta_nr_sequencial` |
| Check Constraint (`ck`) | `ck_<mnemônico sistema>_<tabela-negocio>_<coluna-chave>` | `ck_cinfra_situacao_proposta_tp_proposta` |

O texto da Tabela 3 contém diferenças em relação aos exemplos: o padrão de `pk` omite `_` entre mnemônico e tabela, o de `uk` contém `__`, enquanto os exemplos usam separador simples. O padrão de `ck` também não exibe `_` entre mnemônico e tabela, mas o exemplo exibe. Preserve esta divergência como tal: consulte a convenção efetiva do projeto e, se ela não existir, informe a ambiguidade antes de fixar o nome definitivo. O nome de coluna FK também é descrito ora como derivado da coluna de destino, ora como derivado da tabela de destino; o molde e o exemplo usam a tabela de destino.
