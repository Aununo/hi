%{
#include "token.h"
_YYLVAL yylval;
%}

DELIM          [\t \n]+
WS             {DELIM}
DIGIT          [0-9]
LETTER 	       [A-Za-z]

%%

(\/\/[^\n]*\n)|(\/\*([^*]|\*+[^\/])*\*+\/)	    { /* noaction */ } 
{WS}+   									    { /* noaction */ } 
-?{DIGIT}+	     							    { yylval.int_value = atoi(yytext); return num_INT; } 
-?0x[0-9a-fA-F]+                                { yylval.int_value = strtol(yytext, NULL, 16); return num_INT; }
-?{DIGIT}+"."{DIGIT}+						    { yylval.float_value = (float)atof(yytext); return num_FLOAT; } 

int											    { return Y_INT; }
float										    { return Y_FLOAT; }
void										    { return Y_VOID; }
const										    { return Y_CONST; }
if										        { return Y_IF; }
else										    { return Y_ELSE; }
while										    { return Y_WHILE; }
break										    { return Y_BREAK; }
continue								        { return Y_CONTINUE; }
return                                          { return Y_RETURN; }

("_"|{LETTER})({DIGIT}|"_"|{LETTER})*           { yylval.id_name = strdup(yytext); return Y_ID; }

"+"											    {return Y_ADD;}
"-"											    {return Y_SUB;}
"*"											    {return Y_MUL;}
"/"											    {return Y_DIV;}
"%"											    {return Y_MODULO;}
"<"											    {return Y_LESS;}
"<="										    {return Y_LESSEQ;}
">"											    {return Y_GREAT;}
">="										    {return Y_GREATEQ;}
"!="										    {return Y_NOTEQ;}
"=="										    {return Y_EQ;}
"!"											    {return Y_NOT;}
"&&"										    {return Y_AND;}
"||"										    {return Y_OR;}
"="											    {return Y_ASSIGN;}
"("											    {return Y_LPAR;}
")"											    {return Y_RPAR;}
"["											    {return Y_LSQUARE;}
"]"											    {return Y_RSQUARE;}
"{"											    {return Y_LBRACKET;}
"}"											    {return Y_RBRACKET;}
","											    {return Y_COMMA;}
";"											    {return Y_SEMICOLON;}

%%