%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "calc.tab.h"

%}

%%

[ \t]	; // ignore all whitespace
[0-9]+		{yylval.ival = atoi(yytext); return T_INT;}
\n		{return T_NEWLINE;}
"+"		{return T_PLUS;}
"-"		{return T_MINUS;}
"*"		{return T_MULTIPLY;}
"/"		{return T_DIVIDE;}
"%"     {return T_MOD;}
"("		{return T_LEFT;}
")"		{return T_RIGHT;}
"["     {return T_ArLeft;}
"]"     {return T_ArRight;}
"a"      {return T_Var;}
"="         {return T_Assign;}
"lakoi"		{return T_QUIT;}
"bye"		{return T_QUIT;}
"byeja"		{return T_QUIT;}
"jubjub"	{return T_QUIT;}
%%