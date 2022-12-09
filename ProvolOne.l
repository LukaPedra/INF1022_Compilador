
%option yywrap
    #include <stdio.h>
    #include "y.tab.h"
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
[a-zA-Z]    {yylval.content =strdup(yytext); return (ID);}
