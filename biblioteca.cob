>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. BIBLIOTECA.

ENVIRONMENT DIVISION.

DATA DIVISION.
WORKING-STORAGE SECTION.

*> -------------------------------------------------
*> CONTROLE DO SISTEMA
*> -------------------------------------------------

01 WS-OPCAO               PIC X VALUE SPACE.
01 WS-CODIGO-PESQUISA     PIC X(2) VALUE SPACES.
01 WS-SUBCODIGO-PESQUISA  PIC X(2) VALUE SPACES.
01 WS-TITULO-PESQUISA     PIC X(60) VALUE SPACES.
01 WS-ENCONTRADO          PIC X VALUE "N".

   88 LIVRO-ENCONTRADO    VALUE "S".
   88 LIVRO-NAO-ENCONTRADO VALUE "N".

*> -------------------------------------------------
*> DADOS DO LIVRO ENCONTRADO
*> -------------------------------------------------

01 WS-LIVRO.
   05 WS-TITULO           PIC X(60) VALUE SPACES.
   05 WS-GENERO           PIC X(20) VALUE SPACES.
   05 WS-CODIGO           PIC X(2) VALUE SPACES.
   05 WS-SUBCODIGO        PIC X(2) VALUE SPACES.
   05 WS-ESTANTE          PIC X(2) VALUE SPACES.
   05 WS-PRATELEIRA       PIC X(2) VALUE SPACES.
   05 WS-STATUS           PIC X(15) VALUE SPACES.

*> -------------------------------------------------
*> MARCADORES DO MAPA
*> -------------------------------------------------

01 WS-MARCADOR-E1         PIC X(3) VALUE SPACES.
01 WS-MARCADOR-E2         PIC X(3) VALUE SPACES.
01 WS-MARCADOR-E3         PIC X(3) VALUE SPACES.
01 WS-MARCADOR-E4         PIC X(3) VALUE SPACES.
01 WS-MARCADOR-E5         PIC X(3) VALUE SPACES.
01 WS-MARCADOR-E6         PIC X(3) VALUE SPACES.

PROCEDURE DIVISION.

PRINCIPAL.

    PERFORM UNTIL WS-OPCAO = "0"

        PERFORM MOSTRAR-MENU

        EVALUATE WS-OPCAO

            WHEN "1"
                PERFORM PESQUISAR-POR-CODIGO

            WHEN "2"
                PERFORM PESQUISAR-POR-TITULO

            WHEN "3"
                PERFORM LISTAR-LIVROS

            WHEN "0"
                DISPLAY " "
                DISPLAY "Encerrando o sistema..."

            WHEN OTHER
                DISPLAY " "
                DISPLAY "Opcao invalida."

        END-EVALUATE

    END-PERFORM.

    STOP RUN.

*> =================================================
*> MENU PRINCIPAL
*> =================================================

MOSTRAR-MENU.

    DISPLAY " "
    DISPLAY "==============================================="
    DISPLAY "       SISTEMA DA BIBLIOTECA - COBOL"
    DISPLAY "==============================================="
    DISPLAY " "
    DISPLAY "1 - Pesquisar por codigo"
    DISPLAY "2 - Pesquisar por titulo"
    DISPLAY "3 - Listar livros cadastrados"
    DISPLAY "0 - Sair"
    DISPLAY " "
    DISPLAY "Digite uma opcao:"
    ACCEPT WS-OPCAO.

*> =================================================
*> PESQUISA POR CODIGO
*> =================================================

PESQUISAR-POR-CODIGO.

    DISPLAY " "
    DISPLAY "----------- PESQUISA POR CODIGO --------------"
    DISPLAY " "
    DISPLAY "Digite o codigo do livro:"
    ACCEPT WS-CODIGO-PESQUISA

    DISPLAY "Digite o subcodigo:"
    ACCEPT WS-SUBCODIGO-PESQUISA

    PERFORM BUSCAR-LIVRO.

*> =================================================
*> PESQUISA POR TITULO
*> =================================================

