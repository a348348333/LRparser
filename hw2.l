/*定義區*/

%{
	#include <stdio.h>
	#include <string.h>
	#include <ctype.h>
	#include <stdlib.h>
	#include "hw2.tab.h"
%}

/* Regular 定義區和規則區 */  

%%
"="            {return EQ;}
"or"            {return OR;}
"and"           {return AND;}
"true"          {return TRUE;}
"false"         {return FALSE;}
[a-zA-Z0-9]+	{ 
			yylval.str = strdup(yytext);
			return id; 
		}
"("		{ return LQ; }
")"		{ return RQ; } 
[;]		{ return eof; }
[ \t]		;
[\n]		{ return NL;  }
%%
