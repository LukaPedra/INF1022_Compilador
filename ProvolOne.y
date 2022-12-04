%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yylex();
    int yyerror(char *s);
    extern FILE *yyin;
    extern int yyparse();
    FILE *outFile;
    char* varArray[2];
%}

%union{
    char name[20];
    int number;
    char* content;
}
