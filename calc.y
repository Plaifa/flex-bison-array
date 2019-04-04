%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
%}

%union {
	int ival;
}

%token<ival> T_INT
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT T_MOD T_ArLeft T_ArRight T_Var
%token T_NEWLINE T_QUIT
%token T_Assign 
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE 

%type<ival> expression

%start calculation

%%

calculation:
	   | calculation line
;

line: T_NEWLINE { printf(">>> ");}
    | expression T_NEWLINE { printf("%i\n>>> ", $1);}
    | T_QUIT T_NEWLINE { exit(0); }
;

expression: T_INT				        { $$ = $1; }
	  | expression T_PLUS expression	{ $$ = $1 + $3; }
	  | expression T_MINUS expression	{ $$ = $1 - $3; }
	  | expression T_MULTIPLY expression{ $$ = $1 * $3; }
      | expression T_DIVIDE expression	{ $$ = $1 / $3; }
	  | expression T_MOD expression		{ $$ = $1 % $3; }
      | T_MINUS expression 	            { $$ = - $2; }
	  | T_LEFT expression T_RIGHT		{ $$ = $2; }
;

array: Tvar T_ArLeft T_INT T_ArRight 	{printf("yay ");} 
	  |  Tvar T_ArLeft T_INT T_ArRight T_Assign T_INT { printf("$$ = $6");}

%%
int main() {
	yyin = stdin;
    printf("Sawaddeeja. ni keu \" pasa karaoke\". version 1.0.0 by 0272 , 0823 , 0874 , 1189\n");
	do {
        printf(">>> ");
		yyparse();
	} while(!feof(yyin));
	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
