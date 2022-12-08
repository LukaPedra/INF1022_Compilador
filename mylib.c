#include <stdio.h>
#include <stdlib.h>

struct linkedlist typedef LinkedList;

struct linkedlist{

    char *var1;
    int comando;
    char *var2;

    LinkedList *prox;
    LinkedList *ant;

};

LinkedList* create_ll(void){
    
    LinkedList* node = (LinkedList*) malloc(sizeof(LinkedList));

    //nao preciso mallocar as variaveis

    return node;
}

void insert_end_ll(LinkedList *node, LinkedList *to_insert){

    while(node->prox != NULL) node = node->prox;
    node->prox = to_insert;
    to_insert->ant = node;

}

void insert_ini_ll(LinkedList *node, LinkedList *to_insert){

    while(node->ant != NULL) node = node->ant;
    to_insert->prox = node;
    node->ant = to_insert;

}