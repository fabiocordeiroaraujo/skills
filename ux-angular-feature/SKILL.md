---
name: ux-angular-feature
description: "Implementar, estruturar, migrar, integrar ou revisar uma feature de produto no frontend Angular Haggyo preservando os layouts e componentes UX com o padrao tecnico do projeto: NgModule, lazy routes, core/shared/features, Reactive Forms tipado, RxJS, data-access, estados de tela, permissao, acessibilidade, responsividade e testes. Use sempre que o usuario pedir uma nova feature, modulo, fluxo, CRUD, dashboard funcional, integracao com API ou refatoracao de tela de demonstracao em frontend/."
compatibility: Projeto Haggyo em frontend/ com Angular 19, TypeScript 5.8, RxJS 7.8, NgModule, Bootstrap/UX e arquitetura incremental descrita em requirements/tech/03-frontend-angular.md.
---

# UX Angular Feature

## Objetivo

Transformar o template demonstrativo em features Haggyo sustentaveis sem reescrever a aplicacao inteira. Preserve o design e os shells UX aproveitaveis, mas mantenha regra de dominio, acesso a dados, sessao e autorizacao fora dos componentes visuais.

Para escolhas visuais ou de componente, aplique tambem as skills `ux-visual-language`, `ux-layouts-navigation` e `ux-ui-components` quando estiverem disponiveis.

## Antes de codificar

1. Confirme que o alvo e `frontend/`, nao `app/` nem `backend/`.
2. Leia `requirements/tech/03-frontend-angular.md` e `references/arquitetura-e-checklist.md`.
3. Inspecione `package.json`, `app-routing.module.ts`, `app.module.ts`, `shared.module.ts` e uma feature UX equivalente.
4. Identifique contrato da API, capacidades/permissoes, tenant/unidade, estados e viewports da jornada.
5. Diferencie reuso visual de reuso tecnico. Nao promova service/mock de demo para o core do produto.

## Fluxo de implementacao

1. Crie ou evolua a feature no dominio correto em `src/app/features/<dominio>/`.
2. Separe paginas, componentes, data-access, modelos e validators apenas quando houver responsabilidade real.
3. Registre a feature por lazy loading no shell apropriado.
4. Implemente clientes/facades tipados. Componentes consomem operacoes orientadas a UI, nao DTOs crus espalhados.
5. Use estado local no componente e facade/service RxJS para estado compartilhado dentro da feature.
6. Use Reactive Forms tipado e trate validacao de campo, regra do backend e concorrencia.
7. Componha a pagina com layout e componentes UX existentes.
8. Complete loading, vazio, erro, sucesso, conflito e acesso negado conforme o risco.
9. Adicione testes focados em regras, estados, eventos, foco e limite HTTP.
10. Rode build, testes relevantes e verificacao responsiva/acessivel.

## Estrutura recomendada

```text
src/app/features/attendance/
  attendance.module.ts
  attendance-routing.module.ts
  pages/
    attendance-daily-page/
  components/
    attendance-grid/
  data-access/
    attendance-api.service.ts
    attendance.facade.ts
  models/
    attendance-view.model.ts
  validators/
```

Crie somente as pastas necessarias. Uma feature pequena pode comecar com module, routing e page. Evite arquivos vazios, barrels globais e abstracoes sem consumidor.

## Limites de responsabilidade

| Camada | Pode conhecer | Nao deve conhecer |
| --- | --- | --- |
| `core` | sessao, contexto, HTTP, erros, telemetria, config | widget generico ou regra de uma feature |
| `layouts` | shells, menu, header, contexto visual | entidade/endpoint de feature |
| `shared` | UI generica, diretivas, pipes, utilities | endpoint especifico ou entidade Prisma |
| `features` | jornada, modelos de tela, API do dominio | detalhes internos de outra feature |

O backend e a autoridade para autorizacao e resultado oficial. Guard, menu oculto ou botao desabilitado sao controles de experiencia, nao seguranca definitiva.

## Convencoes Angular atuais

- A aplicacao usa `NgModule` e componentes `standalone: false`; mantenha esse padrao em uma feature incremental, salvo migracao explicitamente solicitada.
- Use `@if` e `@for` de forma consistente com Angular 19 quando editar templates modernos.
- Use TypeScript estrito na pratica: interfaces, unions de estado e forms tipados; evite `any`.
- Controle o ciclo de vida de subscriptions. Prefira `async` pipe ou mecanismos Angular atuais adequados ao contexto.
- Importe dependencias no module da feature; nao aumente `SharedModule` para uma necessidade local.
- Registre apenas charts ECharts utilizados para limitar bundle.
- Nao introduza NgRx sem ADR e necessidade transversal comprovada.

## Integracao com API

- Use `HttpClient` e clients tipados por feature.
- Mapeie DTO de transporte para modelo de tela no limite de data-access.
- Trate Problem Details em uma camada central e erros de campo/regra na feature.
- Inclua credenciais/CSRF/correlacao por interceptors do core quando implementados.
- Nao confie em tenant recebido apenas de um header; o backend valida contexto contra a sessao.
- Nunca persista access token ou refresh token em `localStorage`.
- Use debounce e cancelamento em busca; retry automatico somente para operacao idempotente.
- Limpe caches e rascunhos incompativeis em logout ou troca de contexto.

## Qualidade de produto

- Nao misture codigo de demonstracao com rotas publicadas.
- Nao use dados pessoais em URL, log, analytics ou erro apresentado sem necessidade.
- Datas civis e instantes possuem semanticas diferentes; respeite fuso da instituicao.
- Acoes financeiras, documentais ou de matricula devem resistir a envio repetido.
- Acessibilidade minima e WCAG 2.2 AA nas jornadas publicadas.
- Administracao densa privilegia desktop sem quebrar mobile; fluxos de consulta, comunicacao e pagamento priorizam mobile.

## Resultado esperado

Entregue a feature integrada ao shell UX com separacao tecnica clara, estados completos e verificacao proporcional ao risco. No resumo, liste os componentes/padroes UX reutilizados, os pontos de integracao e qualquer lacuna externa real (contrato, permissao ou backend).

## Checklist final

- Feature esta no dominio correto e lazy-loaded.
- Pagina, componente, facade/client e modelo tem limites claros.
- UI reutiliza o catalogo UX sem copiar mocks/anti-padroes.
- Formularios e contratos sao tipados.
- Autorizacao final permanece no backend.
- Sessao/token/dados pessoais nao foram persistidos ou expostos indevidamente.
- Loading, vazio, erro, sucesso, conflito e acesso negado foram avaliados.
- Desktop/mobile e teclado/foco foram verificados.
- Testes cobrem o risco principal.
- `npm run build` passa ou a falha foi relatada com causa.
