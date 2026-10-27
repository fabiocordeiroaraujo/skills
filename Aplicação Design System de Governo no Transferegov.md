# Guia de Aplicação do Design System de Governo no Transferegov.br

## Histórico de versões

| Data | Versão | Descrição | Autor | Revisor |
| --- | --- | --- | --- | --- |
| 26/07/2024 | 1.0 | Criação do documento | Cateane Scarpa; Jonathan T. Silva | Ana Elizabeth X. C. Albuquerque; Artur F. L. Figueiredo; Lairson E. R. A. Oliveira; Ralph B. Rabelo; Silverio M. Del Fiaco; Thaise A. Dantas; Valter T. Kamiji |
| 01/11/2024 | 1.1 | Inclusão da seção “Apresentação de Acordo com o Tipo de Dado” | Cateane Scarpa | |
| 10/12/2024 | 1.2 | Comportamentos padrões nas tabelas; ajustes nas regras de apresentação do cabeçalho da aplicação | Cateane Scarpa | |
| 17/12/2024 | 1.3 | Inclusão de ícone para a ação de “estornar” | Silvério M. Del Fiaco | |
| 02/04/202 | 1.4 | Atualização de links | Cateane Scarpa | |

Portal: <https://portal.transferegov.sistema.gov.br/>

## Índice

1. Introdução
2. Base Estrutural
   1. Cabeçalho
   2. Menu Principal
   3. Recomendação
3. Listagens a partir do Menu
   1. Título e Subtítulo
   2. Parâmetros de Pesquisa
   3. Operações Relacionadas ao Resultado
4. Formulários de Inclusão e Edição de Dados
   1. Título e Subtítulo
   2. Agrupamentos
   3. Botões
   4. Ajudas
   5. Abas e Subabas
   6. Listagens em formulários de inclusão e edição
5. Detalhamento
6. Iconografia e Principais Verbos
   1. Tag
7. Uso de Cores
   1. Superfícies de Agrupamento (Containers)
8. Apresentação de Acordo com o Tipo de Dado
   1. UF
   2. Números
   3. Valores Monetários
9. Atualização de Versões
10. Referências

## 1. Introdução

Todos os componentes e padrões dos sistemas devem seguir o padrão visual e as diretrizes do Design System do Governo Federal do Brasil. Contudo, o padrão visual de governo apresenta opções cuja seleção fica a cargo de desenvolvedores e designers, conforme o caso tratado. Assim, o padrão permanece flexível para realidades e necessidades diversas.

Este documento define os padrões de interface dos módulos do Transferegov em adesão ao Padrão Digital de Governo. Seu objetivo é uniformizar as interfaces e integrar a experiência de uso entre módulos: o usuário final deve perceber um único sistema.

Para a construção de protótipos, recomenda-se copiar os modelos de telas disponíveis nos ativos do Padrão Digital de Governo: <https://www.gov.br/ds/downloads/assets>.

As orientações visam abranger o máximo de soluções de interface necessárias ao desenvolvimento correto dos sistemas.

## 2. Base Estrutural

A Base Estrutural define as áreas mínimas de conteúdo das telas do Transferegov e o conteúdo que cada área deve apresentar.

### 2.1. Cabeçalho

O cabeçalho agrupa componentes predefinidos que auxiliam o usuário no acesso às funcionalidades principais do sistema.

| ID | Nome | Descrição |
| ---: | --- | --- |
| 1 | Logo | Logo do Transferegov. |
| 3 | Título | Texto “Transferegov.br”, com link para a página inicial do módulo. |
| 4 | Subtítulo | Versão do módulo. |
| 5 | Botão Menu | Componente padronizado de menu. Todos os módulos apresentam todos os itens de menu de acordo com o usuário logado ou acesso livre. |
| 6 | Área para Links | Apresenta os links **Legislação** e **Integrações**. |
| 7 | Área para Funcionalidades | Apresenta link para o termo de uso, que é um componente da Esteira de Parcerias. |
| 8 | Botão Autenticar | Apresentado enquanto o usuário não está logado. |
| 9 | Avatar do Usuário | Apresentado quando o usuário estiver autenticado. Junto ao avatar há um dropdown com lista de vínculos, nome do usuário logado, vínculo selecionado e opção para encerrar a seção. A Esteira possui serviços e componente pronto para essa estrutura. |
| 12 | Superfície | Superfície do cabeçalho. |

