# MANUAL DE PADRÕES E NORMAS PARA ADMINISTRAÇÃO DE DADOS

## Histórico de Versões

| Data | Versão | Autor | Descrição |
|---|---:|---|---|
| 13/01/2020 | 1.0 | Carlos Lira | Criação do documento. |
| 21/01/2020 | 1.0 | Daniel Alcântara | Revisão |
| 21/01/2020 | 1.0 | Gustavo Ferraz | Revisão |

## Índice

- [1. Introdução](#1-introdução)
- [2. Objetivo](#2-objetivo)
- [3. Convenção Básica Para Nomenclatura de Objetos de Bancos de Dados](#3-convenção-básica-para-nomenclatura-de-objetos-de-bancos-de-dados)
  - [3.1. Nomenclatura de objeto de banco de dados](#31-nomenclatura-de-objeto-de-banco-de-dados)
  - [3.2. Regras Específicas](#32-regras-específicas)
  - [3.3. Criação dos scripts de definição dos dados](#33-criação-dos-scripts-de-definição-dos-dados)
- [4. Nomenclatura e permissões para criação dos usuários/roles de banco de dados](#4-nomenclatura-e-permissões-para-criação-dos-usuáriosroles-de-banco-de-dados)
- [5. Boas práticas para geração dos scripts de banco de dados](#5-boas-práticas-para-geração-dos-scripts-de-banco-de-dados)
- [6. Referências Bibliográficas](#6-referências-bibliográficas)

## 1. Introdução

As informações descritas neste documento visam estabelecer uma convenção de nomenclatura e modelagem de dados a ser seguida por todos os envolvidos no processo de desenvolvimento de novas aplicações que utilizam o armazenamento de informações em banco de dados. Com a preocupação em tornar seguro o entendimento das informações que estão sendo armazenadas, objetivando o bom entendimento do negócio, a projeção adequada das bases de dados, o compartilhamento e a integração entre os sistemas de informação, garantindo sua integridade, mitigando riscos de entendimento.

Os objetos legados não serão afetados, entretanto novos objetos criados e/ou alterados, mesmo que derivados dos objetos legados, devem se enquadrar aos padrões e normas de nomenclatura estabelecidos neste Manual de Padrões e Normas para Administração de Dados.

## 2. Objetivo

Este documento tem por objetivo implementar regras de nomenclatura para uma metodologia de construção de objetos de um banco de dados.

Estabelecer um conjunto de regras com o intuito de padronizar o processo de criação de objetos e de seus atributos, facilitando atividades como organização e futuras manutenções das estruturas de dados.

Define-se como objetos, elementos que armazenam dados alfanuméricos ou espaciais e suas relações de integridade, tais como, tabelas, atributos, base de dados, entre outros.

## 3. Convenção Básica Para Nomenclatura de Objetos de Bancos de Dados

Os objetos de banco de dados devem obedecer aos seguintes critérios básicos no que diz respeito à nomeação de objetos:

- É obrigatório o uso de caracteres alfanuméricos apenas;
- É obrigatório o uso de letras minúsculas;
- Para determinado nome que é composto por mais de uma palavra, é obrigatório utilizar o caractere underline (`_`), separador universal, como separador entre cada palavra;
- É obrigatório o uso de palavras no singular;
- Não uso de acentuação gráfica e nem de caracteres especiais (tais como `@`, `#`, `$`, `%`, `&`, etc.);
- Não utilize preposições, artigos, conectivos (o, a, de...) etc;
- O uso de acrônimos e/ou abreviações e/ou siglas é permitido e aconselhado;

### 3.1. Nomenclatura de objeto de banco de dados

Definição dos padrões de nomenclatura dos objetos de banco de dados.

#### 3.1.1. Prefixos e Sufixo de tipos de objetos

O prefixo e o sufixo tem o propósito de classificar e/ou categorizar os objetos de acordo com a necessidade do negócio. Os objetos podem ser identificados por intermédio de uma sigla (prefixo/sufixo) que indicará o tipo de objeto, conforme informado na tabela de especificação de nomenclatura de objetos de banco de dados (Tabela 1).

É recomendável o uso do prefixo ou sufixo de tipo de objeto na formação do nome do objeto.

Desta forma, em alguns casos, os objetos criados possuirão uma sigla com o propósito de classificá-los conforme a sua natureza de objeto ou agrupamento.

Utilize o seguinte formato para nomenclatura de nomes de objetos:

```text
Formação 1: <prefixo-mnemônico-sistema>_ <nome-objeto>
Ex: cinfra_proposta

Formação 2: <prefixo-tipo-objeto>_ <nome-objeto>
Ex: fn_calcula_dv

Formação 3: <nome-objeto>_<sufixo-tipo-objeto>
Ex: responsavel_legal_seq
```

Onde:

- `prefixo-mnemônico-sistema` = Mnemônico que identifica o sistema.
- `nome-objeto` = substantivo com valor semântico.
- `prefixo-tipo-objeto` = prefixo que identifica o tipo de objeto.
- `sufixo-tipo-objeto` = sufixo que identifica o tipo de objeto.

### 3.2. Regras Específicas

#### 3.2.1. Para formação de nomenclatura dos objetos

Além da convenção básica para nomenclatura de objetos, as regras abaixo devem ser seguidas:

- Números podem ser utilizados, desde que não iniciem a denominação (também chamado “complemento denominativo”) do objeto;
- Verifique atentamente se as abreviações não resultarão em interpretações dúbias quanto ao valor semântico do objeto dentro do sistema;
- Abrevie o nome do objeto, caso necessário, conservando a facilidade de identificação de seu conteúdo;
- O nome dos esquemas deverão conter no máximo 20 caracteres;
- O nome das tabelas deverão conter no máximo 63 caracteres (limite máximo padrão do PostgreSQL);
- É obrigatório que as tabelas tenham uma descrição sobre a finalidade da mesma;
- O nome dos atributos das tabelas deverão conter no máximo 50 caracteres;
- É obrigatório que atributos tenham uma descrição sobre a finalidade do mesmo;
- Todas as tabelas criadas que possuírem operação de exclusão ou atualização (`delete`/`update`) deverão conter o seguinte atributo para controle de concorrência:
  - `nr_versao` (`int8`) – Identifica a versão do registro.
- Todas as tabelas criadas deverão conter os seguintes atributos para auditoria:
  - `audit_usuario` (`varchar 30`) – Identifica o usuário que realizou a operação;
  - `audit_dh_atualizacao` (`timestamp`) – Registra data e hora da operação;
  - `audit_nm_operacao` (`varchar 6`) – Identifica a operação (`INSERT`, `UPDATE`, `DELETE`).
- Todas as tabelas criadas deverão ter uma tabela de auditoria associada para gravação dos registros manipulados com a mesma estrutura da tabela de negócio e deverão utilizar um gatilho/função (trigger/function) para realizar tal procedimento.
- As tabelas de auditoria deverão ser em “schema” separado das tabelas de negócio.
- O “schema” das tabelas de auditoria deverá seguir as regras definidas na tabela de especificação de nomenclatura de objetos de banco de dados (Tabela 1).
- O gatilho/função para atender o processo de auditoria deve ser único e genérico, conforme tabela de especificação de nomenclatura de objetos de banco de dados (Tabela 1).

| Natureza do Objeto | Descrição | Padrão de Nomenclatura | Exemplos |
|---|---|---|---|
| Function | Objetos com características de functions (gerais). | `fn_<mnemônico sistema>_<nome-função>` | `fn_cinfra_calcula_dv` |
| Function | Objetos com características de functions chamada por uma trigger para registros de auditoria de tabelas. | `fn_generic_audit_trigger` | `fn_generic_audit_trigger()` |
| Function | Objetos com características de functions chamada por uma trigger para de controle de concorrência nas atualizações das tabelas. | `fn_generic_concurrent_trigger` | `fn_generic_concurrent_trigger()` |
| Materialized View | Objetos com características de views (visões) de dados. | `mv_<mnemônico sistema>_<nome-view-materialized>` | `mv_cinfra_situacao_proposta` |
| Tabela | Tabelas que armazenam informações de Negócio. | `<mnemônico-sistema>_<tabela-negocio>` | `cinfra_proposta` |
| Tabela | Tabelas que armazenam informações temporárias. | `<mnemônico-sistema>_<tabela-negocio>_tmp` | `cinfra_contrato_tmp` |
| Tabela | Tabelas que armazenam informações de auditoria. | `<mnemônico-sistema>_<tabela-negocio>_audit` | `cinfra_proposta_audit` |
| Trigger | Objetos com características de triggers para tabelas de negócio. | `tg_<mnemônico sistema>_<tabela-negocio>` | `tg_cinfra_proposta` |
| Trigger | Objetos com características de triggers para tabelas de auditoria. | `tg_audit_<mnemônico sistema>_<tabela-negocio>` | `tg_audit_cinfra_proposta` |
| Trigger | Objetos com características de triggers para controle de concorrência. | `tg_concurrent_<mnemônico sistema>_<tabela-negocio>` | `tg_concurrent_cinfra_proposta` |
| View | Objetos com características de views (visões) de dados. | `vw_<mnemônico sistema>_<nome-view>` | `vw_cinfra_situacao_proposta` |
| Index | A criação de índices para melhorar o desempenho do banco de dados. | `idx_<mnemônico sistema>_<tabela-negocio>_<coluna-indice>` | `idx_cinfra_proposta_convenio_fk` |
| Sequence | Objetos para implementação e controle de valores sequenciais de registros de um determinado objeto. | `<mnemônico sistema>_<tabela-negocio>_seq` | `cinfra_proposta_seq` |
| Schema para Tabelas de Negócio | Esquema é a estrutura do banco de dados que define os objetos no banco de dados. | `<nome-esquema>` | `cinfra` |
| Schema Tabelas de Auditoria | Esquema é a estrutura do banco de dados que define os objetos no banco de dados. | `<nome-esquema>_audit` | `cinfra_audit` |

*Tabela 1 - Especificação de nomenclatura de objetos de banco de dados*

#### 3.2.2. Para formação de mnemônico do sistema

- O mnemônico do sistema deverá ser criado com no máximo 6 caracteres e que identifique de forma inequívoca o sistema a qual pertence e todas as tabelas e devem utilizar o mesmo prefixo, como também os demais objetos que possuam regra para o seu uso;

#### 3.2.3. Para nomenclatura de tabelas de negócio

Além da convenção básica para nomenclatura de objetos de banco de dados, as regras abaixo devem ser seguidas:

- Os nomes de tabelas devem ser alusivos aos dados que serão armazenados.
- O substantivo utilizado na nomenclatura deverá possuir valor semântico.
  - Ex: `cinfra_especificacao_projeto_basico`
- Obrigatoriamente a tabela deverá ter como prefixo o mnemônico do sistema a que pertence.
  - Ex: `cinfra_proposta`

O mnemônico do sistema identificará o agrupamento de tabelas dentro do modelo relacional do sistema.

#### 3.2.4. Para nomenclatura de tabelas de auditoria

Além da convenção básica para nomenclatura de objetos de banco de dados, as regras abaixo devem ser seguidas:

- Os nomes de tabelas de auditoria devem ser igual ao nome da tabela de negócio relacionada e acrescido o sufixo `_audit`.
  - Ex: `cinfra_especificacao_projeto_basico_audit`

#### 3.2.5. Para nomenclatura de atributos de tabelas

Além da convenção básica para nomenclatura de objetos de banco de dados, em geral, as inserções de atributos (campos) utilizará as seguintes regras para nomenclatura de atributos:

- É obrigatório, quando existir, o uso da sigla identificadora de tipo de atributo na formação do nome do atributo (Tabela 2);
- Defina a ordenação dos nomes dos atributos através da importância dos mesmos;
  - Exemplo: O código de um objeto deve anteceder seu nome;
  - O nome deve vir antes do endereço e assim por diante;
- Os nomes das colunas devem deixar clara a sua finalidade na tabela;
- É obrigatório que as colunas tenham uma descrição sobre a finalidade da mesma;

##### 3.2.5.1. Siglas de tipos de atributo

As siglas de tipos de atributo auxiliam na organização e categorização dos atributos. A organização ou uniformização dos tipos de um atributo, devem ser conforme exemplos abaixo:

- `nm` – nome, utilizado para qualquer tipo de atributo que se encaixe na categoria de “atributo de nomeação”: `nm`;
- `dt` – data, para atributos de datas gerais, não específicas: `dt`;
- `cd` – representativo de código.

##### 3.2.5.2. Siglas identificadoras de tipo padrão de atributo

As siglas identificadoras de tipo de atributo devem, obrigatoriamente, ser uma das relacionadas na Tabela 2. A lista pode ser expandida conforme necessidade, desde que a sugestão de novo tipo de atributo seja discutida e aprovada pelo DBA responsável pelo sistema.

| Natureza | Título | Aplicação | Exemplo | Observação |
|---|---|---|---|---|
| `aa` | Ano | Atribuída aos dados de natureza numérica que expressam um ano num calendário qualquer. | `aa_inclusao` | Vide as naturezas `dt` e `te`. |
| `aq` | Arquivo | Atribuída aos dados que fazem referência a um arquivo eletrônico armazenado diretamente no banco de dados ou apenas apontado por ele. | `aq_submetido` | |
| `cd` | Código | Atribuída aos dados de natureza numérica ou alfanumérica que trazem embutidos significados semânticos na sua forma. Implicam numa estruturação interna. | `cd_evento`, `cd_ug` | |
| `dd` | Dia | Atribuída aos dados de natureza numérica que expressam um dia, sem precisar o mês ou o ano, num calendário qualquer. | `dd_pagamento` | Vide as naturezas `dt` e `te`. |
| `dh` | Data/Hora | Atribuída aos dados de natureza numérica ou alfanumérica que precisam um dia e a hora num calendário qualquer. | `dh_operacao` | Vide as naturezas `dd`, `mm`, `aa`, `hh`, `te`. |
| `dt` | Data | Atribuída aos dados de natureza numérica ou alfanumérica que precisam um dia num calendário qualquer. | `dt_transacao` | Vide as naturezas `dd`, `mm`, `aa`, `dh` e `te`. |
| `dv` | Dígito Verificador | Atribuída aos dados de qualquer natureza utilizados para validar a ocorrência de um item. | `dv_cpf` | Vide as naturezas `sn` e `nr`. |
| `hh` | Hora | Atribuída aos dados de natureza numérica ou alfanumérica que precisam uma hora em qualquer formato, com ou sem precisão de minutos e/ou quaisquer outras frações. | `hh_sistema` | Vide a natureza `te`. |
| `id` | Identificador | Um número usado para designar uma instância específica de uma entidade, mas sem significado no contexto de negócio. | `id_ug`, `id_documento` | |
| `im` | Imagem | Um conteúdo gráfico associado a um tipo de codificação de imagem como: Bitmap, JPG, GIF, MPEG ou outros. | `im_usuario` | |
| `in` | Indicador | Atribuída aos dados de qualquer natureza cujo conteúdo identifica uma restrição de domínio de uma entidade. Podendo ser constituída por mais de dois domínios específicos dentre os valores possíveis para o atributo ou coluna. | `in_cargo` | Vide a natureza `sn` e somente será utilizada quando por motivo justificável se decida não criar a entidade correspondente. |
| `mm` | Mês | Atribuída aos dados de natureza numérica ou alfanumérica que expressam um mês, sem precisar o ano, num calendário qualquer. | `mm_referencia` | Vide as naturezas `dt` e `te`. |
| `nm` | Nome | Atribuída aos dados de natureza alfabética ou alfanumérica que identifica coloquialmente uma ocorrência de uma entidade, ainda que somente o faça de maneira imprecisa ou limitada. | `nm_evento` | Vide as naturezas `sg` e `tx`. |
| `nr` | Número | Atribuída aos dados de natureza numérica sobre os quais não se aplicam operações aritméticas. | `nr_inciso`, `nr_lei` | Vide as naturezas `id`, `qt`, `vl`, `op` e `pe`. |
| `op` | Operando | Atribuída aos dados numéricos, tais como índices, fatores de correção, coeficientes, etc. utilizados em operações. | `op_taxa_selic` | A natureza `op` predomina sobre `pe`. |
| `pe` | Percentual | Atribuída aos dados numéricos que expressam razões na forma de percentagens. | `pe_projeto` | Vide as naturezas `op`, `va` e `nr`; e a natureza `pe` predomina sobre `qt`. |
| `qt` | Quantidade | Atribuída aos dados de natureza numérica que expressam uma medida qualquer, exceto as relativas a tempo e a moeda e equivalentes. | `qt_servidor` | Vide as naturezas `op`, `nr`, `pr`, `va` e `te`. |
| `sg` | Sigla | Atribuída aos dados de natureza alfabética ou alfanumérica que expressam a forma sintética de um conteúdo extenso, em geral um nome. | `sg_orgao` | Vide as naturezas `nm` e `tx`. |
| `sn` | Controle | Atribuída aos dados com características de lógica “booleana” que expressam dois domínios específicos. | `sn_permissao` | |
| `te` | Tempo | Atribuída aos dados de natureza numérica que expressam uma quantidade de tempo em qualquer unidade ou formato. | `te_sessao` | Vide as naturezas `dt`, `dd`, `mm`, `aa`, `dh` e `hh`. |
| `tp` | Tipo | Atribuída aos dados de qualquer natureza cujo conteúdo identifica uma restrição de domínio de uma entidade, análoga ao indicador. Deve ser constituída por mais de dois domínios específicos dentre os valores possíveis para a coluna. | `tp_arrecadacao`, `tp_pessoa` | Vide a natureza `in`. |
| `tx` | Texto | Atribuída aos dados cujo conteúdo é livre e descrito em forma discursiva, geralmente usada para observações e conteúdos textuais extensos. | `tx_contrato` | Vide as naturezas `nm` e `sg`. |
| `vl` | Valor | Atribuída aos dados de natureza numérica que expressam uma quantidade monetária ou equivalente. | `vl_lancamento` | Vide as naturezas `qt` e `op`. |

*Tabela 2 - Especificação de nomenclatura de atributos de tabelas*

#### 3.2.6. Para nomenclatura de atributos do tipo Constraints

Além da convenção básica para nomenclatura de objetos de banco de dados e das siglas identificadoras de tipos de atributos (Tabela 2) as inserções de “Constraints” utilizarão as seguintes regras para nomenclatura de atributos:

- As chaves estrangeiras deverão ser compostas com o nome da coluna da tabela destino acrescida do sufixo `fk`:

```text
Formação 1: <nome-tabela-destino>_fk
Ex: conta_bancaria_fk (Chave estrangeira para tabela cinfra_conta_bancaria)
```

A tabela abaixo estabelece o padrão de nomenclatura para as Constraints.

| Natureza do Objeto | Descrição | Padrão de Nomenclatura | Exemplos |
|---|---|---|---|
| Constraints | Restrições para as colunas nas tabelas do tipo Primary Key - `pk`. | `<mnemônico sistema><tabela-negocio>_pk` | `cinfra_situacao_proposta_pk` |
| Constraints | Restrições para as colunas nas tabelas do tipo Foreing Key - `fk`. | `fk_<mnemônico sistema>_<tabela-negocio>_<coluna-estrangeira>` | `fk_cinfra_situacao_proposta_contrato_fk` |
| Constraints | Restrições para as colunas nas tabelas do tipo Unique Key - `uk`. | `uk__<mnemônico sistema>_<tabela-negocio>_<coluna-chave>` | `uk_cinfra_situacao_proposta_nr_sequencial` |
| Constraints | Restrições para as colunas nas tabelas do tipo Check Constraint - `ck`. | `ck_<mnemônico sistema>_<tabela-negocio>_<coluna-chave>` | `ck_cinfra_situacao_proposta_tp_proposta` |

*Tabela 3 - Especificação de nomenclatura de atributos do tipo Constraints*

### 3.3. Criação dos scripts de definição dos dados

#### 3.3.1. Nomenclatura

Os scripts de criação e/ou alteração dos objetos da base de dados deverão seguir a padronização de nomenclatura abaixo:

```text
<mn>_<aaaammdd>_SS<número SS>_<nn>_<descrição>_<iniciais>.sql
```

Onde:

- `mn`: Mnemônico do sistema;
- `aaaammdd`: data que o script foi gerado;
- `número SS`: Número da SS correspondente à demanda;
- `nn`: Sequencial do script, de acordo com a ordem de execução;
- `descrição`: Descrição sucinta do objetivo do script;
- `iniciais`: Iniciais do nome do atendente em letras maiúsculas;

Exemplo: `CINFRA_20200103_SS1234567_01_script_exemplo_CRSL.sql`

#### 3.3.2. Cabeçalho

O arquivo `.sql` deve possuir o seguinte cabeçalho:

```sql
/*
* ======================= DADOS DO SCRIPT ====================================
* AUTOR: <NOME>
* OBJETIVO: <breve descricao do objetivo da alteracao>
* PRE-REQUISITOS: <arquivos a serem aplicados em ordem>
*/
```

## 4. Nomenclatura e permissões para criação dos usuários/roles de banco de dados

Definição dos padrões de nomenclatura para criação e permissões de acesso para os usuários do banco de dados.

### 4.1. Nomenclatura para criação dos usuários

A criação dos usuários da base de dados deverão seguir a padronização de nomenclatura abaixo de acordo com o ambiente e as permissões:

#### 4.1.1. Usuários para ambiente de desenvolvimento

- Usuários da aplicação: `usr_<mn><n>_d`
- Usuários proprietários: `owner_<mn><n>_d`

Onde:

- `mn`: Mnemônico do sistema;
- `n`: Sequencial para indicar a numeração do ambiente de banco de dados de desenvolvimento.

#### 4.1.2. Usuários para ambiente de homologação

- Usuários da aplicação: `usr_<mn><n>_h`
- Usuários proprietários: `owner_<mn><n>_h`

Onde:

- `mn`: Mnemônico do sistema;
- `n`: Sequencial para indicar a numeração do ambiente de banco de dados de homologação.

#### 4.1.3. Usuários para ambiente de produção

- Usuários da aplicação: `usr_<mn><n>_p`
- Usuários proprietários: `owner_<mn><n>_p`

Onde:

- `mn`: Mnemônico do sistema;
- `n`: Sequencial para indicar a numeração do ambiente de banco de dados de produção.

### 4.2. Permissões para os usuários da aplicação

Os usuários da base de dados deverão receber as permissões de acordo com os objetos relacionados e suas necessidades.

#### 4.2.1 Concessão de privilégios para os usuários

- **Usuários da aplicação:**
  - Para as tabelas de negócios, conceder privilégios de consulta, exclusão, atualização, inserção e referências para as tabelas e de uso para as sequências, quando for o caso.
  - Para as tabelas de auditoria, conceder apenas privilégios de consulta e inserção e de uso para as sequências, quando for o caso.
- **Usuários proprietários:** concessão de todos os privilégios.

## 5. Boas práticas para geração dos scripts de banco de dados

### 5.1 Analisar as tabelas, as colunas e os relacionamentos criados

Verificando as questões de existência das informações no modelo anterior, bem como:

- se o modelo afeta implementações anteriores;
- se o modelo atende ao negócio de forma completa;
- se há existência de tabelas/colunas desnecessárias;
- se há existência de duplicação de tabelas/colunas, gerando inconsistências;
- se há falta de tabelas/colunas necessárias;
- se este pode ser melhor representado (buscar simplicidade) para atender à necessidade do negócio.

### 5.2 Gerar scripts de alteração de estrutura/dados do Banco de Dados

Conforme Padrão de Nomenclatura de Objetos de Banco de Dados.

### 5.3 Criar índice para cada FK

Incluindo as colunas que fazem parte desta. Caso seja necessário por questões de performance, criar outros índices, conforme Padrão de Nomenclatura de Objetos de Banco de Dados.

### 5.4 Aplicar script no Banco de Dados

Corrigindo no script os erros levantados.

### 5.5 Versionar scripts gerados

Após correções, conforme Padrão de Versionamento dos Scripts de Banco de Dados dos Projetos.

## 6. Referências Bibliográficas

IBRAM, Instituto Brasília Ambiental - Regras e Padrões para Nomenclatura de Objetos Versão 2.0
