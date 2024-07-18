/* CMSC 430 Compiler Theory and Design
   Project 3 Skeleton
   UMGC CITE
   Summer 2023 */

/* This file contains flex input file */

%{
#include <cstdio>
#include <string>
#include <vector>

using namespace std;

#include "values.h"
#include "listing.h"
#include "tokens.h"

int hex_to_int(const string& hex_str); 


%}

%option noyywrap

ws		[ \t\r]+
comment		"//".*\n
comment_2	"--".*\n
line		[\n]
id		[A-Za-z]([A-Za-z0-9])*
digit		[0-9]
hexd		[0-9a-fA-F]
hex		\#[0-9a-fA-F]+
real        	{dec}*\.{dec}+([eE][+-]?{dec}+)?
dec		{digit}+
char		'([^'\\]|\\[btnrf])'
punc		[\(\),:;]
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine(); }
{line}		{ ECHO; nextLine(); }
"+"		{ ECHO; yylval.oper = ADD; return(ADDOP); }
"-"		{ ECHO; yylval.oper = SUBTRACT; return(ADDOP); }
"/"		{ ECHO; yylval.oper = DIVIDE; return(MULOP); }
"%"		{ ECHO; yylval.oper = REMAINDER; return(REMOP); }
"^"		{ ECHO; yylval.oper = EXPONENT; return(EXOP); }
"~"		{ ECHO; yylval.oper = NEGATE; return(NEGOP); }
"|"		{ ECHO; yylval.oper = OR; return(OROP); }
"!"		{ ECHO; yylval.oper = NOT; return(NOTOP); }
"="		{ ECHO; yylval.oper = EQUAL; return(RELOP); }
"<>"		{ ECHO; yylval.oper = NOTEQUAL; return(RELOP); }
">"		{ ECHO; yylval.oper = GREATER; return(RELOP); }
">="		{ ECHO; yylval.oper = GREATEREQUAL; return(RELOP); }
"<="		{ ECHO; yylval.oper = LESSEQUAL;return(RELOP); }
"*"		{ ECHO; yylval.oper = MULTIPLY; return(MULOP); }
"&"		{ ECHO; yylval.oper = AND; return(ANDOP); }
"<"		{ ECHO; yylval.oper = LESS; return(RELOP); }
"=>"		{ ECHO; return(ARROW); }
begin		{ ECHO; return(BEGIN_); }
case		{ ECHO; return(CASE); }
character	{ ECHO; return(CHARACTER); }
end		{ ECHO; return(END); }
endswitch	{ ECHO; return(ENDSWITCH); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
list		{ ECHO; return(LIST); }
of		{ ECHO; return(OF); }
others		{ ECHO; return(OTHERS); }
returns		{ ECHO; return(RETURNS); }
switch		{ ECHO; return(SWITCH); }
when		{ ECHO; return(WHEN); }
else		{ ECHO; return(ELSE); }
elsif		{ ECHO; return(ELSIF); }
endfold		{ ECHO; return(ENDFOLD); }
endif		{ ECHO; return(ENDIF); }
fold		{ ECHO; return(FOLD); }
if		{ ECHO; return(IF); }
left		{ ECHO; return(LEFT); }
real		{ ECHO; return(REAL); }
right		{ ECHO; return(RIGHT); }
then		{ ECHO; return(THEN); }

{id}		{ ECHO; yylval.iden = (CharPtr)malloc(yyleng + 1); 
			strcpy(yylval.iden, yytext); return(IDENTIFIER);}
{dec}		{ ECHO; yylval.value = atoi(yytext); return(INT_LITERAL); }
{char}		{ ECHO; 
		    if (yytext[1] == '\\') {
                         switch (yytext[2]) {
                             case 'b': yylval.value = '\b'; break;
                             case 't': yylval.value = '\t'; break;
                             case 'n': yylval.value = '\n'; break;
                             case 'r': yylval.value = '\r'; break;
                             case 'f': yylval.value = '\f'; break;
                             default: yylval.value = yytext[2]; break;
                    }
                } else {
                    yylval.value = yytext[1];
                }
                return(CHAR_LITERAL); 
            	}
            	
{real}      	{ ECHO; yylval.value = atof(yytext); return(REAL_LITERAL); }
{hex}           { ECHO; yylval.iden = (CharPtr)malloc(yyleng + 1); 
                	strcpy(yylval.iden, yytext + 1); return(HEX_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }
%%

