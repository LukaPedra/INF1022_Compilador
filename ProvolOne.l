%option yywrap
	#include <stdio.h>
	#include "ProvolOne.tab.h"
%%
[0-9]+	{printf("lido %s", yytext);yylval=atoi(yytext); return(NUMBER); }
\n		return(LINEEND)
"+"		return(PLUS)
"/"		return(DIVIDE)
"-"		return(MINUS)
"="		return(EQUAL)
"end"	return(0)
.		