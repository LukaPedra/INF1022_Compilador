bison -d ProvolOne.y
flex ProvolOne.l
gcc -c lex.yy.c y.tab.c
gcc -o compilador lex.yy.o y.tab.o -ll