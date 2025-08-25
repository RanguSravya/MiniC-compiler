%{
#include <stdio.h>
#include <stdlib.h>
#include <bits/stdc++.h>
using namespace std;
extern int yylex();
extern int lineno;
map<string,int>mp;
void yyerror(const char *s) {
    fprintf(stderr, "%d\n", lineno);
    exit(1);
}
%}

%union {
    int ival;
    char *sval;
}

%token <sval> VARNAME


%token <ival> INT_CONST
%token INT CHAR FLOAT VOID RETURN IF ELSE WHILE FOR MAIN STRING PRINT ERROR
%token '+' '-' '*' '/' '=' '(' ')' '{' '}' '[' ']' ';' ','
%token EQ EXP

%left '+' '-'
%left '*' '/'
%right EXP

%type <ival> program declarations function_definitions function_definition type parameter_list parameter declaration expression_statement for_loop if_statement while_loop return_statement expression factor conditional_expression conditional_factor

%%

program: 
    declarations function_definitions
    |
    ;
function_definitions:
    function_definition
    | function_definitions function_definition
    ;

function_definition:
    type VARNAME
    
     '(' parameter_list ')' '{' statements '}'
    ;
declarations:
    declarations declaration
    | 
    ;

declaration:
    type VARNAME
    
     ',' more_ids ';'
    | type VARNAME
    
     ';'
    | type VARNAME
    
     '[' INT_CONST ']' ';'
    | type VARNAME
    
     '[' VARNAME
     
     ']' '[' INT_CONST ']' ';'
    | type VARNAME
    
     '[' INT_CONST ']' '[' VARNAME
     
     ']' ';'
    | type VARNAME
    
     '[' INT_CONST ']' ',' more_ids ';'
    | type VARNAME
    
     '[' VARNAME
     
     ']' ',' more_ids ';'
    | type VARNAME
    
     '[' INT_CONST ']' '[' INT_CONST ']' ';' {mp[$2]=1;}
    | type VARNAME
    
     '[' VARNAME
     
     ']' '[' VARNAME
     
     ']' ';'
    ;
type:
    INT
    | CHAR
    | FLOAT
    | VOID
    ;

more_ids:
     VARNAME
     
      '[' INT_CONST ']'
    | VARNAME
    
     ',' more_ids
    | VARNAME
    
     '[' INT_CONST ']' ',' more_ids
    | VARNAME
    

    ;
parameter_list:
    parameter_list ',' parameter
    | parameter
    | VOID
    |
    ;

parameter:
    type VARNAME
    

    | type VARNAME
    
     '[' INT_CONST ']'
    | type VARNAME
    
     '[' INT_CONST ']' '[' INT_CONST ']'
    ;

statements:
    statements statement
    | statements declaration
    | 
    ;

statement:
    expression_statement
    | compound_statement
    | return_statement
    | function_call ';'
    | if_statement
    | while_loop
    | for_loop
    | print_statement
    |
    ;
expression_statement:
    VARNAME
    
     '=' expression ';'
    | VARNAME
    
     '[' INT_CONST ']' '=' expression ';'
    | VARNAME
    
     '[' INT_CONST ']' '[' INT_CONST ']' '=' expression ';'
    | VARNAME
    
     '[' VARNAME
     
     ']' '[' INT_CONST ']' '=' expression ';'
    | VARNAME
    
     '[' INT_CONST ']' '[' VARNAME
     
     ']' '=' expression ';'
    | VARNAME
    
     '[' VARNAME
     
     ']' '=' expression ';'
    | VARNAME
    
     '[' VARNAME
     
     ']' '[' VARNAME
     
     ']' '=' expression ';'
    | VARNAME
    
     '=' function_call ';'
    | VARNAME
    
     '=' expression
    | ';'
    ;
expression:
    expression '+' factor
    | expression '-' factor
    | expression '*' factor
    | expression '/' factor
    | expression EXP factor
    | factor
    ;

factor:
    VARNAME
    

    | VARNAME
    
     '[' expression ']'
    | VARNAME
    
     '[' expression ']' '[' expression ']'
    | INT_CONST
    | '(' expression ')'
    | function_call
    ;

function_call:
    VARNAME
    
     '(' pass_parameters ')'
    ;

pass_parameters:
    pass_parameter_list
    | VOID
    | 
    ;

pass_parameter_list:
    pass_parameter_list ',' pass_parameter
    | pass_parameter
    ;

pass_parameter:
    expression
    ;

compound_statement:
    '{' statements '}'
    ;

if_statement:
    IF '(' conditional_expression EQ conditional_expression ')' statement
    | IF '(' conditional_expression EQ conditional_expression ')' '{' statement '}'
    | IF '(' conditional_expression EQ conditional_expression ')' statement ELSE statement
    | IF '(' conditional_expression EQ conditional_expression ')' '{' statement '}' ELSE statement
    | IF '(' conditional_expression EQ conditional_expression ')' '{' statement '}' ELSE '{' statement '}'
    ;

while_loop:
    WHILE '(' expression EQ expression ')' '{' statements '}'
    | WHILE '(' expression EQ expression ')' statement
    ;

for_loop: 
      FOR '(' expression_statement conditional_expression EQ conditional_expression ';' expression_statement ')' '{' statements '}'
    | FOR '(' expression_statement conditional_expression EQ conditional_expression ';' expression_statement ')' statement
    ;
conditional_expression:
    conditional_expression '+' conditional_factor
    | conditional_expression '-' conditional_factor
    | conditional_expression '*' conditional_factor
    | conditional_expression '/' conditional_factor
    | conditional_expression EXP conditional_factor
    | conditional_factor
    ;

conditional_factor:
    VARNAME
    

    | VARNAME
    
     '[' conditional_expression ']'{if(mp[$1]==1){yyerror("syntax error");}}
    | VARNAME
    
     '[' conditional_expression ']' '[' conditional_expression ']'
    | INT_CONST
    | '(' conditional_expression ')'
    | function_call
    ;

return_statement:
    RETURN expression ';'
    | RETURN ';'
    ;
print_statement:
    PRINT '(' STRING ')' ';'
    | PRINT '(' STRING ',' VARNAME
    
     ')' ';'
    ;

%%
int main() {
    return yyparse();
}
