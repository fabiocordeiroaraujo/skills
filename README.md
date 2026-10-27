# Repositório de Skills

Coleção de skills reutilizáveis para orientar agentes de IA em tarefas de engenharia de software, segurança, frontend Angular, backend NestJS e aplicação dos padrões visuais DSGov/Transferegov.

Cada skill possui um arquivo `SKILL.md`, que define quando ela deve ser ativada, seu objetivo, o fluxo de trabalho e as regras específicas do domínio. Algumas skills também incluem referências, avaliações, scripts auxiliares e metadados para agentes.

## Visão geral

| Grupo | Skills | Escopo |
| --- | ---: | --- |
| [Gerais](#skills-gerais) | 2 | Segurança, qualidade e manutenção de código |
| [Haggyo](#haggyo) | 8 | Arquitetura e padrões UX do frontend Angular Haggyo |
| [NestJS](#nestjs) | 5 | Clean Architecture e configuração de backends NestJS |
| [ngx-dsgovbr](#ngx-dsgovbr) | 6 | Uso da biblioteca Angular `@serpro/ngx-dsgovbr` |
| [Transferegov](#transferegov) | 7 | Padrões visuais, de interação e de administração de dados do Transferegov |
| **Total** | **28** | |

## Como os grupos se relacionam

- As **skills gerais** podem ser aplicadas transversalmente em qualquer projeto.
- As skills **Haggyo** orientam a construção do frontend do produto, desde a linguagem visual até features e fluxos completos.
- As skills **NestJS** separam domínio, casos de uso, adaptadores e composição de módulos no backend.
- As skills **ngx-dsgovbr** documentam como implementar interfaces Angular usando as APIs reais da biblioteca.
- As skills **Transferegov** definem regras de produto, apresentação e administração de dados. Em tarefas de interface Angular, elas normalmente são combinadas com as skills `ngx-dsgovbr` correspondentes.

## Skills gerais

Skills independentes de um produto ou framework específico.

| Skill | Quando usar |
| --- | --- |
| [`analisar-brechas-seguranca`](analisar-brechas-seguranca/SKILL.md) | Auditorias de segurança em projetos, módulos ou repositórios, incluindo vulnerabilidades exploráveis, dados sensíveis, LGPD, OWASP, autenticação, autorização, dependências, logs e pipelines. Produz um relatório técnico priorizado e baseado em evidências. |
| [`clean-code`](clean-code-v1.0.0/SKILL.md) | Escrita, revisão e refatoração de código com foco em legibilidade e manutenção, aplicando Clean Code, SOLID, tratamento de erros, identificação de code smells, testes e TDD. |

## Haggyo

Conjunto voltado ao frontend Angular do Haggyo. As skills preservam o catálogo visual UX existente, mas orientam sua evolução para código de produto acessível, responsivo, tipado e integrado à arquitetura da aplicação.

O grupo está organizado em três níveis:

1. **Fundamentos:** linguagem visual, componentes, layouts e navegação.
2. **Implementação:** estruturação de uma feature Angular completa.
3. **Padrões de aplicação:** fluxos especializados de calendário, chat, inbox e documentos financeiros.

| Skill | Responsabilidade |
| --- | --- |
| [`ux-visual-language`](haggyo/ux-visual-language/SKILL.md) | Define cores semânticas, tipografia, espaçamento, cards, sombras, bordas, ícones, densidade e regras de SCSS da identidade visual Haggyo. |
| [`ux-ui-components`](haggyo/ux-ui-components/SKILL.md) | Orienta a escolha e implementação de formulários, tabelas, filtros, modais, feedbacks, dashboards, gráficos, estados de tela e demais componentes de interação. |
| [`ux-layouts-navigation`](haggyo/ux-layouts-navigation/SKILL.md) | Organiza shells autenticados ou públicos, sidebar, header, footer, grid, breadcrumbs, rotas lazy e menus condicionados por permissão. |
| [`ux-angular-feature`](haggyo/ux-angular-feature/SKILL.md) | Orquestra features completas em Angular, incluindo módulos, rotas, Reactive Forms, RxJS, data access, permissões, acessibilidade, responsividade e testes. |
| [`ux-app-calendar`](haggyo/ux-app-calendar/SKILL.md) | Adapta o padrão de calendário e agenda: visões temporalizadas, eventos, criação e edição, drag-and-drop, resize, conflitos e fusos. |
| [`ux-app-chat`](haggyo/ux-app-chat/SKILL.md) | Implementa experiências de conversa: contatos, histórico, mensagens em tempo real, composer, anexos, presença, paginação e reconexão. |
| [`ux-app-inbox`](haggyo/ux-app-inbox/SKILL.md) | Implementa comunicação assíncrona em master-detail: categorias, mensagens, leitura, compose, contadores e ações de correspondência. |
| [`ux-app-invoice`](haggyo/ux-app-invoice/SKILL.md) | Implementa documentos financeiros: listagem, status, itens dinâmicos, totais, visualização, edição, impressão e exclusão confirmada. |

Em uma feature nova, `ux-angular-feature` funciona como skill orquestradora e pode ser combinada com as três skills de fundamentos e com um padrão de aplicação adequado à jornada.

## NestJS

Skills para backends NestJS estruturados com Clean Architecture. O objetivo central é manter as regras de negócio independentes de framework, banco de dados e integrações externas.

A direção esperada das dependências é:

```text
controllers e módulos -> casos de uso e portas <- adaptadores externos
                              core
```

| Skill | Responsabilidade |
| --- | --- |
| [`nestjs-clean-core`](nestjs/nestjs-clean-core/SKILL.md) | Modela entidades, value objects, erros, portas e casos de uso em TypeScript independente de NestJS, Prisma ou SDKs externos. |
| [`nestjs-clean-adapters`](nestjs/nestjs-clean-adapters/SKILL.md) | Implementa as portas do core com repositórios Prisma, mappers, Unit of Work, filas, storage e clientes HTTP/gRPC. |
| [`nestjs-clean-modules`](nestjs/nestjs-clean-modules/SKILL.md) | Usa módulos NestJS como composition roots, conectando tokens, adaptadores, casos de uso, controllers, rotas, imports e exports. |
| [`nestjs-clean-feature`](nestjs/nestjs-clean-feature/SKILL.md) | Orquestra uma fatia vertical completa que atravessa core, adaptadores e módulos, como um CRUD, endpoint ou novo fluxo de negócio. |
| [`nestjs-env-config`](nestjs/nestjs-env-config/SKILL.md) | Centraliza variáveis de ambiente com `@nestjs/config`, validação, tipagem, factories, `ConfigService` e `.env.example`. |

Para uma feature completa, comece por `nestjs-clean-feature`. Em alterações isoladas, selecione diretamente a camada afetada: core, adaptadores, módulos ou configuração.

## ngx-dsgovbr

Skills de implementação para aplicações Angular que consomem `@serpro/ngx-dsgovbr`. Elas registram nomes reais de módulos, componentes, diretivas, pipes, serviços, inputs e outputs, reduzindo o risco de uso de APIs inexistentes.

| Skill | Responsabilidade |
| --- | --- |
| [`ngx-dsgovbr-instalacao-configuracao`](ngx-dsgovbr/ngx-dsgovbr-instalacao-configuracao/SKILL.md) | Instala e configura a biblioteca, dependências, registry, estilos, scripts, fonte Rawline, locale e compatibilidade da aplicação. |
| [`ngx-dsgovbr-layout-navegacao`](ngx-dsgovbr/ngx-dsgovbr-layout-navegacao/SKILL.md) | Monta a estrutura da aplicação com main layout, header, footer, side menu, breadcrumbs, tabs, títulos e wizard. |
| [`ngx-dsgovbr-formularios`](ngx-dsgovbr/ngx-dsgovbr-formularios/SKILL.md) | Cria formulários GovBR com inputs, selects, datas, arquivos, checkbox, radio, switch, máscaras, mensagens e validações. |
| [`ngx-dsgovbr-tabelas-listas`](ngx-dsgovbr/ngx-dsgovbr-tabelas-listas/SKILL.md) | Implementa tabelas, paginação, filtros, ordenação, seleção, exportação, listas, cards, accordion e carousel. |
| [`ngx-dsgovbr-feedback-acoes`](ngx-dsgovbr/ngx-dsgovbr-feedback-acoes/SKILL.md) | Implementa alertas, confirmações, modais, loading, onboarding, barra de cookies, painéis de ação, fieldsets e toggles. |
| [`ngx-dsgovbr-diretivas-pipes-servicos`](ngx-dsgovbr/ngx-dsgovbr-diretivas-pipes-servicos/SKILL.md) | Aplica máscaras, validações, formatações, diretivas de comportamento, pipes e serviços transversais de autenticação, breadcrumb, notificação e erros. |

As skills podem ser combinadas por tela. Uma consulta típica, por exemplo, pode usar layout e navegação, formulários para os filtros, tabelas e listas para o resultado e feedback e ações para loading e mensagens.

## Transferegov

Conjunto que traduz os padrões visuais, as convenções de interação e as normas de administração de dados do Transferegov em orientações aplicáveis ao produto. Para tarefas de interface, as skills `ngx-dsgovbr` descrevem como implementar o padrão com a biblioteca Angular.

| Skill | Responsabilidade |
| --- | --- |
| [`transferegov-base-estrutural`](transferegov/transferegov-base-estrutural/SKILL.md) | Define a casca da aplicação: cabeçalho, menu principal, rodapé, autenticação, avatar, vínculos, sticky header e estrutura mínima de tela. |
| [`transferegov-listagens-pesquisa`](transferegov/transferegov-listagens-pesquisa/SKILL.md) | Padroniza consultas, filtros, preservação de estado, tabelas, ordenação, exportação, ações e estados de resultado. |
| [`transferegov-formularios-edicao`](transferegov/transferegov-formularios-edicao/SKILL.md) | Padroniza inclusão e edição com títulos, agrupamentos, fieldsets, botões, ajuda contextual, abas e listas internas. |
| [`transferegov-detalhamento-dados`](transferegov/transferegov-detalhamento-dados/SKILL.md) | Padroniza visualização somente leitura, proteção de dados pessoais, UF, números, moedas, alinhamentos e tags de situação. |
| [`transferegov-cores-containers`](transferegov/transferegov-cores-containers/SKILL.md) | Define cores permitidas, superfícies, containers, espaçamento responsivo, contraste e limites de customização visual. |
| [`transferegov-acoes-iconografia`](transferegov/transferegov-acoes-iconografia/SKILL.md) | Mantém o catálogo de verbos, ícones Font Awesome e posicionamento de ações em botões, tabelas, menus e formulários. |
| [`transferegov-administracao-dados-v1-0`](transferegov/transferegov-administracao-dados-v1-0/SKILL.md) | Aplica as normas de modelagem, nomenclatura de objetos e colunas, auditoria, concorrência, scripts SQL, usuários e privilégios da versão 1.0 do manual de administração de dados. |

Exemplos de composição:

- Uma **tela de pesquisa** pode combinar `transferegov-listagens-pesquisa`, `ngx-dsgovbr-formularios`, `ngx-dsgovbr-tabelas-listas` e `transferegov-acoes-iconografia`.
- Uma **tela de edição** pode combinar `transferegov-formularios-edicao`, `ngx-dsgovbr-formularios`, `ngx-dsgovbr-feedback-acoes` e `transferegov-cores-containers`.
- Uma **tela de consulta somente leitura** pode combinar `transferegov-detalhamento-dados`, `ngx-dsgovbr-diretivas-pipes-servicos` e `ngx-dsgovbr-tabelas-listas`.

## Estrutura de uma skill

Nem todas as skills precisam de todos os diretórios opcionais, mas a organização geral é:

```text
nome-da-skill/
├── SKILL.md              # Instruções principais e gatilhos de uso
├── agents/
│   └── openai.yaml       # Metadados e configuração do agente
├── references/           # Documentação detalhada carregada sob demanda
├── scripts/              # Automações e verificações auxiliares
└── evals/                 # Casos de avaliação da skill
```

O `SKILL.md` deve permanecer curto o suficiente para orientar o fluxo principal. Catálogos extensos, exemplos e documentação específica devem ficar em `references/` e ser carregados apenas quando a tarefa exigir.

## Como escolher uma skill

1. Identifique o domínio principal da tarefa: geral, Haggyo, NestJS, ngx-dsgovbr ou Transferegov.
2. Escolha a skill mais específica para o resultado solicitado.
3. Combine skills quando a tarefa atravessar responsabilidades diferentes.
4. Leia o `SKILL.md` completo e siga as referências indicadas antes de alterar código.
5. Valide o resultado com os testes, builds, scripts ou checklists recomendados pela própria skill.

## Convenções do repositório

- Cada diretório que contém um `SKILL.md` representa uma skill instalável de forma independente; os diretórios de grupo apenas organizam skills relacionadas.
- O campo `name` do frontmatter é o identificador da skill.
- O campo `description` registra tanto a finalidade quanto os gatilhos de ativação.
- Referências devem conter detalhes de domínio; o `SKILL.md` deve concentrar o processo de decisão e execução.
- Nomes de skills especializadas recebem o prefixo do grupo, como `nestjs-`, `ngx-dsgovbr-` e `transferegov-`.
- Alterações devem preservar exemplos verificáveis, links relativos e a separação entre regras de produto e detalhes de implementação.
