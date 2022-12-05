%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yylex();
    int yyerror(char *s);
    extern FILE *yyin;
    extern int yyparse();
    FILE *output;
    char* varArray[2];
%}

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

    char* entrada = $2 //

    
    $$ = ""; // $$ == return
}

cmd: 

    id IGUAL id{
    
    printf("DEBUG: %s = %s;\n",$1,$3);
    fprintf(output,"%s = %s;\n",$1,$3);

    } 

    | INC ABREPAR id FECHAPAR{
    
    int buf = $3;
    buf++;
    printf("DEBUG: %s++\n",buf);
    fprintf(output,"%s++\n",buf);

    }

    | ZERA ABREPAR id FECHAPAR{
    
    printf("DEBUG: %s = 0;\n",$3);
    fprintf(output,"%s = 0;\n",$3);

    }

    | ENQUANTO id FACA cmds FIM{
    printf("ESCREVER DEBUG DO WHILE\n");

    char* condicao = $2;
    char* o_queFazer = $4;

    fprintf(output,"while(%s){\n",condicao);
    fprintf(output,"    %s\n",o_queFazer);
    fprintf(output,"}");

};

cmds:

    cmds cmd{
        //nao sei, dar um jeito de implementar recursao
    }

    | cmd{
        $$ = $1; //nao tenho certeza, parece fazer sentido
    };


varlist:

    id varlist{
        //nao sei, dar um jeito de implementar recursao
    }

    | id{
        $$ = $1; //nao tenho certeza, parece fazer sentido
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