O documento apresenta exemplos de cabeçalho quando o usuário está deslogado (Imagem 2.1-1) e quando está logado (Imagem 2.1-2).

#### 2.1.1. Comportamento

O cabeçalho apresenta o comportamento **Sticky Header**: quando o usuário rola a página para cima, o cabeçalho fixa no topo da área visível enquanto o conteúdo passa por baixo dele. Nesse estado, o cabeçalho é exibido de forma reduzida.

O documento apresenta o exemplo de cabeçalho no modo sticky (Imagem 2.1.1-1).

Veja mais em:

- DSGov: Componente Header.
- Esteira de Parcerias: Componente App Main Layout.
- CNU - Esteira de Parcerias - Login e Logout de Usuários.
- CNU - Esteira de Parcerias - Termo de Uso.

### 2.2. Menu Principal

O menu principal é acionado pelo ícone localizado no cabeçalho. Quando acionado, seus itens são apresentados lateralmente, sobre o conteúdo da página, conforme o comportamento “Menu Flutuante > Preenchimento” do DSGov.

O menu do Transferegov deve usar densidade média, que equilibra economia de espaço e separação dos elementos.

O documento apresenta o exemplo de menu principal sobreposto (Imagem 2.2-1).

Veja mais em:

- DSGov: Componente de Menu.
- Esteira de Parcerias: Componente App Main Layout.

### 2.3. Recomendação

Para organizar cabeçalho, menu e rodapé, recomenda-se usar o componente `<ep-layout>` disponibilizado pela Esteira de Parcerias.

Veja mais em:

- Layout Esteira de Parcerias.

## 3. Listagens a partir do Menu

Ao acionar um item de menu, na maior parte dos casos o sistema apresenta uma tela de consulta para selecionar o registro que será mantido. Essa tela se diferencia dos demais formulários porque seu foco é o conjunto de filtros e a listagem de registros; as demais operações são secundárias.

| ID | Nome |
| ---: | --- |
| 1 | Título e subtítulo. |
| 2 | Botão com operação de destaque. |
| 3 | Filtros de pesquisa e opção para fechar filtro. |
| 4 | Botões relacionados aos filtros de pesquisa. |
| 5 | Operações relacionadas ao resultado. |
| 6 | Listagem do resultado. |

O documento apresenta exemplos de tela com tabela e parâmetros de pesquisa expandidos (Imagem 3.1-1) e retraídos (Imagem 3.2-2).

### 3.1. Título e Subtítulo

A tela deve possuir apenas um título. Use subtítulo apenas excepcionalmente, quando houver necessidade de orientação extra ao usuário. Ao usar o CSS do Design System, basta utilizar a tag `<h1>`.

### 3.2. Parâmetros de Pesquisa

Use espaçamento de 32 px ao redor do grupo. A classe `p5` cria o padding interno para conforto visual. Para resposta adequada, use as classes `p-sm-2 p-md-4 p-lg-5`.

Quando houver conjunto muito extenso de filtros, organize-o em subgrupos com `fieldset`.

A seção de filtros pode estar expandida ou retraída. Avalie cada caso: se normalmente o usuário precisa aplicar filtro para localizar o registro, a seção deve iniciar expandida. A tela também deve apresentar a seção expandida quando algum filtro estiver aplicado no carregamento.

> **Definição extra:** após aplicar filtros e realizar uma operação, como editar um registro, os filtros e parâmetros aplicados devem ser mantidos ao retornar à consulta.

A biblioteca `maisbrasil-ep-base-web` possui o serviço `FiltroService`, cuja função é guardar filtros para recuperá-los posteriormente.

### 3.3. Operações Relacionadas ao Resultado

Recomenda-se que toda tabela tenha ordenação padrão. A coluna escolhida precisa indicar no cabeçalho que é a ordenação padrão.

Conforme a definição do componente de tabela do Design System, a barra de título pode conter ícones de ações utilitárias. Recomenda-se até quatro ícones lado a lado. Acima desse número, use o botão de acesso ao menu flutuante.

