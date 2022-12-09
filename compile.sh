bison -d ProvolOne.y
flex ProvolOne.l
gcc -c lex.yy.c ProvolOne.tab.c
gcc -o compilador lex.yy.o ProvolOne.tab.o -lfl
