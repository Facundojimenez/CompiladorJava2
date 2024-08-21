package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.ParserSym;
import lyc.compiler.model.*;
import static lyc.compiler.constants.Constants.*;

%%

%public
%class Lexer
%unicode
%cup
%line
%column
%throws CompilerException
%eofval{
  return symbol(ParserSym.EOF);
%eofval}

// Nota facu:
/*
  Los profes definieron 2 tipos de funciones para retornar tokens:
  1) symbol(nombre_token) -> Se usa para definir un token estandar que tiene lexema unico. Ej: OP_ASIG, PAR_ABRE, OP_IGUAL
  2) symbol(nombre_token, lexema) -> Se usa para definir tokens como ID o CTE, donde tienen varios lexemas para un mismo token. Luego ese valor del lexema deberia guardarse en la tabla de simbolos

  Adicionalmente, estas funciones añaden automaticamente el nro de linea y el numero de columna en donde se levantó el token (se calcula sólo). 
*/


%{
  //symbol(nombre_token)
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }

  //symbol(nombre_token, lexema)
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

/* ----------------------- CONJUNTOS ÚTILES (se usan para facilitar la creación de otras REGEX) ----------------------- */

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
Identation =  [ \t\f]

Letter = [a-zA-Z]
Digit = [0-9]

/* ----------------------- OPERADORES ARITMETICOS -----------------------*/

Plus = "+"
Mult = "*"
Sub = "-"
Div = "/"
Assig = "="

/* ------------------------ OPERADORES LOGICOS -------------------------- */

Equal = "=="
NotEqual = "!="
GreaterThan = ">"
GreaterEqualThan = ">="
LessThan = "<"
LessEqual = "<="

/* ------------------------ TOKEN DE BLOQUES Y AGRUPAMIENTO ------------- */

OpenBracket = "("
CloseBracket = ")"
OpenSquareBracket = "["
CloseSquareBracket = "]"
OpenCurlyBracket = "{"
CloseCurlyBracket = "}"

/* ------------------------ PALABRAS RESERVADAS ------------- */

If = "if"
Else = "else"
While = "while"
For = "for"
Abstract = "abstract"
Int = "int"
Double = "double"
New = "new"
Default = "default"
Boolean = "boolean"
Do = "do"
Private = "private"
This = "this"
Break = "break"
Throw = "throw"
Public = "public"
Case = "case"



/* ------------------------ OTROS TOKENS ------------------- */

Identifier = {Letter} ({Letter}|{Digit})*
IntegerConstant = {Digit}+

/* ----------------------- Elementos que se detectan pero NO producen TOKENS ------------------- */

WhiteSpace = {LineTerminator} | {Identation}
Comment = "/*"({Letter}|{Digit})*"*/"

%%

/* 
  Nota Facu:

  A partir de aca abajo tenemos que definir la acción léxica asocioda a cada REGEX reconocida por el lexer.
  Dentro de cada acción léxica vamos a validar el token (en caso de ser necesario, como en el caso de los IDs o CTE) y vamos a devolver el token.
  Los tokens que se devuelven tienen que estar definidos SI O SI en el archivo "parser.cup", si no les va a funcionar.

  En caso de que una validación de un token falle (supongamos CTE_ID fuera de rango) arrojamos una excepción y NO retornamos el token.

*/

/* keywords */

<YYINITIAL> {

	/* ------------------------ PALABRAS RESERVADAS (van SIEMPRE arriba de ID o CTE porque tienen mayor prioridad de ser detectadas primero) ------------- */

	{If}                                    		{ return symbol(ParserSym.IF); }
	{Else}                                    	{ return symbol(ParserSym.ELSE); }
	{While}                                   	{ return symbol(ParserSym.WHILE); }
	{For}                                    	{ return symbol(ParserSym.FOR); }


  /* -------------------------  identifiers ------------------------- */
  {Identifier}                             { return symbol(ParserSym.IDENTIFIER, yytext()); }

  /* ------------------------- Constants ------------------------- */
  {IntegerConstant}                        { return symbol(ParserSym.INTEGER_CONSTANT, yytext()); }

  /* ----------------------- OPERADORES ARITMETICOS -----------------------*/
  {Plus}                                    { return symbol(ParserSym.PLUS); }
  {Sub}                                     { return symbol(ParserSym.SUB); }
  {Mult}                                    { return symbol(ParserSym.MULT); }
  {Div}                                     { return symbol(ParserSym.DIV); }
  {Assig}                                   { return symbol(ParserSym.ASSIG); }

  /* ------------------------ OPERADORES LOGICOS -------------------------- */
  {Equal}                                       { return symbol(ParserSym.EQUAL); }
  {NotEqual}                                    { return symbol(ParserSym.NOT_EQUAL); }
  {GreaterThan}                                 { return symbol(ParserSym.GREATER_THAN); }
  {GreaterEqualThan}                            { return symbol(ParserSym.GREATER_THAN_EQUAL); }
  {LessThan}                                    { return symbol(ParserSym.LESS_THAN); }
  {LessEqual}                                   { return symbol(ParserSym.LESS_THAN_EQUAL); }


  /* ------------------------ TOKEN DE BLOQUES Y AGRUPAMIENTO ------------- */
  {OpenBracket}                             { return symbol(ParserSym.OPEN_BRACKET); }
  {CloseBracket}                            { return symbol(ParserSym.CLOSE_BRACKET); }
  {OpenSquareBracket}                            { return symbol(ParserSym.OPEN_SQUARE_BRACKET); }
  {CloseSquareBracket}                            { return symbol(ParserSym.CLOSE_SQUARE_BRACKET); }
  {OpenCurlyBracket}                            { return symbol(ParserSym.OPEN_CURLY_BRACKET); }
  {CloseCurlyBracket}                            { return symbol(ParserSym.CLOSE_CURLY_BRACKET); }



  /* ----------------------- Elementos que se detectan pero NO producen TOKENS ------------------- */
  {WhiteSpace}                   { /* ignore */ }
  {Comment}                   { /* ignore */ }
}


/* error fallback */
[^]                              { throw new UnknownCharacterException(yytext()); }