PESQUISAR-POR-TITULO.

    MOVE SPACES TO WS-TITULO-PESQUISA
    MOVE "00" TO WS-CODIGO-PESQUISA
    MOVE "00" TO WS-SUBCODIGO-PESQUISA

    DISPLAY " "
    DISPLAY "------------ PESQUISA POR TITULO --------------"
    DISPLAY " "
    DISPLAY "Digite o titulo:"
    ACCEPT WS-TITULO-PESQUISA

    *> Converte o texto digitado para maiusculo
    MOVE FUNCTION UPPER-CASE(WS-TITULO-PESQUISA)
        TO WS-TITULO-PESQUISA

    EVALUATE WS-TITULO-PESQUISA

        WHEN "HARRY POTTER E A PEDRA FILOSOFAL"
            MOVE "14" TO WS-CODIGO-PESQUISA
            MOVE "01" TO WS-SUBCODIGO-PESQUISA

        WHEN "HARRY POTTER E A CAMARA SECRETA"
            MOVE "14" TO WS-CODIGO-PESQUISA
            MOVE "02" TO WS-SUBCODIGO-PESQUISA

        WHEN "HARRY POTTER E O PRISIONEIRO DE AZKABAN"
            MOVE "14" TO WS-CODIGO-PESQUISA
            MOVE "03" TO WS-SUBCODIGO-PESQUISA

        WHEN "O HOBBIT"
            MOVE "21" TO WS-CODIGO-PESQUISA
            MOVE "01" TO WS-SUBCODIGO-PESQUISA

        WHEN "DOM CASMURRO"
            MOVE "31" TO WS-CODIGO-PESQUISA
            MOVE "01" TO WS-SUBCODIGO-PESQUISA

        WHEN "SAPIENS"
            MOVE "41" TO WS-CODIGO-PESQUISA
            MOVE "01" TO WS-SUBCODIGO-PESQUISA

        WHEN "CLEAN CODE"
            MOVE "51" TO WS-CODIGO-PESQUISA
            MOVE "01" TO WS-SUBCODIGO-PESQUISA

        WHEN "O PEQUENO PRINCIPE"
            MOVE "61" TO WS-CODIGO-PESQUISA
            MOVE "01" TO WS-SUBCODIGO-PESQUISA

        WHEN OTHER
            CONTINUE

    END-EVALUATE

    IF WS-CODIGO-PESQUISA = "00"

        DISPLAY " "
        DISPLAY "Livro nao encontrado."

    ELSE

        PERFORM BUSCAR-LIVRO

    END-IF.

*> =================================================
*> BUSCAR LIVRO
*> =================================================

