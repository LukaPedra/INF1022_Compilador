%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>


    int yylex();
    int yyerror(char *s);
    extern FILE *yyin;
    extern int yyparse();
    FILE *output;


%}

%define api.value.type {char *}

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

%token ID

%%
program : ENTRADA varlist SAIDA varlist cmds FIM {

    char *vl1 = $2;
    char *vl2 = $4;

    vl1 = strtok(vl1," ");


    fprintf(output,"#include <stdio.h>\n"
                   "int main(void){\n");



    while(vl1 != NULL){ 
        fprintf(output,"int %s;\n",vl1);
 

        vl1 = strtok(NULL, " ");
    }
    
    fprintf(output,"%s",$5);
    free($5);

    fprintf(output,"return %s;\n}",vl2);

};

cmd: 

    ID IGUAL ID{
    
    char buf[500];

    sprintf(buf,"%s = %s;\n",$1,$3);
    printf("DEBUG: %s = %s;\n",$1,$3);

    $$ = strdup(buf);

    } 

    | INC ABREPAR ID FECHAPAR{
    char buf[500];
    

    printf("DEBUG: %s++;\n",$3);
    sprintf(buf,"%s++;\n",$3);

    $$ = strdup(buf);

    }

    | ZERA ABREPAR ID FECHAPAR{
    
    char buf[500];

    printf("DEBUG: %s = 0;\n",$3);
    sprintf(buf,"%s = 0;\n",$3);

    $$ = strdup(buf);

    }

    | ENQUANTO ID FACA cmds FIM{


    size_t cmds_len = strlen($4);
    size_t cond_len = strlen($2);
    size_t while_len = 15 + cmds_len + cond_len;

    char* condicao = $2;
    char* o_queFazer = $4;

    char *buf = (char*) malloc(sizeof(char)*while_len);

    sprintf(buf,"while(%s){\n%s\n}\n",$2,$4);

    free($2);
    free($4);

    $$ = buf;

};

cmds:

    cmds cmd{
        char *buf = $1;
        size_t cmd_len = strlen($2);
        size_t cmds_len = strlen(buf);
        size_t new_len = cmd_len + cmds_len + 1;
        buf = realloc(buf,new_len);
    
        $$ = strcat(buf,$2);
        free($2);

    } | cmd{

        $$ = $1;

    };

varlist:

    varlist ID{
        char *buf = $1;
        size_t id_len = strlen($2);
        size_t varlist_len = strlen(buf);
        size_t new_len = id_len + varlist_len + 2;
        char *buf2 = realloc(buf,new_len);
        strcat(buf2," ");
    
        $$ = strcat(buf2,$2);
        free($2);
    }

    | ID{
        $$ = $1; //retorna ID
    };

%%

int yyerror(char *s)
{
	printf("%s\n", s);
	return 0;
}

int main(int argc, char* argv[]){
    
    if(argc != 5){
        printf("ERRO: QUANTIDADE DE PARAMETROS INVALIDA, FAVOR INSERIR COMO NO EXEMPLO ABAIXO:\n");
        printf("=>   ./<nome_do_executavel> entrada.txt saida.txt var1 var2\n");
        return 0;
    }

    /*
    argv[1] --> entrada.txt
    argv[2] --> saida.txt
    argv[3] --> valor 1
    argv[4] --> valor 2
    */


    printf("BEM VINDO AO COMPILADOR PROVOL-ONE!\n");
    printf("Realizando abertura do arquivo de entrada...");
    
    FILE *input = fopen(argv[1],"r");
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



    yyin = input;
    yyparse();


    printf("hello world!\n");

    fclose(input);
    fclose(output);


    return 0;
}
