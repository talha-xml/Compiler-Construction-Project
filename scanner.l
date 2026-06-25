%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *tok_out;
FILE *err_out;

void print_token(const char *type, const char *lexeme, int lineno) 
{
    fprintf(tok_out, "Line %d: %s → %s\n", lineno, type, lexeme);
    printf("Line %d: %s → %s\n", lineno, type, lexeme);
}

void print_error(const char *lexeme, int lineno, const char *msg) 
{
    fprintf(err_out, "Line %d: ERROR → %s (%s)\n", lineno, lexeme, msg);
    printf("Line %d: ERROR → %s (%s)\n", lineno, lexeme, msg);
}
%}

DIGIT       [0-9]
INT         {DIGIT}+
FRAC        ({DIGIT}+\.[0-9]*|[0-9]*\.[0-9]+)
EXP         ({DIGIT}+(\.[0-9]+)?[eE][+-]?{DIGIT}+)
MALNUM      {DIGIT}+(\.{DIGIT}+){2,} 

ID_START    [A-Za-z_]
ID_CONT     [A-Za-z0-9_]*
IDENT       {ID_START}{ID_CONT}

KEYWORD     (agar|magar|jabtak|mukamal|wapas|likho|padho|kaam|dikhado|rukjao|barhao|ghatao|shuru|khatam|ucp)

ASSIGN_OP   "<-"
POWER_OP    "\\*\\*"
SCOPE_PUNC  "::"
BLOCK_START "@{"
BLOCK_END   "}@"

ADD_OP      "+"
SUB_OP      "-"
MUL_OP      "*"
DIV_OP      "/"
EQ_OP       "=="
LT_OP       "<"
GT_OP       ">"
%%

[ \t\r]+            
\n                    

\/\*([^*]|\*+[^*/])*\*\/ 
\/\/[^\n]*               


\"([^\\\"\n]|\\.)*\"       { print_token("T_STRING", yytext, yylineno); }

\"([^\\\"\n]|\\.)*$       {
    print_error("\"", yylineno, "unclosed string");
}

\'([^\\\']|\\.)\'        { print_token("T_CHAR", yytext, yylineno); }

\'([^\\\'\n]|\\.)*$      {
    print_error("'", yylineno, "unclosed character");
}

{MALNUM}                 { print_error(yytext, yylineno, "malformed number (multiple dots)"); }
{EXP}                    { print_token("T_EXP", yytext, yylineno); }
{FRAC}                   { print_token("T_FLOAT", yytext, yylineno); }
{INT}                    { print_token("T_INT", yytext, yylineno); }

{KEYWORD}                { print_token("T_KEYWORD", yytext, yylineno); }


{ID_START}[A-Za-z0-9_@\$]+[A-Za-z0-9_@\$]* {
    if (strchr(yytext, '@') || strchr(yytext, '$')) {
        print_error(yytext, yylineno, "invalid identifier (contains invalid symbol)");
    } else {
        print_token("T_ID", yytext, yylineno);
    }
}

{IDENT}                  { print_token("T_ID", yytext, yylineno); }

{DIGIT}+{ID_START}{ID_CONT} {
    print_error(yytext, yylineno, "invalid identifier (starts with digit)");
}

{ASSIGN_OP}              { print_token("T_OP_ASSIGN", yytext, yylineno); }
{POWER_OP}               { print_token("T_OP_POWER", yytext, yylineno); }

"++"                     { print_error("++", yylineno, "invalid operator"); }
"--"                     { print_error("--", yylineno, "invalid operator"); }
"$$"                     { print_error("$$", yylineno, "invalid operator"); }

{ADD_OP}                 { print_token("T_OP_ADD", yytext, yylineno); }
{SUB_OP}                 { print_token("T_OP_SUB", yytext, yylineno); }
{MUL_OP}                 { print_token("T_OP_MUL", yytext, yylineno); }
{DIV_OP}                 { print_token("T_OP_DIV", yytext, yylineno); }
{EQ_OP}                  { print_token("T_OP_EQ", yytext, yylineno); }
{LT_OP}                  { print_token("T_OP_LT", yytext, yylineno); }
{GT_OP}                  { print_token("T_OP_GT", yytext, yylineno); }

{SCOPE_PUNC}             { print_token("T_PUNC_SCOPE", yytext, yylineno); }
{BLOCK_START}            { print_token("T_PUNC_BLOCK_START", yytext, yylineno); }
{BLOCK_END}              { print_token("T_PUNC_BLOCK_END", yytext, yylineno); }

";"                      { print_token("T_SEMICOLON", yytext, yylineno); }
","                      { print_token("T_COMMA", yytext, yylineno); }
"("                      { print_token("T_LPAREN", yytext, yylineno); }
")"                      { print_token("T_RPAREN", yytext, yylineno); }

 "\.{2,}"                { print_error(yytext, yylineno, "invalid token (multiple dots)"); }

.                        { print_error(yytext, yylineno, ". unrecognized token"); }

%%

