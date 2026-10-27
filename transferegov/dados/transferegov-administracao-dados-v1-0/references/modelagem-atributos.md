# Modelagem, atributos, auditoria e índices

Fonte: `MANUAL_PADRÕES_NORMAS_ADMINISTRAÇÃO_DADOS.md`, versão 1.0, seções 3.2.1, 3.2.5, 3.2.6 e 5, Tabela 2. Leia [nomenclatura-objetos.md](nomenclatura-objetos.md) para convenção básica, nomes e limites de objetos.

## Revisão do modelo (seção 5.1)

Antes de gerar alterações, analise tabelas, colunas e relacionamentos já existentes. Verifique se o novo modelo afeta implementações anteriores, atende completamente ao negócio, contém tabelas ou colunas desnecessárias, duplicadas ou ausentes, e se há uma representação mais simples para a necessidade do negócio.

Objetos legados existentes não são afetados retroativamente pelo manual. Objetos novos e objetos alterados, mesmo derivados de legados, devem seguir as regras. Não conclua que uma alteração em legado dispensa a convenção.

## Regras para colunas

- Nome de coluna com no máximo **50 caracteres**, minúsculo, sem acento, componentes separados por `_`, finalidade inequívoca e descrição obrigatória.
- Quando existir sigla de natureza aplicável na Tabela 2, ela é obrigatória no nome do atributo. Novas siglas somente podem ser acrescentadas após discussão e aprovação do DBA responsável pelo sistema.
- Ordene os atributos por importância: o código de um objeto antecede o nome; o nome antecede o endereço, e assim por diante.
- Siglas exemplificadas pelo manual: `nm` para nome, `dt` para data geral e `cd` para código.
- Chave estrangeira: nome derivado da tabela de destino seguido de `_fk`, como `conta_bancaria_fk` para `cinfra_conta_bancaria`. Consulte a ressalva de redação em [nomenclatura-objetos.md](nomenclatura-objetos.md).
- Descreva a finalidade de cada tabela e coluna, por exemplo com comentários de banco quando gerar DDL. A tecnologia exata de documentação depende do projeto.

## Siglas de atributos (Tabela 2 completa)

| Sigla | Título | Aplicação | Exemplo | Observação do manual |
| --- | --- | --- | --- | --- |
| `aa` | Ano | Número que expressa um ano em qualquer calendário. | `aa_inclusao` | Vide `dt` e `te`. |
| `aq` | Arquivo | Referência a arquivo eletrônico armazenado no banco ou apenas apontado por ele. | `aq_submetido` | — |
| `cd` | Código | Dado numérico ou alfanumérico com significado semântico embutido na forma e estruturação interna. | `cd_evento`, `cd_ug` | — |
| `dd` | Dia | Número que expressa um dia sem precisar mês ou ano. | `dd_pagamento` | Vide `dt` e `te`. |
| `dh` | Data/Hora | Dado numérico ou alfanumérico que precisa um dia e a hora. | `dh_operacao` | Vide `dd`, `mm`, `aa`, `hh` e `te`. |
| `dt` | Data | Dado numérico ou alfanumérico que precisa um dia em qualquer calendário. | `dt_transacao` | Vide `dd`, `mm`, `aa`, `dh` e `te`. |
| `dv` | Dígito Verificador | Dado de qualquer natureza usado para validar a ocorrência de um item. | `dv_cpf` | Vide `sn` e `nr`. |
| `hh` | Hora | Hora numérica ou alfanumérica, em qualquer formato, com ou sem minutos e outras frações. | `hh_sistema` | Vide `te`. |
| `id` | Identificador | Número que designa instância específica de uma entidade, sem significado de negócio. | `id_ug`, `id_documento` | — |
| `im` | Imagem | Conteúdo gráfico associado a codificação como Bitmap, JPG, GIF, MPEG ou outra. | `im_usuario` | — |
| `in` | Indicador | Dado de qualquer natureza que identifica restrição de domínio de uma entidade, podendo ter mais de dois domínios específicos. | `in_cargo` | Vide `sn`; use somente quando houver motivo justificável para não criar a entidade correspondente. |
| `mm` | Mês | Número ou texto que expressa um mês sem precisar o ano. | `mm_referencia` | Vide `dt` e `te`. |
| `nm` | Nome | Dado alfabético ou alfanumérico que identifica coloquialmente uma ocorrência de entidade, ainda que de forma imprecisa ou limitada. | `nm_evento` | Vide `sg` e `tx`. |
| `nr` | Número | Dado numérico sobre o qual não se aplicam operações aritméticas. | `nr_inciso`, `nr_lei` | Vide `id`, `qt`, `vl`, `op` e `pe`. |
| `op` | Operando | Número como índice, fator de correção ou coeficiente usado em operações. | `op_taxa_selic` | `op` predomina sobre `pe`. |
| `pe` | Percentual | Número que expressa razão em porcentagem. | `pe_projeto` | Vide `op`, `va` e `nr`; `pe` predomina sobre `qt`. |
| `qt` | Quantidade | Medida numérica, exceto tempo, moeda e equivalentes. | `qt_servidor` | Vide `op`, `nr`, `pr`, `va` e `te`. |
| `sg` | Sigla | Forma sintética alfabética ou alfanumérica de conteúdo extenso, em geral um nome. | `sg_orgao` | Vide `nm` e `tx`. |
| `sn` | Controle | Dado com lógica booleana que expressa dois domínios específicos. | `sn_permissao` | — |
| `te` | Tempo | Quantidade numérica de tempo em qualquer unidade ou formato. | `te_sessao` | Vide `dt`, `dd`, `mm`, `aa`, `dh` e `hh`. |
| `tp` | Tipo | Restrição de domínio de qualquer natureza, análoga a indicador, com mais de dois domínios específicos possíveis. | `tp_arrecadacao`, `tp_pessoa` | Vide `in`. |
| `tx` | Texto | Conteúdo livre e discursivo, geralmente observações e textos extensos. | `tx_contrato` | Vide `nm` e `sg`. |
| `vl` | Valor | Quantidade numérica monetária ou equivalente. | `vl_lancamento` | Vide `qt` e `op`. |

