package calculadora_jflex_cup;

import java_cup.runtime.*;
import java.io.Reader;
      
%% 
/* ------ Seccion de opciones y declaraciones de JFlex -------------- */  
   
%class AnalizadorLexico
%line
%column
%cup
   
%{
  /*  Generamos un java_cup.Symbol para guardar el tipo de token encontrado */
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
  /* Generamos un Symbol para el tipo de token encontrado junto con su valor */
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}
   
Salto = \r|\n|\r\n
Espacio = {Salto} | [ \t\f]
Entero = 0 | [1-9][0-9]*

%% 
<YYINITIAL> {
      ";" { System.out.println(" ; ");return symbol(sym.SEMI); }
      "+" { System.out.print(" + "); return symbol(sym.OP_SUMA); }
      "-" { System.out.print(" - "); return symbol(sym.OP_RESTA); }
      "*" { System.out.print(" * "); return symbol(sym.OP_MULT); }
      "(" { System.out.print(" ( "); return symbol(sym.PARENIZQ); }
      ")" { System.out.print(" ) "); return symbol(sym.PARENDER); }
 {Entero} { System.out.print(yytext()); return symbol(sym.ENTERO, new Integer(yytext())); }
{Espacio} { /* ignora el espacio */ } 
        . { System.out.print(yytext()); return symbol(sym.error, yytext());}
}