No Transferegov, os botões de exportação do resultado devem ficar agrupados no ícone **Acessar Opções**. O documento apresenta esse padrão na Imagem 3-3.

As demais operações devem ser definidas conforme a jornada do usuário. Por exemplo, ajustar colunas não deve ser disponibilizado em todas as tabelas, pois pode confundir usuários menos experientes e não trazer ganho efetivo em todas as funcionalidades.

Ao acionar exportação:

- Em acesso livre, considere apenas a página atual.
- Para usuário logado com perfil de consulta, considere todo o conteúdo do resultado.

Avalie o desempenho de cada exportação para definir a solução técnica adequada:

- Limitar a quantidade de registros, solicitando filtro para restringir resultados e considerando 1.000 registros a partir da página corrente.
- Fazer exportação em lote.
- Exportar todo o conteúdo.

Avalie com o cliente o controle de acesso e o volume de recursos utilizados por essas opções.

## 4. Formulários de Inclusão e Edição de Dados

Formulário é um grupo de controles de entrada relacionados que permite fornecer dados ou configurar opções. Pode ser simples ou complexo e apresentado como página dedicada, painel lateral ou diálogo, conforme o caso de uso e a situação.

A página **Design > Formulário** trata vários aspectos segundo os padrões do Design System. Para o Transferegov, aplicam-se os pontos abaixo.

| ID | Nome |
| ---: | --- |
| 1 | Título e subtítulo (obrigatório). |
| 2 | Agrupamento por cor. |
| 3 | Agrupamento por Fieldset e Legend. |
| 4 | Agrupamento por Fieldset e Legend colapsado. |
| 5 | Ajuda. |
| 6 | Botões das operações principais. |
| 7 | Botões das operações secundárias. |
| 8 | Abas e subabas. |
| 9 | Listagens. |

O documento apresenta um exemplo de formulário de inclusão de dados (Imagem 4-1).

### 4.1. Título e Subtítulo

A tela deve possuir apenas um título. O subtítulo deve ser utilizado apenas excepcionalmente, quando for necessária orientação extra. Com o CSS do Design System, use `<h1>`.

Exemplo de título:

```html
<h1>Título</h1>
```

```css
{
  font-size: var(--font-size-scale-up-06);
  font-weight: var(--font-weight-light);
  margin-bottom: var(--spacing-scale-4x);
}
```

Exemplo de subtítulo:

```html
<p>Subtítulo</p>
```

```css
{
  font-size: var(--font-size-scale-base);
  font-weight: var(--font-weight-regular);
  margin-bottom: var(--spacing-scale-3x);
}
```

#### 4.1.1. Componente de Cabeçalho

Formulários que tratam de parceria devem usar o componente de cabeçalho. Ele disponibiliza informações da parceria que podem evoluir futuramente, com baixo impacto de atualização. Na primeira versão, estão disponíveis:

1. Título.
2. Dados da parceria:
   - Código da parceria;
   - Ente recebedor/proponente;
   - Situação e subsituação.
3. Dados do repassador:
   - Código do programa;
   - Ente repassador/concedente;
   - Nome do programa.

O documento apresenta o exemplo de cabeçalho da Esteira de Parcerias (Imagem 4.1.1-1).

Veja mais em:

- Esteira de Parcerias > Guia EP-Base-Web > Card Parceria.

### 4.2. Agrupamentos

Para ajudar o usuário a compreender a diagramação dos formulários, agrupe elementos com características comuns. No Transferegov, use `fieldset` e cor.

#### 4.2.1. Fieldset e Legend

`<fieldset>` acompanhado de `<legend>` agrupa informações mantendo o formulário limpo, com pouco apelo visual. Use-o na maioria dos casos. Ele pode ser combinado com a opção Collapse; consulte o padrão Collapse no DSGov para decidir quando utilizá-lo.

#### 4.2.2. Cor

Use cor quando for necessário, além de agrupar, destacar um conjunto de dados. A cor padrão é `#f8f8f8`, correspondente à variável CSS `--color-secondary-02`.