BUSCAR-LIVRO.

    MOVE "N" TO WS-ENCONTRADO

    EVALUATE TRUE

        *> -----------------------------------------
        *> HARRY POTTER 1
        *> -----------------------------------------

        WHEN WS-CODIGO-PESQUISA = "14"
         AND WS-SUBCODIGO-PESQUISA = "01"

            MOVE "Harry Potter e a Pedra Filosofal"
                TO WS-TITULO

            MOVE "Ficcao"
                TO WS-GENERO

            MOVE "14"
                TO WS-CODIGO

            MOVE "01"
                TO WS-SUBCODIGO

            MOVE "E2"
                TO WS-ESTANTE

            MOVE "P1"
                TO WS-PRATELEIRA

            MOVE "Disponivel"
                TO WS-STATUS

            MOVE "S"
                TO WS-ENCONTRADO

        *> -----------------------------------------
        *> HARRY POTTER 2
        *> -----------------------------------------

        WHEN WS-CODIGO-PESQUISA = "14"
         AND WS-SUBCODIGO-PESQUISA = "02"

            MOVE "Harry Potter e a Camara Secreta"
                TO WS-TITULO

            MOVE "Ficcao"
                TO WS-GENERO

            MOVE "14"
                TO WS-CODIGO

            MOVE "02"
                TO WS-SUBCODIGO

            MOVE "E2"
                TO WS-ESTANTE

            MOVE "P2"
                TO WS-PRATELEIRA

            MOVE "Disponivel"
                TO WS-STATUS

            MOVE "S"
                TO WS-ENCONTRADO

        *> -----------------------------------------
        *> HARRY POTTER 3
        *> -----------------------------------------

        WHEN WS-CODIGO-PESQUISA = "14"
         AND WS-SUBCODIGO-PESQUISA = "03"

            MOVE "Harry Potter e o Prisioneiro de Azkaban"
                TO WS-TITULO

            MOVE "Ficcao"
                TO WS-GENERO

            MOVE "14"
                TO WS-CODIGO

            MOVE "03"
                TO WS-SUBCODIGO

            MOVE "E2"
                TO WS-ESTANTE

            MOVE "P3"
                TO WS-PRATELEIRA

            MOVE "Disponivel"
                TO WS-STATUS

            MOVE "S"
                TO WS-ENCONTRADO

        *> -----------------------------------------
        *> O HOBBIT
        *> -----------------------------------------

        WHEN WS-CODIGO-PESQUISA = "21"
         AND WS-SUBCODIGO-PESQUISA = "01"

            MOVE "O Hobbit"
                TO WS-TITULO

            MOVE "Ficcao"
                TO WS-GENERO

            MOVE "21"
                TO WS-CODIGO

            MOVE "01"
                TO WS-SUBCODIGO

            MOVE "E2"
                TO WS-ESTANTE

            MOVE "P4"
                TO WS-PRATELEIRA

            MOVE "Disponivel"
                TO WS-STATUS

            MOVE "S"
                TO WS-ENCONTRADO

        *> -----------------------------------------
        *> DOM CASMURRO
        *> -----------------------------------------

        WHEN WS-CODIGO-PESQUISA = "31"
         AND WS-SUBCODIGO-PESQUISA = "01"

            MOVE "Dom Casmurro"
                TO WS-TITULO

            MOVE "Romance"
                TO WS-GENERO

            MOVE "31"
                TO WS-CODIGO

            MOVE "01"
                TO WS-SUBCODIGO

            MOVE "E3"
                TO WS-ESTANTE

            MOVE "P2"
                TO WS-PRATELEIRA

            MOVE "Disponivel"
                TO WS-STATUS

            MOVE "S"
                TO WS-ENCONTRADO

        *> -----------------------------------------
        *> SAPIENS
        *> -----------------------------------------

        WHEN WS-CODIGO-PESQUISA = "41"
         AND WS-SUBCODIGO-PESQUISA = "01"

            MOVE "Sapiens"
                TO WS-TITULO

            MOVE "Historia"
                TO WS-GENERO

            MOVE "41"
                TO WS-CODIGO

            MOVE "01"
                TO WS-SUBCODIGO

            MOVE "E5"
                TO WS-ESTANTE

            MOVE "P2"
                TO WS-PRATELEIRA

            MOVE "Disponivel"
                TO WS-STATUS

            MOVE "S"
                TO WS-ENCONTRADO

        *> -----------------------------------------
        *> CLEAN CODE
        *> -----------------------------------------

        WHEN WS-CODIGO-PESQUISA = "51"
         AND WS-SUBCODIGO-PESQUISA = "01"

            MOVE "Clean Code"
                TO WS-TITULO

            MOVE "Tecnologia"
                TO WS-GENERO

            MOVE "51"
                TO WS-CODIGO

            MOVE "01"
                TO WS-SUBCODIGO

            MOVE "E4"
                TO WS-ESTANTE

            MOVE "P1"
                TO WS-PRATELEIRA

            MOVE "Disponivel"
                TO WS-STATUS

            MOVE "S"
                TO WS-ENCONTRADO

        *> -----------------------------------------
        *> PEQUENO PRINCIPE
        *> -----------------------------------------

        WHEN WS-CODIGO-PESQUISA = "61"
         AND WS-SUBCODIGO-PESQUISA = "01"

            MOVE "O Pequeno Principe"
                TO WS-TITULO

            MOVE "Infantil"
                TO WS-GENERO

            MOVE "61"
                TO WS-CODIGO

            MOVE "01"
                TO WS-SUBCODIGO

            MOVE "E1"
                TO WS-ESTANTE

            MOVE "P3"
                TO WS-PRATELEIRA

            MOVE "Disponivel"
                TO WS-STATUS

            MOVE "S"
                TO WS-ENCONTRADO

        WHEN OTHER

            MOVE "N"
                TO WS-ENCONTRADO

    END-EVALUATE

    IF LIVRO-ENCONTRADO

        PERFORM MOSTRAR-RESULTADO
        PERFORM MOSTRAR-MAPA

    ELSE

        DISPLAY " "
        DISPLAY "Livro nao encontrado no catalogo."

    END-IF.

