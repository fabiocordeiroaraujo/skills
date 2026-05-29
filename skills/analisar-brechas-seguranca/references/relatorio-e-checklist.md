# Referência: Relatório e Checklist de Segurança

Use esta referência ao executar a skill `analisar-brechas-seguranca`.

## Estrutura obrigatória do relatório

```markdown
# Relatório Completo de Segurança - <projeto>

## 1. Resumo Executivo

Descreva o nível geral de exposição do projeto, principais vetores de ataque, principais riscos de vazamento de dados sensíveis e correções prioritárias.

Classifique o risco geral como: Crítico | Alto | Médio | Baixo.

## 2. Tipo de Projeto Identificado

Informe o tipo detectado e as evidências da classificação.

## 3. Escopo e Evidências Analisadas

Liste diretórios, arquivos, módulos, configurações, dependências, endpoints, jobs, filas, integrações, pipelines ou artefatos avaliados. Indique limitações.

## 4. Superfície de Ataque

Liste pontos de entrada relevantes: endpoints HTTP, telas, formulários, filas, consumers, jobs, uploads, downloads, integrações externas, webhooks, comandos internos, arquivos de configuração e APIs públicas ou privadas. Para cada ponto relevante, descreva riscos e controles existentes ou ausentes.

## 5. Mapa de Dados Sensíveis

| Dado sensível | Origem | Onde é processado/persistido | Exposição observada | Controle existente | Risco |
|---|---|---|---|---|---|
| CPF/CNPJ/e-mail/token/etc. | | | | | |

## 6. Vulnerabilidades e Riscos Encontrados

Liste em ordem de criticidade.

### Item <n>: <título>

- **Criticidade:** Crítica | Alta | Média | Baixa
- **Categoria:** SQL Injection | NoSQL Injection | XSS | CSRF | SSRF | IDOR/BOLA | RCE | Path Traversal | Command Injection | Auth | Autorização | CORS | Upload | Logs | Secrets | Dados Sensíveis | Banco de Dados | Mensageria | Dependência | Configuração | Supply Chain | Outro
- **Status:** Confirmado | Provável | Ponto de atenção
- **Localização provável:** arquivo, classe, função, endpoint, fila, job, configuração ou diretório
- **Evidência:** cite o padrão, trecho, configuração ou comportamento observado
- **Descrição:** explique a falha ou exposição encontrada
- **Cenário de exploração ou vazamento:** descreva de forma segura e resumida, sem payloads ou instruções detalhadas
- **Impacto técnico:** explique impacto em confidencialidade, integridade, disponibilidade, aplicação ou infraestrutura
- **Impacto de negócio/LGPD:** explique impacto para usuários, organização, auditoria, privacidade, conformidade ou reputação
- **Como corrigir:** descreva a solução recomendada
- **Exemplo de correção segura:** sugira código, configuração ou ajuste prático quando possível
- **Prioridade:** Imediata | Curto prazo | Médio prazo

## 7. Riscos por Tipo de Ataque

| Tipo de ataque | Risco identificado? | Evidência | Prioridade |
|---|---:|---|---|
| SQL Injection | Sim/Não/Ponto de atenção | | |
| NoSQL Injection | Sim/Não/Ponto de atenção | | |
| Command Injection | Sim/Não/Ponto de atenção | | |
| XSS | Sim/Não/Ponto de atenção | | |
| CSRF | Sim/Não/Ponto de atenção | | |
| SSRF | Sim/Não/Ponto de atenção | | |
| IDOR/BOLA | Sim/Não/Ponto de atenção | | |
| RCE | Sim/Não/Ponto de atenção | | |
| Path Traversal | Sim/Não/Ponto de atenção | | |
| Upload inseguro | Sim/Não/Ponto de atenção | | |
| CORS inseguro | Sim/Não/Ponto de atenção | | |
| Dependências vulneráveis | Sim/Não/Ponto de atenção | | |
| DoS lógico/abuso | Sim/Não/Ponto de atenção | | |

## 8. Riscos por Dados Sensíveis e Privacidade

| Área | Risco identificado? | Evidência | Prioridade |
|---|---:|---|---|
| Logs com dados sensíveis | Sim/Não/Ponto de atenção | | |
| Secrets versionados ou expostos | Sim/Não/Ponto de atenção | | |
| Respostas de API excessivas | Sim/Não/Ponto de atenção | | |
| Dados sensíveis no frontend/browser | Sim/Não/Ponto de atenção | | |
| Banco/cache/filas com retenção inadequada | Sim/Não/Ponto de atenção | | |
| Arquivos/anexos/exports expostos | Sim/Não/Ponto de atenção | | |
| Falta de minimização de dados | Sim/Não/Ponto de atenção | | |
| Falta de expurgo/anonimização | Sim/Não/Ponto de atenção | | |
| Auditoria insuficiente | Sim/Não/Ponto de atenção | | |

## 9. Pontos Positivos Encontrados

Liste controles existentes que reduzem riscos: validação, ORM seguro, guards, autenticação centralizada, prepared statements, sanitização, mascaramento, criptografia, segregação de ambientes, rate limit, auditoria, testes de segurança ou headers.

## 10. Recomendações Prioritárias

### Correções imediatas

### Correções de curto prazo

### Melhorias estruturais

Conectar cada recomendação ao risco encontrado e indicar ganho esperado.

## 11. Checklist de Correção

- [ ] Substituir queries concatenadas por prepared statements ou abstrações seguras.
- [ ] Validar ownership e escopo em endpoints com IDs de recurso.
- [ ] Revisar CORS por ambiente.
- [ ] Adicionar rate limit em endpoints sensíveis.
- [ ] Remover stack traces de respostas públicas.
- [ ] Remover dados sensíveis de logs e aplicar mascaramento.
- [ ] Revisar respostas de API para retornar apenas campos necessários.
- [ ] Validar upload por tipo, tamanho e conteúdo.
- [ ] Proteger downloads e anexos com autorização no backend.
- [ ] Remover secrets hardcoded e mover para cofre de segredos.
- [ ] Definir TTL, expurgo e anonimização para dados sensíveis em banco, cache e filas.
- [ ] Atualizar dependências vulneráveis.
- [ ] Adicionar testes automatizados para autorização e proteção de dados sensíveis.
- [ ] Revisar pipelines, Dockerfiles e artefatos de build para evitar vazamento de credenciais.

## 12. Plano de Validação

Indique testes automatizados, revisão de código, testes manuais seguros, análise de dependências, análise de configuração, varredura de secrets, revisão de logs e evidências esperadas.

## 13. Conclusão

Finalize com avaliação geral, riscos urgentes, riscos de vazamento de dados mais relevantes e próximos passos.
```