Ao usar cor de fundo, adote também 32 px de espaçamento ao redor do grupo. Use `p5` para padding interno e `p-sm-2 p-md-4 p-lg-5` para adequação responsiva.

### 4.3. Botões

As operações principais do formulário, como “Salvar”, “Cancelar” e “Encaminhar”, devem ser oferecidas por botões abaixo e à direita do formulário e seguir as diretrizes de alinhamento e espaçamento do componente Button. Botões de ênfase terciária podem ser disponibilizados à direita do formulário.

Operações secundárias podem ser disponibilizadas ao longo do formulário, conforme a necessidade.

Use o componente `<br-button>` do NGX-DSGOV nas variações `primary`, `secondary`, `is-tertiary` e `small circle`.

| ID | Nome | Descrição |
| ---: | --- | --- |
| 1 | Ênfase terciária | Para botões que retroagem ou têm menor importância, como voltar, cancelar e limpar. |
| 2 | Ênfase secundária | Para continuidade que não é a função principal ou exige menos atenção. |
| 3 | Ênfase primária | Para continuidade, como salvar, executar e concluir. |

O documento apresenta exemplo de apresentação de botões no formulário (Imagem 4.3-1).

Veja mais em:

- NGX-DSGov: Buttons.
- DSGov: Button.

#### 4.3.1. Comportamento

A área de botões ao final do formulário deve ser sticky, ficando sempre visível no rodapé. Ao rolar a página para baixo, o conteúdo passa por baixo da área. Nessa situação, o componente NGX apresenta botão adicional para voltar ao topo; ele deve aparecer ao lado dos demais, mais à direita, sem sobrepô-los.

Após uma ação, mantenha o sistema na mesma página se for usual que o usuário faça outras operações no mesmo registro. Quando a ação normalmente conclui o trabalho, navegue para a listagem em que o usuário selecionou o registro.

### 4.4. Ajudas

Disponibilize ajuda junto aos campos sempre que for necessário fornecer informação extra ou esclarecer regra de negócio, reduzindo dúvidas. Use o ícone de interrogação.

- Para texto curto, use tooltip.
- Para texto longo, use modal. Ao passar o mouse sobre o ícone, apresente o texto: “Clique para ver informações de ajuda do campo”.

Não é recomendado usar tooltip com ícone de exclamação para informação extra; avalie somente casos excepcionais.

Veja mais em:

- ngx-dsgov: Tooltip.

### 4.5. Abas e Subabas

Abas (Tabs) organizam o conteúdo de uma página em categorias ou seções e ampliam a usabilidade. Use-as quando:

- Houver excesso de informação em uma única página e for necessário organizar o conteúdo em categorias ou seções menores.
- Forem necessárias para melhorar a usabilidade e a organização dos conteúdos na tela.

O documento apresenta exemplo de abas e subabas (Imagem 4.5-1).

#### 4.5.1. Densidade

Use densidade padrão na maioria dos casos. Em espaços mais restritos, use densidade alta.

Exemplo de densidade alta:

```html
<div class="br-tab small"></div>
```

Exemplo de densidade padrão:

```html
<div class="br-tab"></div>
```

#### 4.5.1. Melhores Práticas

Embora o Design System recomende evitar subabas, os formulários do Transferegov são complexos e, na maioria das vezes, seu uso é necessário.

Use subabas com o componente `br-tab` na horizontal.

Exemplo de uso de abas:

```html
<br-tab-set second-tab>
  <br-tab name="">
    ...
  </br-tab>
</br-tab-set>
```

#### 4.5.2. Componente de Navegação da Esteira de Parcerias

Para padronizar a apresentação das opções de uma parceria e permitir navegação fluida entre módulos, foi criado um componente de abas.

Cada aba pode implementar seu conteúdo em módulo distinto. Ao clicar nela, o sistema recarrega toda a tela e direciona o usuário ao módulo responsável. Visualmente, o usuário percebe um sistema único, pois abas e cabeçalho são recarregados.

Veja mais em:

- Design System > Abas.
- ngx-dsgov > Tabs.
- Esteira de Parcerias > Guia EP-Base-Web > Navegação Parceria.

### 4.6. Listagens em formulários de inclusão e edição

