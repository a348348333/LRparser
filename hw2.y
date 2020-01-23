/* 初始定義區 */

%{
	#include <stdio.h>
	#include <ctype.h>
	#include <string.h>
	void dumpIDs();//for displaying IDs
	int count = 0;//the number for counting identified IDs
	char * IDS[100];//the gobal variale for variable table
	extern int yylex(void);//including yylex function
	extern int yylineno;
	int yyerror(char *mes);//including debug tools
	extern void exit(int status);//including exit function
%}

/* 保留字定義區 */

%token id//id:string for char * str
%left EQ
%left TRUE FALSE
%left LQ RQ
%left OR AND eof NL
%union {
    char *str;
}

/* 規則定義區 */

%%
Start:	Assignment eof //rule
	{
		//printf("%s\n",yylval.str);
	}
	|Assignment
	{
		dumpIDs();
		exit(0);
	}
	|NL
	{	
		exit(1);
	}
	;
Assignment: id{printf("push lvalue %s\n",yylval.str);IDS[count]=yylval.str;} EQ Expr
	{
		count++;
		printf("=\n");
	}
	;
Expr:	Expr OR Term
	{
		printf("or\n");
	}
	| Term
	;
Term:	Term AND Factor
	{
		printf("and\n");
	}
	| Factor
	;
Factor:	LQ Expr RQ
	| TRUE
	{
		printf("push true\n");
	}
	| FALSE
	{
		printf("push false\n");
	}
	| id
	{
		printf("push rvalue %s\n", yylval.str);
	}
	;

%%

int main()
{	
	while (1)	
	{
		yyparse();
	}
	return 0;
}

//function for displaying with store IDs
void dumpIDs(){
	printf("%%");
	printf("%%");
	printf("IDs:");
		for(int i = 0;i<count-1;i++){
			if(*IDS[i] == *IDS[count - 1]){
				IDS[count - 1] = "";
				count--;
				break;
			}
		}
	for(int i = 0;i<count;i++){
		printf("%s ",IDS[i]);
	}
	printf("\n");
}

int yywrap()
{
	return 1;
}
 
int yyerror(char *mes)
{
	printf("ERROR:%s",mes);
	return 0;
}
