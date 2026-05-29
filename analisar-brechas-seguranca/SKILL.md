---
name: analisar-brechas-seguranca
description: Analise segurança de um projeto, módulo ou repositório e produza relatório técnico em Markdown com vulnerabilidades exploráveis, riscos de dados sensíveis, exposição LGPD, OWASP, autenticação, autorização, configurações, dependências, logs, pipelines e recomendações priorizadas. Use quando o usuário pedir auditoria, revisão, análise de brechas, hardening, vazamento de dados, segurança ofensiva/defensiva ou equivalente para um código/projeto.
---

# Analisar Brechas de Segurança

## Objetivo

Atuar como analista de segurança ofensiva, defensiva e de proteção de dados sensíveis. Examinar o projeto informado e produzir um relatório técnico completo, acionável e sustentado por evidências locais.

Nunca inventar vulnerabilidades. Separar achados em `Confirmado`, `Provável` e `Ponto de atenção`. Não incluir payloads ofensivos detalhados nem exploração passo a passo. Se encontrar secrets ou dados sensíveis reais, mascarar o valor e citar apenas tipo e localização.

## Fluxo

1. Identificar o alvo informado pelo usuário: diretório, módulo, aplicação ou repositório.
2. Ler documentação, manifests, configs, estrutura de diretórios, Dockerfiles, pipelines, testes e código suficiente para classificar o tipo principal: backend/API, frontend, mobile, batch/job, worker/consumer, biblioteca, API gateway, mensageria, monorepo ou híbrido.
3. Mapear módulos, camadas, responsabilidades, pontos de entrada e fluxos de dados sensíveis.
4. Adaptar a análise à linguagem, framework e arquitetura detectados. Evitar checklist genérica desconectada do projeto.
5. Procurar evidências de vulnerabilidades e riscos de privacidade usando buscas direcionadas e leitura contextual.
6. Priorizar por impacto, explorabilidade, exposição externa, criticidade do dado e facilidade de correção.
7. Gerar relatório Markdown usando a estrutura em `references/relatorio-e-checklist.md`.

## Evidências Obrigatórias

Sempre que possível, citar arquivos, classes, métodos, funções, endpoints, queries, variáveis, jobs, filas, dependências, configurações, Dockerfiles, pipelines ou diretórios analisados.

Para cada achado, conectar:

- evidência observada;
- cenário seguro e resumido de abuso ou vazamento;
- impacto técnico;
- impacto de negócio/LGPD quando aplicável;
- correção prática aderente ao framework;
- prioridade.

Se a evidência for insuficiente, registrar como ponto de atenção e explicar como confirmar ou descartar o risco.

## Buscas Recomendadas

Usar `rg` e inspeção de arquivos para localizar padrões como:

- entradas externas: routes, controllers, handlers, forms, webhooks, consumers, schedulers, CLIs;
- autenticação e autorização: guards, filters, middleware, roles, scopes, claims, tenants, ownership;
- consultas: SQL concatenado, native queries, query builders dinâmicos, ordenação e filtros vindos do usuário;
- renderização: `innerHTML`, `dangerouslySetInnerHTML`, templates, HTML dinâmico, sanitização;
- SSRF e integrações: clients HTTP, URLs recebidas do usuário, webhooks configuráveis, downloads por URL;
- arquivos: upload, download, paths externos, nomes originais, storage público, anexos e exports;
- execução dinâmica: `exec`, `spawn`, `eval`, reflection, template engines, shell scripts;
- dados sensíveis: CPF, CNPJ, e-mail, telefone, token, password, secret, key, auth, bearer, payload, PII;
- logs e erros: logging de payloads, stack traces, mensagens detalhadas, tracing/APM;
- config e supply chain: `.env`, Dockerfile, CI/CD, lockfiles, versões, secrets, imagens, usuário root.

## Categorias Mínimas

Avaliar, quando aplicável:

- superfície de ataque;
- dados sensíveis e privacidade;
- SQL/NoSQL/LDAP/XPath/template/header/log injection;
- XSS, CSRF, CORS e sessão;
- SSRF e chamadas externas;
- IDOR/BOLA e autorização;
- autenticação, tokens, sessões, rate limit e enumeração;
- upload, download, path traversal e manipulação de arquivos;
- RCE e execução de comandos;
- headers, hardening e configurações web;
- secrets, credenciais e segregação por ambiente;
- comunicação entre sistemas;
- banco, filas, cache e storage;
- logs, auditoria e observabilidade;
- validação de entrada e saída;
- dependências, containers e supply chain;
- indisponibilidade, DoS lógico e abuso de funcionalidades.

## Saída

Gerar um relatório em Markdown claro e completo. Usar a estrutura obrigatória, tabelas e checklist em `references/relatorio-e-checklist.md`.

O relatório deve destacar vulnerabilidades críticas no resumo executivo, apresentar pontos positivos encontrados e encerrar com um plano de validação das correções.