Listagens complexas em formulários de edição e inclusão devem usar o componente de Tabela. A barra de título deve conter ícones de ações utilitárias. Inclusão e pesquisa são as mais comuns; outras ações podem ser disponibilizadas conforme as orientações do Design System.

#### 4.6.1. Opção de Inclusão na Listagem

Use o ícone `fa-plus` na barra de título da tabela para inclusão. Quando acionado, ele pode:

1. Abrir modal com formulário de inclusão.
2. Navegar para nova tela e, após a persistência, voltar à listagem exibindo o registro atualizado.
3. Incluir dados diretamente na tabela por meio de grid editável.

Se o formulário persistir dados, o botão de ação primária deve chamar-se “Salvar”, “Registrar”, “Assinar” ou verbo equivalente. Se não persistir informações, deve chamar-se “Confirmar”.

#### 4.6.3. Opção de Pesquisa

Use o ícone `fa-search`. Ao acioná-lo, o sistema deve apresentar, junto ao cabeçalho da tabela, o formulário de pesquisa com campos de filtro, botões **Pesquisa** e **Limpar** e opção para fechar o formulário.

O documento apresenta exemplo de formulário de pesquisa junto à listagem (Imagem 4.6-1).

## 5. Detalhamento

Para atender ao princípio da transparência, qualquer usuário logado ou não logado pode acessar informações das parcerias, tomando cuidado para ofuscar dados pessoais.

Um formulário de inclusão pode ter formulário correspondente somente leitura, chamado de detalhamento. A necessidade desse modo deve ser discutida com o cliente. Nesse formato, use componentes de label para rótulos e conteúdo dos campos, em vez de componentes de entrada desabilitados.

Se a equipe usar o formulário de edição nesse modo, use o atributo `readonly`, não `disabled`. A equipe do DSGov trabalha para definir a apresentação `readonly` de cada tipo de campo, aproximando-a do padrão visual dos labels, mais legíveis que campos desabilitados e esmaecidos.

Use `disabled` somente quando houver perspectiva de o campo ser habilitado posteriormente, como no caso em que preencher UF habilita o campo Município.

O documento apresenta exemplo de tela de detalhamento (Imagem 5-1).

## 6. Iconografia e Principais Verbos

O Transferegov, como outros sistemas de governo, usa ícones para simbolizar ações, comunicar mudanças de estado entre elementos da interface ou representar graficamente ação ou informação textual.

O DSGov mapeou funcionalidades recorrentes de sistemas governamentais e atribuiu símbolos representativos. O Transferegov adota esse catálogo e o estende para as principais funcionalidades identificadas no sistema.

Além dos ícones, adota-se nomenclatura padrão para as operações:

| Ação e verbo | Quando usar | Classe Font Awesome |
| --- | --- | --- |
| Pesquisar | | `fa-search` |
| Visualizar/Detalhar | | `fa-eye` |
| Editar | | `fa-edit` |
| Excluir | | `fa-trash-alt` |
| Baixar Arquivo/Download | | `fa-download` |
| Subir Arquivo/Upload | | `fa-upload` |
| Limpar | | `fa-eraser` |
| Confirmar | | `fa-check` |
| Fechar | | `fa-times` |
| Incluir | | `fa-plus` |
| Ajuda | | `fa-question` |
| Atualizar | | `fa-sync` |
| Acessar Opções | | `fa-ellipsis-v` |
| Imprimir | `CTRL+P`, imprimir documento usando a impressora. | `fa-print` |
| Emitir | Gera arquivos “imprimíveis”; por exemplo, PDF com recibo de pagamento. | `fa-file-lines` |
| Filtrar | Opção usada junto à tabela. | `fas fa-filter` |
| Copiar | | `fa-copy` |
| Enviar | | `fa-share` |
| Estornar | | `fa-undo-alt` |
| Link externo | | `fa-external-link-alt` |
| Ativar/Reativar | | `fa-check-circle` |
| Inativar | | `fas fa-ban` |
| Exportar no formato CSV | | `fa-file-csv fas` |
| Exportar no formato PDF | | `fa-file-pdf fas` |
| Exportar no formato XLS | | `fa-file-excel fas` |
| Assinar | | `fa-file-signature fas` |
| Cancelar | | `far a-times-circle` |
| Personalizar colunas | | `fa-sliders-h` |
| Voltar | | `fa-chevron-left` |

