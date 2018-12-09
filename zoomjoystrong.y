
%{
//Global and header definitions
#include <stdio.h>
#include "zoomjoystrong.h"
int yyerror(const char* err);
int yylex();
//void set_color(int r, int g, int b);
//void point(int x, int y);
//void line(int x1, int y1, int x2, int y2);
//void circle(int x, int y, int r);
//void rectangle(int x, int y, int w, int h);

%}

/*Declarations*/
%token END
%token END_STATEMENT
%token LINE
%token CIRCLE
%token POINT
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%%
/*Parsing ruleset*/
program:	statement_list END END_STATEMENT
statement_list:	statement
	     |	statement_list statement

statement:	LINE INT INT INT INT END_STATEMENT {if($2<1024 && $3<1024 && $4<768 && $5<768){
									 line($2, $4, $3, $5);}
								else{yyerror("line points out of bounds");};  }
 	|	POINT INT INT END_STATEMENT {if($2<1024 && $3<768){
							point($2, $3);}
							else{yyerror("point points out of bounds");};  }
	|	CIRCLE INT INT INT END_STATEMENT {if($2+$4<1024 && $3+$4<768){
							circle($2, $3, $4);}
							else{yyerror("circle points out of bounds");};  }
	|	RECTANGLE INT INT INT INT END_STATEMENT {if( $2+$4<1024 && $3+$5<768){
								rectangle($2,$3,$4,$5);}
								else{yyerror("rectangle points out of bounds");}; }
	|	SET_COLOR INT INT END_STATEMENT {if($2<225 && $3<225 && $4<225){
							set_color( $2,$3,$4);} 
							else{yyerror("color invalid");};	}
	     

%%

/*Additional c code*/

int main(int argc, char** argv){
	yyparse();
}

int yyerror(const char* err){
	printf("%s \n", err);
}