As referências a `va` e `pr` nas observações de `pe` e `qt` aparecem no manual, mas essas siglas não constam da lista aprovada. Não as introduza por inferência.

## Concorrência e auditoria (seção 3.2.1)

- Em toda tabela criada que permita exclusão ou atualização (`DELETE`/`UPDATE`), inclua `nr_versao` do tipo `int8` para identificar a versão do registro.
- Em toda tabela criada, inclua `audit_usuario` (`varchar(30)`) para identificar quem executou a operação, `audit_dh_atualizacao` (`timestamp`) para registrar data e hora e `audit_nm_operacao` (`varchar(6)`) para identificar `INSERT`, `UPDATE` ou `DELETE`.
- O manual diz que toda tabela criada deve ter uma tabela de auditoria associada, com a mesma estrutura, para gravar os registros manipulados; use trigger/function para isso. A própria regra de nomeação relaciona cada tabela de auditoria à sua tabela de negócio (`<nome-tabela-negocio>_audit`). Ao implementar, evite criar uma cadeia recursiva de auditoria de tabelas de auditoria; confira a convenção existente se esse alcance for relevante. Mantenha as tabelas de auditoria em schema separado, com nome `<nome-esquema>_audit`.
- A função de auditoria deve ser única e genérica: `fn_generic_audit_trigger`. O manual também nomeia `fn_generic_concurrent_trigger` e triggers `tg_audit_<mnemônico>_<tabela>`, `tg_concurrent_<mnemônico>_<tabela>`; confira [nomenclatura-objetos.md](nomenclatura-objetos.md).
- O manual não especifica detalhes internos da função ou em que operação cada registro de auditoria será capturado. Consulte as implementações existentes antes de escrever ou substituir funções e triggers.

## Índices e scripts (seções 5.2–5.5)

- Crie um índice para cada FK, incluindo todas as colunas que compõem a chave estrangeira.
- Crie outros índices se necessários para desempenho, seguindo a nomenclatura de índices da Tabela 1.
- Gere scripts de alteração de estrutura e dados conforme o padrão de nomenclatura de objetos; confira [scripts-acessos.md](scripts-acessos.md).
- Aplique os scripts no banco apropriado e corrija no próprio script os erros encontrados; versione-os depois das correções conforme o padrão de versionamento dos projetos, que é citado mas não detalhado no manual.
