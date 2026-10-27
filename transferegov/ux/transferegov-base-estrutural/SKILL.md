---
name: transferegov-base-estrutural
description: "Aplica o padrao visual Transferegov para base estrutural de aplicacoes: cabecalho, menu principal, rodape, area de links, termo de uso, autenticacao, avatar, vinculos, sticky header e estrutura minima de tela. Use quando o usuario pedir layout Transferegov, casca da aplicacao, header Transferegov, menu lateral, pagina inicial de modulo, base visual, padrao visual Transferegov ou integracao com br-main-layout/br-header/br-side-menu/br-footer."
---

# transferegov base estrutural

## Quando usar

Use esta skill para definir a casca visual de um modulo Transferegov e para revisar se uma tela esta consistente com o cabecalho, menu, rodape, autenticacao e estrutura minima do sistema.

## Guia rapido

Leia:

- `references/cabecalho-menu.md` para cabecalho, menu, autenticacao, avatar e sticky header.
- `references/estrutura-tela.md` para estrutura minima da tela, titulo, conteudo e integracao com layout.

Consulte tambem:

- `ngx-dsgovbr-layout-navegacao` para APIs reais de `br-main-layout`, `br-header`, `br-side-menu`, `br-footer`, breadcrumbs e modelos de menu/usuario.
- `ngx-dsgovbr-instalacao-configuracao` para estilos, scripts, fonte Rawline, locale e dependencias do pacote Angular.

Componentes provaveis:

- `br-main-layout`, `br-header`, `br-side-menu`, `br-footer`, `br-breadcrumbs`.
- Modelos como `Application`, `Menu`, `MenuItem` e `User` devem ser importados de `@serpro/ngx-dsgovbr`.

Exemplo minimo de casca Angular:

```ts
import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { Application, GovBrMainLayoutModule, User } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrMainLayoutModule, RouterOutlet],
  templateUrl: './transferegov-shell.component.html',
})
export class TransferegovShellComponent {
  user?: User;

  application: Application = {
    name: 'Transferegov.br',
    version: 'Modulo 1.0.0',
    menu: {
      itens: [
        { label: 'Inicio', action: '/inicio', icon: 'fas fa-home' },
        { label: 'Consultas', action: '/consultas', icon: 'fas fa-search' },
      ],
    },
    footer: { show: true, theme: '1' },
  };

  sair() {}
}
```

```html
<br-main-layout [application]="application" [user]="user" (logout)="sair()">
  <router-outlet></router-outlet>
</br-main-layout>
```

## Padroes de decisao

- Use a estrutura compartilhada da Esteira de Parcerias quando o projeto ja depender dela; caso contrario, use os componentes de layout do `@serpro/ngx-dsgovbr` e valide a API na skill tecnica.
- O cabecalho deve apresentar identidade Transferegov, versao do modulo, menu, links institucionais e area de autenticacao.
- O menu principal deve abrir pela acao do cabecalho e aparecer sobreposto lateralmente ao conteudo, com densidade media.
- O header deve suportar comportamento sticky reduzido durante rolagem.
- Preserve a sensacao de sistema unico: mudancas entre modulos nao devem parecer produtos independentes.

## Receitas

Para montar uma base de modulo:

1. Configure `application.name` como `Transferegov.br`.
2. Use `application.version` para expor a versao do modulo.
3. Monte `menu.itens` com todos os itens disponiveis para o usuario logado ou acesso livre.
4. Inclua links institucionais: Legislacao e Integracoes.
5. Inclua area de funcionalidades com Termo de Uso quando o modulo exigir.
6. Quando autenticado, apresente avatar/dropdown com vinculos, nome, vinculo selecionado e acao de encerrar sessao.

## Cuidados

- Nao invente API para componentes da Esteira de Parcerias; valide a documentacao do projeto quando usar `ep-layout` ou card de parceria.
- Nao crie menus com densidade alta ou baixa sem justificativa de UX; o guia adota densidade media para o menu Transferegov.

## Validacao

- A tela usa a casca padronizada do modulo.
- Existe apenas um titulo principal no conteudo da tela.
- Cabecalho diferencia estado logado e deslogado.
- Menu abre lateralmente sobre o conteudo e usa densidade media.
- Links de Legislacao, Integracoes e Termo de Uso foram avaliados.
- Imports e modelos reais foram conferidos na skill `ngx-dsgovbr-layout-navegacao`.
