/* CMSC 430 Compiler Theory and Design
   Project 3 Skeleton
   UMGC CITE
   Summer 2023
   
   Project 3 Parser with semantic actions for the interpreter */

%{

#include <iostream>
#include <cmath>
#include <string>
#include <vector>
#include <map>

using namespace std;

#include "values.h"
#include "listing.h"
#include "symbols.h"

int yylex();
void yyerror(const char* message);
int hex_to_int(const string& hex_str);
double extract_element(CharPtr list_name, double subscript);

Symbols<double> scalars;
Symbols<vector<double>*> lists;
double result;

%}

%define parse.error verbose

%union {
	CharPtr iden;
	Operators oper;
	double value;
	vector<double>* list;
}

%token <iden> IDENTIFIER

%token <value> INT_LITERAL CHAR_LITERAL REAL_LITERAL HEX_LITERAL

%token <oper> ADDOP MULOP ANDOP RELOP NEGOP REMOP EXOP

%token ARROW

%token BEGIN_ CASE CHARACTER ELSE END ENDSWITCH FUNCTION INTEGER IS LIST OF OTHERS
       RETURNS SWITCH WHEN OROP NOTOP ELSIF ENDFOLD ENDIF FOLD IF 
       LEFT REAL RIGHT THEN

%type <value> body statement_ statement cases case expression term primary
	 condition relation elsif_statements elsif_statement

%type <list> list expressions

%%

function:	
	function_header optional_variable  body ';' {result = $3;} ;
	
function_header:	
	FUNCTION IDENTIFIER parameters RETURNS type ';' |
	error ';';

type:
	INTEGER |
	REAL |
	CHARACTER ;
	
optional_variable:
	variable_list | variable |
	%empty ;

variable_list:
	variable |
	variable_list variable ; 
	
variable:	
	IDENTIFIER ':' type IS statement ';' {scalars.insert($1, $5);}; |
	IDENTIFIER ':' LIST OF type IS list ';' {lists.insert($1, $7);} ; 

list:
	'(' expressions ')' {$$ = $2;} ;

parameters: 
	parameter_list |
	%empty ;

parameter_list:
	parameter |
	parameter_list ',' parameter ;

parameter: 
	IDENTIFIER ':' type ;

expressions:
	expressions ',' expression {$1->push_back($3); $$ = $1;} | 
	expression {$$ = new vector<double>(); $$->push_back($1);}

body:
	BEGIN_ statement_ END {$$ = $2;} ;

statement_:
	statement ';' |
	error ';' {$$ = 0;} ;
    
statement:
	expression |
	WHEN condition ',' expression ':' expression {$$ = $2 ? $4 : $6;} |
	SWITCH expression IS cases OTHERS ARROW statement ';' ENDSWITCH |
	IF condition THEN statement_ elsif_statements ELSE statement_ ENDIF
		{$$ = !isnan($4) ? $4 : $7;} ;

elsif_statements: 
	elsif_statement elsif_statements { $$ = $1 ? $1 : $2; }|
	%empty { $$ = 0; } ;  
	
elsif_statement: 
	ELSIF condition THEN statement_ { $$ = $2 ? $4 : 0; } ;

cases:
	cases case {$$ = !isnan($1) ? $1 : $2;} |
	%empty {$$ = NAN;} ;
	
case:
	CASE INT_LITERAL ARROW statement ';' {$$ = $<value>-2 == $2 ? $4 : NAN;} ; 

condition:
	NOTOP condition { $$ = evaluateLogical(0, NOT, $2); } |
	condition ANDOP relation {$$ = $1 && $2;} |
	relation ;

relation:
	expression RELOP expression {$$ = evaluateRelational($1, $2, $3);} |
    	condition ANDOP condition {$$ = evaluateLogical($1, AND, $3);} |
    	condition OROP condition {$$ = evaluateLogical($1, OR, $3);} |
	'(' condition ')' {$$ = $2;} ;

    	
expression:
	expression ADDOP term {$$ = evaluateArithmetic($1, $2, $3);} |
	term ;
      
term:	
	term MULOP primary {$$ = evaluateArithmetic($1, $2, $3);}  |
	term REMOP primary {$$ = evaluateArithmetic($1, $2, $3);} |
	primary ;

primary:
	
	term EXOP primary {$$ = evaluateArithmetic($1, $2, $3);} |
	'(' expression ')' {$$ = $2;} |
	INT_LITERAL  | 
	CHAR_LITERAL |
	REAL_LITERAL |
	HEX_LITERAL  |
	IDENTIFIER '(' expression ')' {$$ = extract_element($1, $3); } |
	IDENTIFIER {if (!scalars.find($1, $$)) appendError(UNDECLARED, $1);} |
	NEGOP primary {$$ = evaluateArithmetic(0, NEGATE, $2);} ;

%%

void yyerror(const char* message) {
	appendError(SYNTAX, message);
}

double extract_element(CharPtr list_name, double subscript) {
	vector<double>* list; 
	if (lists.find(list_name, list))
		return (*list)[subscript];
	appendError(UNDECLARED, list_name);
	return NAN;
}

int hex_to_int(const string& hex_str) {
    int result = 0;
    size_t len = hex_str.length();

    for (size_t i = 0; i < len; ++i) {
        char c = hex_str[i];
        int value = 0;

        if (c >= '0' && c <= '9') {
            value = c - '0';
        } else if (c >= 'a' && c <= 'f') {
            value = c - 'a' + 10;
        } else if (c >= 'A' && c <= 'F') {
            value = c - 'A' + 10;
        }

        result = result * 16 + value;
    }

    return result;
}

int main(int argc, char *argv[]) {
	firstLine();
	yyparse();
	if (lastLine() == 0)
		cout << "Result = " << result << endl;
	return 0;
} 
