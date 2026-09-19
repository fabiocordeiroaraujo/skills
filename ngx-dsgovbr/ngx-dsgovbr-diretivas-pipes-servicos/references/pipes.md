# Pipes publicos

Import:

```ts
import { GovBrPipesModule } from '@serpro/ngx-dsgovbr';
```

## Lista de pipes

| Pipe | Classe | Entrada | Saída |
| --- | --- | --- | --- |
| `CpfCnpj` | `CpfCnpjPipe` | `string` | CPF com `AAA.AAA.AAA-AA` se 11 chars; CNPJ com máscara CNPJ se 14 chars. |
| `cpfCnpj` | `CpfCnpjAliasPipe` | `string` | Alias de `CpfCnpj`; prefira em templates novos. |
| `phone` | `PhonePipe` | `string | number` | Telefone formatado por `PhoneUtils.formatar`. |
| `fileSize` | `FileSizePipe` | bytes `number` | Tamanho legível, usando `formatFileSize`. |
| `join` | `JoinPipe` | `Array<any>` e separador | `input.join(separator)`; retorna `undefined` para input vazio/nulo. |
| `outputMask` | `OutputMaskPipe` | valor e máscara | Aplica máscara de saída, preenchendo com zeros. |
| `stringFormat` | `StringFormatPipe` | template e args | Substitui `{0}`, `{1}`; `{-1}` vira `{`, `{-2}` vira `}`. |
| `stripHtml` | `StripHtmlPipe` | string HTML | Remove tags com regex simples. |
| `zeroEsquerdaMask` | `ZeroEsquerdaPipe` | número, size default `2` | Preenche à esquerda com zeros. |

## Exemplos

```html
<span>{{ pessoa.cpf | cpfCnpj }}</span>
<span>{{ telefone | phone }}</span>
<span>{{ arquivo.size | fileSize }}</span>
<span>{{ perfis | join:', ' }}</span>
<span>{{ codigo | zeroEsquerdaMask:4 }}</span>
<span>{{ 'Olá {0}' | stringFormat:nome }}</span>
```

## Receita completa: pipes em componente standalone

`dados-formatados.component.ts`

```ts
import { Component } from '@angular/core';
import { GovBrPipesModule } from '@serpro/ngx-dsgovbr';

@Component({
  standalone: true,
  imports: [GovBrPipesModule],
  templateUrl: './dados-formatados.component.html',
})
export class DadosFormatadosComponent {
  pessoa = {
    codigo: 42,
    cpf: '12345678909',
    telefone: '61999998888',
    perfis: ['Administrador', 'Gestor'],
  };

  arquivo = { bytes: 2_500_000 };
}
```

`dados-formatados.component.html`

```html
<dl>
  <dt>CPF</dt>
  <dd>{{ pessoa.cpf | cpfCnpj }}</dd>

  <dt>Telefone</dt>
  <dd>{{ pessoa.telefone | phone }}</dd>

  <dt>Anexo</dt>
  <dd>{{ arquivo.bytes | fileSize }}</dd>

  <dt>Perfis</dt>
  <dd>{{ pessoa.perfis | join:', ' }}</dd>

  <dt>Código</dt>
  <dd>{{ pessoa.codigo | zeroEsquerdaMask:6 }}</dd>
</dl>
```

## Cuidados

- `stripHtml` usa regex simples; não trate como sanitizador de segurança.
- `outputMask` é para exibição; para entrada use diretivas como `brInputMask`.
- `CpfCnpj` e `cpfCnpj` coexistem. Evite declarar os dois em exemplos sem necessidade.
