#include <stdio.h>
#include <stdlib.h>

/*
colocar essa main no .y depois
fiz isso aqui pra eu poder ler as letras coloridinhas e testar
    a parte do codigo que depende unicamente de C 

*/


#define PARAMETROS 3 
/*
eu nao me lembro a quantidade de parametros que tem que passar pro programa ja compilado
    (eu acho que é so a entrada e saida)
caso nao seja esse numero, mudar a macro
após certeza do numero de parametros certinho e (possivelmente)
    mudada a macro, deletar este comentario

*/


int main(int argc, char* argv[]){
    
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
    FILE *output = fopen(argv[2],"w");

    if(input == NULL){
        printf(" ERRO\n");
        exit(1);
    }else printf(" OK!\n");
    
    printf("Realizando abertura do arquivo de saida...");
    
    if(output == NULL){
        printf(" ERRO\n");
        exit(1);
    }else printf(" OK!\n");



    /* descomentar 
    
    //yyin = input
    yyparse();



        descomentar*/
    printf("hello world!\n");

    fclose(input);
    fclose(output);


    return 0;
}