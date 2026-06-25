%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *tok_out;
extern FILE *err_out;

extern int yylex();
extern int yylineno;
extern char *yytext;

void yyerror(const char *s) 
{
    fprintf(stderr, "Line %d: %s\n", yylineno, s);
}
%}

%token T_INT T_FLOAT T_EXP T_ID T_KEYWORD
%token T_OP_ASSIGN T_OP_ADD T_OP_SUB T_OP_MUL T_OP_DIV
%token T_OP_EQ T_OP_LT T_OP_GT
%token T_PUNC_SCOPE T_PUNC_BLOCK_START T_PUNC_BLOCK_END
%token T_SEMICOLON T_COMMA T_LPAREN T_RPAREN
%token T_STRING T_CHAR

%nonassoc LOWER_THAN_ELSE

%%

program:
      START stmt_list END
    ;

START:
      T_KEYWORD
    {
        if(strcmp(yytext, "shuru") != 0)
            yyerror("Expected 'shuru' to start program");
    }
    ;

END:
      T_KEYWORD
    {
        if(strcmp(yytext, "khatam") != 0)
            yyerror("Expected 'khatam' to end program");
    }
    ;

stmt_list:
    | stmt stmt_list
;

stmt:
      T_KEYWORD T_ID T_SEMICOLON
    {
        if(strcmp(yytext,"kaam") != 0 &&
           strcmp(yytext,"likho") != 0 &&
           strcmp(yytext,"padho") != 0)
            yyerror("Unexpected keyword in statement");
    }
    | T_ID T_OP_ASSIGN expression T_SEMICOLON
    | T_KEYWORD T_LPAREN condition T_RPAREN T_PUNC_BLOCK_START stmt_list T_PUNC_BLOCK_END
      optional_else %prec LOWER_THAN_ELSE
    | T_KEYWORD T_LPAREN condition T_RPAREN T_PUNC_BLOCK_START stmt_list T_PUNC_BLOCK_END
;

optional_else:
      T_KEYWORD T_PUNC_BLOCK_START stmt_list T_PUNC_BLOCK_END
    {
        if(strcmp(yytext,"magar") != 0)
            yyerror("Expected 'magar' for else block");
    }
    | 
;

condition:
      expression T_OP_EQ expression
    | expression T_OP_LT expression
    | expression T_OP_GT expression
;

expression:
      T_INT
    | T_FLOAT
    | T_ID
;

%%

int main(int argc, char **argv) 
{
    tok_out = fopen("tokens.txt", "w");
    if (!tok_out) 
    { 
        perror("tokens.txt"); return 1; 
    }
    err_out = fopen("error.txt", "w");
    if (!err_out) 
    { 
        perror("error.txt"); fclose(tok_out); return 1; 
    }

    printf("Parsing, intezar farmaiye...\n");
    int result = yyparse();

    if(result == 0)
        printf("Syntax analysis successful. Parsing was successful\n");
    else
        printf("Syntax analysis failed. Parsing was unsuccessful\n");

    fclose(tok_out);
    fclose(err_out);

    return 0;
}