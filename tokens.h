/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IDENTIFIER = 258,              /* IDENTIFIER  */
    INT_LITERAL = 259,             /* INT_LITERAL  */
    CHAR_LITERAL = 260,            /* CHAR_LITERAL  */
    REAL_LITERAL = 261,            /* REAL_LITERAL  */
    HEX_LITERAL = 262,             /* HEX_LITERAL  */
    ADDOP = 263,                   /* ADDOP  */
    MULOP = 264,                   /* MULOP  */
    ANDOP = 265,                   /* ANDOP  */
    RELOP = 266,                   /* RELOP  */
    NEGOP = 267,                   /* NEGOP  */
    REMOP = 268,                   /* REMOP  */
    EXOP = 269,                    /* EXOP  */
    ARROW = 270,                   /* ARROW  */
    BEGIN_ = 271,                  /* BEGIN_  */
    CASE = 272,                    /* CASE  */
    CHARACTER = 273,               /* CHARACTER  */
    ELSE = 274,                    /* ELSE  */
    END = 275,                     /* END  */
    ENDSWITCH = 276,               /* ENDSWITCH  */
    FUNCTION = 277,                /* FUNCTION  */
    INTEGER = 278,                 /* INTEGER  */
    IS = 279,                      /* IS  */
    LIST = 280,                    /* LIST  */
    OF = 281,                      /* OF  */
    OTHERS = 282,                  /* OTHERS  */
    RETURNS = 283,                 /* RETURNS  */
    SWITCH = 284,                  /* SWITCH  */
    WHEN = 285,                    /* WHEN  */
    OROP = 286,                    /* OROP  */
    NOTOP = 287,                   /* NOTOP  */
    ELSIF = 288,                   /* ELSIF  */
    ENDFOLD = 289,                 /* ENDFOLD  */
    ENDIF = 290,                   /* ENDIF  */
    FOLD = 291,                    /* FOLD  */
    IF = 292,                      /* IF  */
    LEFT = 293,                    /* LEFT  */
    REAL = 294,                    /* REAL  */
    RIGHT = 295,                   /* RIGHT  */
    THEN = 296                     /* THEN  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 39 "parser.y"

	CharPtr iden;
	Operators oper;
	double value;
	vector<double>* list;

#line 112 "parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