*> =================================================
*> RESULTADO
*> =================================================

MOSTRAR-RESULTADO.

    DISPLAY " "
    DISPLAY "============================================================"
    DISPLAY "                 LIVRO ENCONTRADO"
    DISPLAY "============================================================"
    DISPLAY " "
    DISPLAY "Titulo      : " WS-TITULO
    DISPLAY "Genero      : " WS-GENERO
    DISPLAY "Codigo      : " WS-CODIGO
    DISPLAY "Subcodigo   : " WS-SUBCODIGO
    DISPLAY "Estante     : " WS-ESTANTE
    DISPLAY "Prateleira  : " WS-PRATELEIRA
    DISPLAY "Status      : " WS-STATUS
    DISPLAY " ".

*> =================================================
*> MAPA DA BIBLIOTECA
*> =================================================

MOSTRAR-MAPA.

    MOVE SPACES TO WS-MARCADOR-E1
    MOVE SPACES TO WS-MARCADOR-E2
    MOVE SPACES TO WS-MARCADOR-E3
    MOVE SPACES TO WS-MARCADOR-E4
    MOVE SPACES TO WS-MARCADOR-E5
    MOVE SPACES TO WS-MARCADOR-E6

    EVALUATE WS-ESTANTE

        WHEN "E1"
            MOVE "[X]" TO WS-MARCADOR-E1

        WHEN "E2"
            MOVE "[X]" TO WS-MARCADOR-E2

        WHEN "E3"
            MOVE "[X]" TO WS-MARCADOR-E3

        WHEN "E4"
            MOVE "[X]" TO WS-MARCADOR-E4

        WHEN "E5"
            MOVE "[X]" TO WS-MARCADOR-E5

        WHEN "E6"
            MOVE "[X]" TO WS-MARCADOR-E6

    END-EVALUATE

    DISPLAY " "
    DISPLAY "+-----------------------------------------------------------+"
    DISPLAY "|                  MAPA DA BIBLIOTECA                      |"
    DISPLAY "+-----------------------------------------------------------+"
    DISPLAY "|                                                           |"
    DISPLAY "|                         FUNDO                             |"
    DISPLAY "|                                                           |"
    DISPLAY "| [E1] INFANTIL   " WS-MARCADOR-E1
            "    [E2] FICCAO   " WS-MARCADOR-E2
            "    [E3] ROMANCE " WS-MARCADOR-E3 " |"

    DISPLAY "|                                                           |"
    DISPLAY "| --------------------------------------------------------- |"
    DISPLAY "|                   CORREDOR CENTRAL                        |"
    DISPLAY "| --------------------------------------------------------- |"
    DISPLAY "|                                                           |"

    DISPLAY "| [E4] TECNOLOGIA " WS-MARCADOR-E4
            "    [E5] HISTORIA  " WS-MARCADOR-E5
            "    [E6] ESTUDOS " WS-MARCADOR-E6 " |"

    DISPLAY "|                                                           |"
    DISPLAY "| ENTRADA --->                                  [ CAIXA ]   |"
    DISPLAY "+-----------------------------------------------------------+"

    DISPLAY " "
    DISPLAY "[X] = LOCALIZACAO DO LIVRO"
    DISPLAY " "

    DISPLAY "ROTA:"
    DISPLAY "ENTRADA -> CORREDOR CENTRAL -> "
            WS-ESTANTE " -> " WS-PRATELEIRA

    DISPLAY " ".

*> =================================================
*> LISTAGEM
*> =================================================

LISTAR-LIVROS.

    DISPLAY " "
    DISPLAY "==========================================================="
    DISPLAY "                 LIVROS CADASTRADOS"
    DISPLAY "==========================================================="
    DISPLAY " "
    DISPLAY "14-01 | Harry Potter e a Pedra Filosofal"
    DISPLAY "14-02 | Harry Potter e a Camara Secreta"
    DISPLAY "14-03 | Harry Potter e o Prisioneiro de Azkaban"
    DISPLAY "21-01 | O Hobbit"
    DISPLAY "31-01 | Dom Casmurro"
    DISPLAY "41-01 | Sapiens"
    DISPLAY "51-01 | Clean Code"
    DISPLAY "61-01 | O Pequeno Principe"
    DISPLAY " ".
