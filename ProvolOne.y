%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "mylib.h"
    #define COMANDO_ENTRADA 1
    #define COMANDO_FINAL 2
    #define COMANDO_ADD 3
    #define COMANDO_ZERO 4
    #define COMANDO_ENQUANTO 5
    #define COMANDO_IGUAL 6
    #define COMANDO_REPETICAO 7
    #define COMANDO_SE 8
    #define COMANDO_SENAO 9
    #define COMANDO_FIM -1
    #define YYDEBUG 1
    int yylex();
    int yyerror(char *s);
    extern FILE *yyin;
    extern int yyparse();
    FILE *output;
    char* varArray[2];
%}

void go_provol(LinkedList *commandos){
    printf("Started provolOne to C\n");
    openFile();
    fprintf(cFile,"#include <stdio.h>\nint main(void) {\n");
    while(commandos != NULL) {
        printf("%d",commandos->comando);
        switch(commandos->comando){
            case COMANDO_ZERO: {
                fprintf(cFile, "%s = 0;\n", commandos->var1);
                break;
            }
            case COMANDO_IGUAL: {
                fprintf(cFile, "%s = %s;\n", commandos->var1,commandos->var2);
                break;
            }
            case COMANDO_ADD: {
                fprintf(cFile,"%s++\n", commandos->var1);
                break;
            }
            case COMANDO_ENTRADA: {
                char *v1 = strtok(commandos->var1, " ");

                while (v1 != NULL){

                    fprintf(cFile, "int %s;\n",v1);
                    fprintf(cFile, "printf(\"Var [%s]: \");\n", v1);
                    fprintf(cFile, "scanf(\"%s\",&%s);\n", "%d", v1);

                    v1 = strtok(NULL, " ");
                }

                char *v2 = strtok(commandos->var2, " ");

                while (v2 != NULL){
                    fprintf(cFile, "int %s = 0;\n", v2);
                    v2 = strtok(NULL, " ");
                }
                break;
            }
            case COMANDO_FINAL: {
                fprintf(cFile, "}");
                break;
            }
            default:
                break;
        }
        commandos = commandos->prox;
    }
    fclose(cFile);
}

%union{
    char name[20];
    int number;
    char* content;
}

%token ENTRADA
%token SAIDA
%token FIM
%token FACA
%token ENQUANTO
%token ZERA
%token INC
%token IGUAL
%token ABREPAR
%token FECHAPAR

%token <name> id
%type <number> program

%type <content> varlist
%type <content> cmds
%type <content> cmd


%%
program: ENTRADA varlist SAIDA varlist cmds FIM {
//         $1       $2     $3     $4    $5   %6

    LinkedList *commandos = (LinkedList *)malloc(sizeof(LinkedList));
    if (commandos == NULL){
        printf("ERROR READING PROGRAM FUNCTION ENTRY\n");
        exit(-1);
    }
    commandos->var1 = $2;
    commandos->var2 = $4;
    commandos->comando = COMANDO_ENTRADA;
    addicionaFimLL(commandos, $5);

    LinkedList *aux = (LinkedList *)malloc(sizeof(LinkedList)); //nao entendi
    if (aux == NULL){
        printf("ERROR READING PROGRAM EXIT ENTRY\n");
    }
    aux->var1 = $4;
    aux->comando = COMANDO_FINAL;
    addicionaFimLL(aux, commandos);

    provolOneToC(commandos);
};

varlist : varlist id {
    char buffer[50];
    snprintf(buffer, 50, "%s %s", $1, $2);
    $$ = buffer;
    }

    | id    {$$ = $1;};

cmds : cmds cmd     { addicionaFimLL($2, $1); $$ = $1; }

    | cmd { $$ = $1;};

cmd : ENQUANTO id FACA cmds FIM {
    LinkedList *commandos = (LinkedList *)malloc(sizeof(LinkedList));
    if (commandos == NULL){
        printf("ERROR READGING COMMAND ENTRY");
        exit(-1);
    }

    commandos->var1 = $2;
    commandos->comando = COMANDO_ENQUANTO;
    addicionaFimLL($4, commandos);

    LinkedList * aux = (LinkedList *)malloc(sizeof(LinkedList));
    if (aux == NULL){
        printf("ERROR READING END ENTRY");
        exit(-1);
    }

    aux->comando = COMANDO_FIM;
    addicionaFimLL(aux, commandos);
    $$ = commandos;
}

    | id IGUAL id {
        LinkedList *commandos = (LinkedList *)malloc(sizeof(LinkedList));

        if (commandos == NULL){
            printf("ERROR READING ATTRIBUTION\n");
            exit(-1);
        }

        commandos->var1 = $1;
        commandos->var2 = $3;
        commandos->comando = COMANDO_IGUAL;
        $$ = commandos;
    }

    | INC ABREPAR id FECHAPAR {
        LinkedList *commandos = (LinkedList*)malloc(sizeof(LinkedList));
        if (commandos == NULL){
            printf("ERROR READING INCREMENT");
            exit(-1);
        }
        commandos->var1 = $3;
        commandos->comando = COMANDO_ADD;
        $$ = commandos;
    }
%%

/*

NAO CRIAR FUNCAO DE ERRO! 
O YACC/BISON JA TEM UMA FUNCAO DE ERRO PROPRIA

eu acho que varlist pode ser interpretada como linked list mas sei la,
    nao tem um jeito mais facil?

*/

int main(int agrc, char* agrs[]){
    
    if(argc != 3){ /* ./compilador entrada.txt saida.txt */
        printf("ERRO: QUANTIDADE DE PARAMETROS INVALIDA, FAVOR INSERIR COMO NO EXEMPLO ABAIXO:\n");
        printf("=>   ./<nome_do_executavel> entrada.txt saida.txt\n");
        return 0;
    }

    /*
    argv[1] --> entrada.txt
    argv[2] --> saida.txt
    */
    printf("BEM VINDO AO COMPILADOR PROVOL-ONE!\n");

    printf("Realizando abertura do arquivo de entrada...");
    
    FILE *input = fopen(argv[1],"r"); //to pensando em trocar pra w+ mas sei la acho que nao precisa
    output = fopen(argv[2],"w");

    if(input == NULL){
        printf(" ERRO\n");
        exit(1);
    }else printf(" OK!\n");
    
    printf("Realizando abertura do arquivo de saida...");
    
    if(output == NULL){
        printf(" ERRO\n");
        exit(1);
    }else printf(" OK!\n");



     
    
    yyin = input
    yyparse();



        descomentar*/
    printf("hello world!\n");

    fclose(input);
    fclose(output);


    return;
}