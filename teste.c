#include <stdio.h>
#include <stdlib.h>

#define PARAMETROS 3 
/*
eu nao me lembro a quantidade de parametros que tem que passar pro programa ja compilado
    (eu acho que é so a entrada e saida)
caso nao seja esse numero, mudar a macro
após certeza do numero de parametros certinho e (possivelmente)
    mudada a macro, deletar este comentario

*/


int main(int argc, char* args[]){
    
    if(argc != 3){ /* ./compilador entrada.txt saida.txt */
        printf("ERRO: QUANTIDADE DE PARAMETROS INVALIDA, FAVOR INSERIR COMO NO EXEMPLO ABAIXO:\n");
        printf("=>   ./<nome_do_executavel> entrada.txt saida.txt\n");
        return 0;
    }

    

    printf("hello world!\n");


    return 0;
}