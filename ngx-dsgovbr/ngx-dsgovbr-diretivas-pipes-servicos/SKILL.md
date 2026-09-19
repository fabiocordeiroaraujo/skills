---
name: ngx-dsgovbr-diretivas-pipes-servicos
description: "Aplica, corrige e explica diretivas, pipes, serviços e utilitários públicos de @serpro/ngx-dsgovbr. Use quando o usuário pedir validação CPF/CNPJ, máscaras brInputMask/brReactiveInputMask/brCurrency/brPhoneMask, brNumbersOnly, brUpperCase/brLowerCase, brRemoveAcentos, brFocus, templates br-tpl-*, pipes cpfCnpj/CpfCnpj/phone/fileSize/join/outputMask/stringFormat/stripHtml/zeroEsquerdaMask, DefaultsService, TokenService, AuthGuard, AppendTokenInterceptor, BreadcrumbsService, NotificationService ou serviços de erro."
---

# ngx-dsgovbr diretivas, pipes e servicos

## Quando usar

Use esta skill quando a tarefa não é criar um componente visual inteiro, mas aplicar comportamentos, formatações, validações, serviços transversais ou integrações exportadas pela biblioteca.

## Guia rapido

Leia:

- `references/diretivas.md` para seletores, validações e receita de formulário standalone com diretivas.
- `references/pipes.md` para nomes dos pipes e receita de componente standalone formatando dados.
- `references/servicos.md` para serviços públicos, configuração de interceptor/guard e exemplo de login com `TokenService`.

Exemplo de diretivas e pipes:

`diretivas-pipes.component.ts`

```ts
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { GovBrDirectivesModule, GovBrPipesModule } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [FormsModule, GovBrDirectivesModule, GovBrPipesModule],
  templateUrl: './diretivas-pipes.component.html',
})
export class DiretivasPipesComponent {
  cpf = '';
}
```

`diretivas-pipes.component.html`

```html
<input class="br-input" name="cpf" [(ngModel)]="cpf" brValidCpf brInputMask="999.999.999-99" />
<span>{{ cpf | cpfCnpj }}</span>
```

## Decisoes importantes

- `GovBrDirectivesModule` está marcado como deprecated no código, mas ainda é exportado como agregador; para código novo, prefira imports standalone quando a aplicação suportar.
- Para exemplos de componentes, prefira `templateUrl` e mostre o HTML em arquivo `.component.html`; evite colocar HTML em `template` inline dentro do `.ts`, salvo quando o projeto consumidor já seguir esse padrão.
- Os validadores CPF/CNPJ retornam `invalidCpf`, `invalidCnpj` ou `invalidCpfCnpj` indiretamente via escolha CPF/CNPJ; use os nomes reais nas mensagens.
- `CpfCnpj` e `cpfCnpj` existem; prefira o alias minúsculo em templates novos por consistência.
- Serviços de autenticação (`TokenService`, `AuthGuard`, `AppendTokenInterceptor`) assumem JWT e armazenamento local ou session.
- Quando configurar serviços transversais, mostre também providers/rotas/serviço chamador; não liste apenas o nome do serviço.

## Validacao

Antes de entregar:

- O seletor da diretiva existe exatamente como escrito.
- Pipes foram importados via `GovBrPipesModule` ou por módulo que o inclua.
- Serviços são injetados pelo nome público exportado.
- Diretivas deprecated ou agregadores deprecated foram usados apenas quando isso simplifica compatibilidade.
- Erros e mensagens usam as chaves reais retornadas pelos validadores.
