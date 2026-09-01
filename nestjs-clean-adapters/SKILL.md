---
name: nestjs-clean-adapters
description: Implementar, migrar, testar ou revisar adaptadores de saida de uma Clean Architecture em backend NestJS, incluindo repositories Prisma, mappers, Unit of Work, filas, storage e clients HTTP/gRPC que implementam interfaces do core. Use sempre que a tarefa envolver database/, integration/, repository implementation, Prisma mapper, persistencia, provider externo, gateway, mensageria, transacao, concorrencia ou substituicao de fornecedor sem acoplar casos de uso.
---

# NestJS Clean Adapters

## Objetivo

Conectar o core a tecnologia externa sem deixar detalhes externos atravessarem a porta. O adaptador depende do contrato do core e converte tipos, configuracao e falhas nas bordas.

Leia `references/padroes-e-templates.md` antes de criar repositorio, mapper, gateway externo ou Unit of Work.

## Antes de implementar

1. Leia a porta do core e o caso de uso consumidor.
2. Leia schema/SDK e um adaptador vizinho bem testado.
3. Confirme semantica de ausencia, paginacao, ordenacao, concorrencia, retry e idempotencia.
4. Se a porta reflete Prisma/SDK, corrija primeiro o contrato ou reporte o bloqueio arquitetural.

## Repositorio Prisma

- Declare `implements <Port>` para obter verificacao estrutural.
- Mantenha PrismaService, models e filtros Prisma no adaptador.
- Converta persistencia para dominio em mapper explicito (`toDomain`/`toPersistence`).
- Retorne entidade do core, `null` para ausencia contratada e objetos de paginacao tipados.
- Faca ordenacao/filtros externos passarem por whitelist/mapeamento; nao aceite nome de coluna arbitrario.
- Atualize auditoria/versao conforme a convencao existente e converta conflito otimista para erro compreensivel.
- Registre contexto suficiente, sem PII, segredo ou corpo sensivel.

Nao capture excecao para retornar `[]`, `null` ou pagina vazia quando ocorreu indisponibilidade. Isso torna erro tecnico indistinguivel de ausencia real. Relance ou traduza para um erro de infraestrutura que a borda possa tratar.

## Mapper

- Centralize diferencas de nomes, datas, enums, relacionamentos e campos de auditoria.
- Nao retorne um model Prisma como se fosse entidade.
- Trate `null`/`undefined` conscientemente.
- Nao inclua regra de negocio; reconstrua a entidade e deixe invariantes no core.
- Teste ida e volta nos campos que podem perder informacao.

## Integracoes externas

- Implemente a porta do core com uma classe nomeada pelo provider/tecnologia.
- Injete client e configuracao no adaptador, nunca no caso de uso.
- Traduza request/response para tipos do core.
- Defina timeout, retry e idempotencia conforme o protocolo; nao faca retry cego de operacao nao idempotente.
- Preserve erros uteis e remova credenciais/tokens dos logs.
- Isole lifecycle hooks do Nest no adaptador.

## Transacoes

Use Unit of Work apenas para uma operacao atomica real. A porta de transacao pertence ao core e nao importa `Prisma.TransactionIsolationLevel`; exponha opcoes neutras ou uma operacao `execute(work)`.

O adaptador Prisma deve criar repositorios ligados ao mesmo transaction client. Evite estado mutavel compartilhado no singleton entre requisicoes; prefira escopo por callback/contexto.

## Testes

- Mapper: teste unitario puro.
- Repositorio: teste de integracao contra banco controlado ou Prisma mock apenas para branches tecnicos pequenos.
- Gateway: client fake/mock para request, response, timeout e erro.
- Transacao: commit, rollback e uso do mesmo contexto.
- Concorrencia: conflito de versao/unique e traducao esperada.

## Checklist

- A classe implementa uma porta do core.
- Nenhum tipo externo aparece na assinatura da porta.
- O mapper cobre todos os campos relevantes.
- Ausencia e falha tecnica continuam distinguiveis.
- Filtros e ordenacao sao tipados/permitidos.
- Logs nao vazam dados sensiveis.
- Transacao e lifecycle ficam fora do core.
- O modulo de composicao consegue trocar o adaptador sem alterar o caso de uso.