## Tratamento por tipo de projeto

- **Backend/API:** controllers, routes, middlewares, filters, guards, interceptors, services, repositories, DTOs, validators, serializers, entidades, auth, queries, integrações externas, filas, logs, erros, configs, documentação de API, health checks e pipelines.
- **Frontend:** rotas, guards, armazenamento local, cookies, service workers, chamadas HTTP, tokens, console logs, HTML dinâmico, validações só no cliente, permissões, dados sensíveis renderizados e dependências do bundle.
- **Mobile:** armazenamento local, logs, deep links, permissões, chamadas HTTP, certificados, pinagem quando aplicável, tokens, cache, biometria, notificações e engenharia reversa quando relevante.
- **Batch/job/worker:** entradas, arquivos, filas, payloads, reprocessamento, comandos, logs, banco, idempotência, retenção, paralelismo, retries e dead letters.
- **Biblioteca/lib:** APIs públicas, funções utilitárias, validação de parâmetros, erros, dependências, logs, secrets e riscos de uso inseguro por consumidores.
- **Gateway/mensageria:** roteamento, auth, tokens, headers, rate limit, políticas por rota, transformação de payloads, logs, retries, dead letters, isolamento e metadados.
- **Monorepo:** analisar módulos separadamente e consolidar riscos críticos, riscos transversais e prioridades por módulo.

## Regras finais

- Não inventar vulnerabilidades ou vazamentos.
- Diferenciar vulnerabilidade confirmada, provável e ponto de atenção.
- Priorizar falhas exploráveis e riscos reais de vazamento de dados sensíveis.
- Citar evidências concretas sempre que possível.
- Evitar recomendações genéricas.
- Considerar OWASP Top 10, API Security Top 10, defesa em profundidade, menor privilégio, autenticação forte, autorização no backend, supply chain, LGPD, minimização, retenção, expurgo, mascaramento, rastreabilidade e auditoria.
- Se o projeto for monorepo, analisar cada módulo e gerar consolidado final.
- Se encontrar dados sensíveis ou secrets reais, mascarar o conteúdo.
- Se encontrar vulnerabilidade crítica, destacar no resumo executivo e marcar prioridade imediata.
