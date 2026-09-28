# Biblioteca COBOL

Sistema de consulta de livros pelo terminal, desenvolvido em **COBOL** como projeto de estudo. A aplicação permite encontrar um livro por código ou título, consultar seus dados e visualizar sua localização em um mapa ASCII da biblioteca.

O projeto exercita entrada e saída de dados, estruturas de decisão, repetição, organização em parágrafos e manipulação de campos alfanuméricos em COBOL.

## Funcionalidades

- Pesquisa pela combinação de **código e subcódigo**.
- Pesquisa pelo **título completo**, sem diferenciar letras maiúsculas de minúsculas.
- Listagem dos oito livros do catálogo.
- Exibição de título, gênero, código, subcódigo, estante, prateleira e status.
- Mapa ASCII com a estante do livro marcada por `[X]`.
- Rota textual da entrada até a estante e a prateleira.
- Mensagens para opções inválidas e livros não encontrados.

O catálogo é estático e está definido no código-fonte. Esta versão não possui cadastro dinâmico, persistência em arquivos ou banco de dados, nem controle de empréstimos. Todos os livros têm o status `Disponivel`.

## Como usar

Ao executar o programa, escolha uma opção do menu:

```text
1 - Pesquisar por codigo
2 - Pesquisar por titulo
3 - Listar livros cadastrados
0 - Sair
```

Para pesquisar por código, informe os dois campos separadamente: por exemplo, `14` e depois `01`. Preserve os zeros à esquerda dos subcódigos.

Para pesquisar por título, digite o nome completo conforme o catálogo, **sem acentos**. Por exemplo, `o pequeno principe` encontra `O Pequeno Principe`. A pesquisa converte a entrada para maiúsculas, mas não remove acentos nem realiza buscas parciais.

## Catálogo

| Código | Título para pesquisa | Gênero | Estante | Prateleira |
| --- | --- | --- | --- | --- |
| `14-01` | Harry Potter e a Pedra Filosofal | Ficção | E2 | P1 |
| `14-02` | Harry Potter e a Camara Secreta | Ficção | E2 | P2 |
| `14-03` | Harry Potter e o Prisioneiro de Azkaban | Ficção | E2 | P3 |
| `21-01` | O Hobbit | Ficção | E2 | P4 |
| `31-01` | Dom Casmurro | Romance | E3 | P2 |
| `41-01` | Sapiens | História | E5 | P2 |
| `51-01` | Clean Code | Tecnologia | E4 | P1 |
| `61-01` | O Pequeno Principe | Infantil | E1 | P3 |

## Mapa da biblioteca

Exemplo ilustrativo de uma busca por **Clean Code**, localizado na estante `E4`, prateleira `P1`:

```text
+-------------------------------------------------------------------+
|                         MAPA DA BIBLIOTECA                        |
+-------------------------------------------------------------------+
|                              FUNDO                                |
|                                                                   |
| [E1] INFANTIL         [E2] FICCAO           [E3] ROMANCE          |
|                                                                   |
| ----------------------------------------------------------------- |
|                         CORREDOR CENTRAL                          |
| ----------------------------------------------------------------- |
|                                                                   |
| [E4] TECNOLOGIA [X]   [E5] HISTORIA         [E6] ESTUDOS          |
|                                                                   |
| ENTRADA --->                                           [ CAIXA ]  |
+-------------------------------------------------------------------+

[X] = LOCALIZACAO DO LIVRO

ROTA:
ENTRADA -> CORREDOR CENTRAL -> E4 -> P1
```

A estante `E6` aparece no mapa, mas ainda não possui livros no catálogo. A rota é uma orientação textual baseada na localização cadastrada.

## Compilar e executar no Windows

### 1. Instalar o GnuCOBOL pelo MSYS2

