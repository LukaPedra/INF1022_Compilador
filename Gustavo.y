%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include "llist.h"


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

extern int yylex();
int yyerror(char *s);
extern FILE *yyin;
extern int yyparse();
FILE *cFile;
void openFile(){
    cFile = fopen("Saida.c","w+");
    if (cFile == NULL){
        printf("Ocorreu um erro ao abrir o arquivo");
        exit(-1);
    }
}

void provolOneToC(LLIST *llist){
    printf("Started provolOne to C\n");
    openFile();
    fprintf(cFile,"#include <stdio.h>\nint main(void) {\n");
    while(llist != NULL) {
        printf("%d",llist->line.cmd);
        switch(llist->line.cmd){
            case COMANDO_ZERO: {
                fprintf(cFile, "%s = 0;\n", llist->line.v1);
                break;
            }
            case COMANDO_IGUAL: {
                fprintf(cFile, "%s = %s;\n", llist->line.v1,llist->line.v2);
                break;
            }
            case COMANDO_ADD: {
                fprintf(cFile,"%s++\n", llist->line.v1);
                break;
            }
            case COMANDO_ENTRADA: {
                char *v1 = strtok(llist->line.v1, " ");

                while (v1 != NULL){

                    fprintf(cFile, "int %s;\n",v1);
                    fprintf(cFile, "printf(\"Var [%s]: \");\n", v1);
                    fprintf(cFile, "scanf(\"%s\",&%s);\n", "%d", v1);

                    v1 = strtok(NULL, " ");
                }

                char *v2 = strtok(llist->line.v2, " ");

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
        llist = llist->prox;
    }
    fclose(cFile);
}

void yyparserDebugger(LLIST *llist){
    if (YYDEBUG == 0){
        while (llist != NULL){
            printf("%d [[%s]] [[%s]]\n", llist->line.cmd, llist->line.v1, llist->line.v2);
        }
    }
}

%}

%token ENTRADA
%token SAIDA
%token FIM
%token FACA
%token ENQUANTO
%token ZERA
%token INC
%token ABRE
%token FECHA
%token IGUAL
%token ENTAO
%token <content> ID
%token VEZES
%token SE
%token SENAO

%union{
    int var;
    char *content;
    struct llist *llistvar;
}

%type <var> program
%type <content> varlist
%type <llistvar> cmds
%type <llistvar> cmd

%%

program : ENTRADA varlist SAIDA varlist cmds FIM {
    LLIST *llist = (LLIST *)malloc(sizeof(LLIST));
    if (llist == NULL){
        printf("ERROR READING PROGRAM FUNCTION ENTRY\n");
        exit(-1);
    }
    llist->line.v1 = $2;
    llist->line.v2 = $4;
    llist->line.cmd = COMANDO_ENTRADA;
    addLLISTend(llist, $5);

    LLIST *aux = (LLIST *)malloc(sizeof(LLIST));
    if (aux == NULL){
        printf("ERROR READING PROGRAM EXIT ENTRY\n");
    }
    aux->line.v1 = $4;
    aux->line.cmd = COMANDO_FINAL;
    addLLISTend(aux, llist);

    provolOneToC(llist);
};

varlist : varlist ID {
    char buffer[50];
    snprintf(buffer, 50, "%s %s", $1, $2);
    $$ = buffer;
    }

    | ID    {$$ = $1;};

cmds : cmds cmd     { addLLISTend($2, $1); $$ = $1; }

    | cmd { $$ = $1;};

cmd : ENQUANTO ID FACA cmds FIM {
    LLIST *llist = (LLIST *)malloc(sizeof(LLIST));
    if (llist == NULL){
        printf("ERROR READGING COMMAND ENTRY");
        exit(-1);
    }

    llist->line.v1 = $2;
    llist->line.cmd = COMANDO_ENQUANTO;
    addLLISTend($4, llist);

    LLIST * aux = (LLIST *)malloc(sizeof(LLIST));
    if (aux == NULL){
        printf("ERROR READING END ENTRY");
        exit(-1);
    }

    aux->line.cmd = COMANDO_FIM;
    addLLISTend(aux, llist);
    $$ = llist;
}

    | ID IGUAL ID {
        LLIST *llist = (LLIST *)malloc(sizeof(LLIST));

        if (llist == NULL){
            printf("ERROR READING ATTRIBUTION\n");
            exit(-1);
        }

        llist->line.v1 = $1;
        llist->line.v2 = $3;
        llist->line.cmd = COMANDO_IGUAL;
        $$ = llist;
    }

    | INC ABRE ID FECHA {
        LLIST *llist = (LLIST*)malloc(sizeof(LLIST));
        if (llist == NULL){
            printf("ERROR READING INCREMENT");
            exit(-1);
        }
        llist->line.v1 = $3;
        llist->line.cmd = COMANDO_ADD;
        $$ = llist;
    }
%%
int yyerror(char *s)
{
	printf("Syntax Error on line %s\n", s);
	return 0;
}
int main(int argc, char **argv){

    FILE *provol_code = fopen(argv[1], "r");

    openFile();

    yyin = provol_code;
    yyparse();

    return 0;
    
}