Cada módulo pode usar verbos próprios de seu subdomínio de negócio, mas deve privilegiar os verbos definidos acima e evitar sinônimos para eles.

Quando for necessário novo ícone, entre em contato com o GT-UX para análise e incorporação ao catálogo.

Veja mais em:

- DSGov: Iconografia.

### 6.1. Tag

Tag é sinalizador que indica status, quantidade ou informação de forma precisa e direta. Use tags para informar, rotular, chamar atenção ou categorizar itens com palavras-chave, ícones ou cores.

No Transferegov, um uso recomendado está em listagens e tabelas, para identificar visualmente diferenças entre dados, como itens ativos/inativos, pendentes/aceitos. Em vez de ícones coloridos, use tags.

Categorias típicas do Transferegov que devem ser representadas por tag, em vez de ícones:

- Repassador / Recebedor.
- Aguardando / Não Iniciado / Em andamento / Encerrado.

#### 6.1.2. Tag em listagens ou tabelas

Em listagens e tabelas, use tag de alta densidade, a mais compacta.

Exemplo:

```html
<span class="br-tag small cor-desejada" aria-describedby="densidade01">
  <span id="densidade01">Alta</span>
</span>
```

Veja mais em:

- Tag.

## 7. Uso de Cores

O DSGov especifica famílias de cores que podem ser utilizadas em pontos específicos das páginas, observando as definições de cada elemento de interface web do Padrão Digital de Governo. Com base nesses princípios, a escolha de cores deve ser coerente com as funcionalidades da tela e congruente em todo o sistema.

No Transferegov, adote as cores padrão dos componentes. Permitem-se mudanças somente para:

- Botões circulares com ênfase terciária.
- Ícones.

### 7.1. Superfícies de Agrupamento (Containers)

Em superfícies de agrupamento, é permitida somente a cor `#f8f8f8`, correspondente à variável CSS `--color-secondary-02`. Superfície de agrupamento é o recurso de destaque descrito na seção 4.2.2, Cor.

Veja mais em:

- DSGov: Cor.

## 8. Apresentação de Acordo com o Tipo de Dado

### 8.1. UF

Quando trabalhar com o campo UF, apresente uma lista somente com as siglas.

### 8.2. Números

Apresente números formatados, usando ponto como separador de milhar e vírgula como separador decimal.

Em tabelas, alinhe campos numéricos à direita e use a mesma formatação em todos os registros da coluna. O título da coluna deve seguir o alinhamento de seu conteúdo.

### 8.3. Valores Monetários

Sempre indique a moeda no rótulo do campo e, em tabelas, no rótulo da coluna de valor monetário.

O documento apresenta valores monetários em modo de edição (Imagem 8.3-1), em apresentação somente leitura (Imagem 8.3-2), em apresentação somente leitura com destaque (Imagem 8.3-3) e em tabela (Imagem 8.3-4).

## 9. Atualização de Versões

Recomenda-se manter Angular, `ngx-dsgov` e componentes da Esteira de Parcerias atualizados para as versões mais recentes. Se houver divergência visual entre componentes, considera-se mais adequada a apresentação da versão mais recente.

Para a implementação do Design System de Governo, recomenda-se utilizar o `ngx-dsgov` disponível em:

- <https://ngx-dsgov-dedat.np.estaleiro.serpro.gov.br/home>

Para problemas ou novas implementações, registre demanda no projeto `ngx-dsgov`:

- <https://git.serpro/component-library/componentes-softwares/ngx-dsgovbr/-/issues>

## 10. Referências

- <https://www.gov.br/ds/home>
- <https://ngx-dsgov-dedat.np.estaleiro.serpro.gov.br/>
- <https://serprogovbr.sharepoint.com/sites/UXCenter/SitePages/Sync.aspx>
- <https://design.gitpages.serpro/rfb/>
- <https://design.gitpages.serpro/rfb/Padroes_de_Interface_Visual_RFB_v1_2.pdf>
- Guia de Interface do Ibama.
- Guia do Ibama.
- Guia de Interface do FGTS.