Instale o [MSYS2](https://www.msys2.org/) e abra o terminal **MSYS2 UCRT64**. Atualize o ambiente:

```bash
pacman -Syu
```

Se a atualização solicitar o fechamento do terminal, abra novamente o **MSYS2 UCRT64** e repita o comando para concluir a atualização. Esse é o fluxo descrito na [documentação de atualização do MSYS2](https://www.msys2.org/docs/updating/).

Instale o compilador e confira sua disponibilidade:

```bash
pacman -S --needed mingw-w64-ucrt-x86_64-gnucobol
cobc --version
```

O nome do pacote e suas dependências estão disponíveis na [página oficial do GnuCOBOL para MSYS2 UCRT64](https://packages.msys2.org/packages/mingw-w64-ucrt-x86_64-gnucobol).

### 2. Obter o projeto

Clone o repositório com Git e entre na pasta do projeto:

```bash
git clone https://github.com/TWOmendes2/biblioteca-cobol.git
cd biblioteca-cobol
```

Você também pode baixar os arquivos pelo botão **Code → Download ZIP** do GitHub, extraí-los e abrir um terminal na pasta que contém `biblioteca.cob`.

### 3. Compilar no MSYS2 UCRT64

No terminal **MSYS2 UCRT64**, dentro da pasta do projeto:

```bash
cobc -x -free biblioteca.cob -o biblioteca.exe
./biblioteca.exe
```

Se precisar navegar até uma pasta do Windows, use o formato do MSYS2, como `cd "/c/caminho/para/biblioteca-cobol"`. Para uma pasta no disco `D:`, use `/d/`.

### Alternativa: compilar pelo PowerShell

Com o MSYS2 instalado em `C:\msys64`, configure os caminhos na sessão atual do PowerShell:

```powershell
$env:COB_CONFIG_DIR = "C:\msys64\ucrt64\share\gnucobol\config"
$env:COB_COPY_DIR = "C:\msys64\ucrt64\share\gnucobol\copy"
$env:Path = "C:\msys64\ucrt64\bin;$env:Path"

cobc --version
cobc -x -free .\biblioteca.cob -o .\biblioteca.exe

if ($LASTEXITCODE -eq 0) {
    .\biblioteca.exe
}
```

Ajuste `C:\msys64` se escolheu outra pasta de instalação. Essas configurações valem apenas para o terminal atual; repita-as ao abrir uma nova sessão. Execute o programa nesse mesmo ambiente para que as bibliotecas do GnuCOBOL estejam disponíveis.

As opções de compilação são:

| Opção | Finalidade |
| --- | --- |
| `-x` | Gerar um programa executável. |
| `-free` | Ler o código COBOL em formato livre. |
| `-o biblioteca.exe` | Definir o nome do arquivo gerado. |

Consulte o [manual oficial do GnuCOBOL](https://gnucobol.sourceforge.io/doc/gnucobol.html) para detalhes do compilador.

### Solução de problemas

**Erro ao localizar `default.conf` no PowerShell:** confira se o arquivo existe e se `COB_CONFIG_DIR` aponta para a pasta correta:

```powershell
Test-Path "C:\msys64\ucrt64\share\gnucobol\config\default.conf"
```

Se retornar `False`, verifique o diretório de instalação e a instalação do pacote no MSYS2 UCRT64. Se retornar `True`, aplique as variáveis de ambiente mostradas acima antes de compilar.

**Aviso `line not terminated by a newline`:** salve o código com uma quebra de linha após a última instrução. Esse aviso não impede, por si só, a geração do executável.

## Estrutura do projeto

```text
biblioteca-cobol/
|-- biblioteca.cob   # Código-fonte da aplicação
|-- README.md        # Apresentação e instruções de uso
`-- .gitignore       # Exclusão de binários e arquivos temporários
```

## Tecnologias e conceitos

- **COBOL em formato livre:** implementação do sistema.
- **GnuCOBOL:** compilação do código-fonte.
- **MSYS2 UCRT64:** ambiente de ferramentas no Windows.
- **PowerShell:** alternativa para compilar e executar no Windows.
- **Git e GitHub:** versionamento e publicação do projeto.
- **Conceitos praticados:** `WORKING-STORAGE`, campos `PIC X`, condições de nível `88`, `PERFORM`, `EVALUATE`, `ACCEPT`, `DISPLAY` e `FUNCTION UPPER-CASE`.
