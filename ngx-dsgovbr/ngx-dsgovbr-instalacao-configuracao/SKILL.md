---
name: ngx-dsgovbr-instalacao-configuracao
description: "Instala e configura a biblioteca Angular @serpro/ngx-dsgovbr. Use quando o usuário pedir para instalar, atualizar ou configurar ngx-dsgovbr, ajustar angular.json, importar estilos/scripts GovBR, configurar Rawline, locale pt-BR, Nexus/registry, dependências peer, build da lib ou resolver erros iniciais de uso da biblioteca."
---

# ngx-dsgovbr instalacao e configuracao

## Quando usar

Use esta skill para preparar uma aplicação Angular consumidora de `@serpro/ngx-dsgovbr`, revisar `angular.json`, orientar instalação de dependências, migrar de nomes antigos ou checar se uma app nova está pronta para usar componentes GovBR.

## Guia rapido

Importe componentes a partir do pacote publicado:

```ts
import { GovBrInputModule, GovBrSelectModule } from '@serpro/ngx-dsgovbr';
```

Nao use nomes antigos como `ngx-dsgovbr` sem escopo ou `@govbr/dsgov`.

Para instalação e configuração detalhada, leia:

- `references/instalacao.md` para dependências, registry, compatibilidade, locale e receita completa de aplicação standalone consumidora.
- `references/angular-json.md` para estilos, scripts e assets.

## Regras de precisao

- Confirme no `package.json` da aplicacao que o pacote público é `@serpro/ngx-dsgovbr`; para o alvo destas skills, espere a versao `19.7.19` quando o projeto declarar versao fixa.
- Confirme dependências peer e metadados no `node_modules/@serpro/ngx-dsgovbr/package.json` instalado. Se o pacote ainda nao estiver instalado, use o registry configurado pelo projeto.
- Para exemplos de consumo, prefira imports de módulos `GovBr*Module` ou componentes standalone exportados pelo pacote.
- Para exemplos de componentes, prefira `templateUrl` e mostre o HTML em arquivo `.component.html`; evite colocar HTML em `template` inline dentro do `.ts`, salvo quando o projeto consumidor já seguir esse padrão.
- Ao orientar tabela, select, data, modal, onboarding ou exportação, verifique dependências opcionais citadas em `references/instalacao.md`.
- Alinhe o major Angular, CDK e bibliotecas auxiliares ao que a versao instalada da lib declarar; nao assuma versoes sem conferir o pacote instalado.
- Ao configurar uma aplicação nova, entregue também exemplo de `app.config.ts`/imports de componente quando a pergunta envolver uso inicial da lib.

## Validacao

Antes de entregar código ou instrução de setup, confira:

- O pacote usado é `@serpro/ngx-dsgovbr`.
- `@govbr-ds/core`, Bootstrap, Font Awesome e CSS da lib estão configurados quando necessário.
- `@siemens/ngx-datatable` é usado para tabelas, nao `@swimlane/ngx-datatable`.
- Scripts globais necessários foram adicionados se a aplicação usa componentes dependentes de JS global.
- O locale `pt` foi registrado quando a tela usa datas, moeda ou formatação local.
- O comando `npm run build:lib` só foi citado quando o usuário estiver trabalhando no repositório fonte da biblioteca, nao em uma aplicacao consumidora.
