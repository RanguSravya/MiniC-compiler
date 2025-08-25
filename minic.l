%{
#include "CS22B044.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h> 
extern int lineno;
void yyerror(const char*);
int lineno=1; // For strdup
%}

%%
"if"            {return IF; }
"else"          { return ELSE; }
"while"         {  return WHILE; }
"for"           { return FOR; }
"int"           { return INT; }
"char"          {return CHAR; }
"float"         { return FLOAT; }
"void"          { return VOID; }
"printf"        { return PRINT; }
"return"        { return RETURN; }
\"[^\"]*\"      {yylval.sval = strdup(yytext);return STRING;}
"=="            { return EQ; }
"!="            { return EQ; }
"<="            {  return EQ; }
">="            { return EQ; }
"<"             {  return EQ; }
">"             { return EQ; }
"**"            { return EXP; }
[\+\-\*\/]             { return *yytext; }
"["             { return *yytext; }
"]"             {  return *yytext; }
"="             {  return *yytext; }
"("             { return *yytext; }
")"             {  return *yytext; }
"{"             { return *yytext; }
"}"             { return *yytext; }
";"             { return *yytext; }
","             { return *yytext; }
[0-9]+          { yylval.ival = atoi(yytext);  return INT_CONST; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.sval = strdup(yytext); return VARNAME; }

[\t\r ]+      { /* Ignore whitespace */ }
[\n] {
    lineno++;

}
.               { yyerror("syntax error"); }

%%

int yywrap() {
    return 1;
}
