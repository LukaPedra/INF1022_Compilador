#include <stdio.h>
#include "our_provo.tab.h"

%option yywrap /* fala que vai ler de um arquivo*/

/*
    Lucca Vieira Rocha                  >2011342
    João Victor Godinho Woitschach      >2011401
 */
%%
    
ENTRADA     { return ENTRADA;}
SAIDA       { return SAIDA;}
FIM         { return FIM;}
FACA        { return FACA;}
ENQUANTO    { return ENQUANTO;}
ZERA        { return ZERA;}
INC         { return INC;}
"="         { return IGUAL;}
"("         { return ABREPAR;}
")"         { return FECHAPAR;}
[a-zA-Z]    {yylval.sval =strdup(yytext); return (ID);}
