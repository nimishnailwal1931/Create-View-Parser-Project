%{
    #include<stdio.h>
	#include"y.tab.h"
%}
    /*
	INPUT:-It takes a sql CREATE VIEW query and checks wether it is syntactically correct or not.
	PROCESS:-The lex file will extract the tokens defined in it i.e.,
    tokens:- crt view gby ob id cb as slct c frm whr sc star nl
            LT GT LE GE NE AND OR EQ si di num odr by asc desc nj sum cnt avg hvng 
    and everything else is sent as well and do not contribute to the language and if encountered 
    will be rejected right away.
    */

%%
[C|c][R|r][E|e][A|a][T|t][E|e]                              return crt;
[V|v][I|i][E|e][W|w]                                        return view;
[S|s][E|e][L|l][E|e][C|c][T|t]                              return slct;
[A|a][S|s]                                                  return as;
[F|f][R|r][O|o][M|m]                                        return frm;
[W|w][H|h][E|e][R|r][E|e]                                   return whr;
[A|a][V|v][G|g]                                             return avg;
[O|o][R|r]                                                  return OR;
[A|a][N|n][D|d]                                             return AND;
[O|o][R|r][D|d][E|e][R|r]                                   return odr;
[B|b][y|Y]                                                  return by;
[A|a][S|s][C|c]                                             return asc;
[D|d][E|e][S|s][C|c]                                        return desc;
[N|n][A|a][T|t][U|u][R|r][A|a][L|l][ ][J|j][O|o][I|i][N|n]  return nj;
[S|s][U|u][M|m]                                             return sum;
[C|c][O|o][U|u][N|n][T|t]                                   return cnt;
[G|g][R|r][O|o][U|u][P|p]                                   return g;
\'                                                          return si;
\"                                                          return di;
\(                                                          return ob;
\)                                                          return cb;
\-                                                          return ds;
,                                                           return comma;
;                                                           return sc;
[a-zA-Z_][a-zA-Z0-9_]*                                      return id;
[0-9]*                                                      return num;
"<"                                                         return LT;
">"                                                         return GT;
"<="                                                        return LE; 
">="                                                        return GE;
"="                                                         return EQ;
"<>"|"!="                                                   return NE;
\n                                                          return nl;
"*"                                                         return star;
%%

    /* 
    Once the file query is ready by compiler, wrap function is called when input gets exhausted,
    Return 1 if you are done or 0 if more processing is required .
    */
    
int yywrap(){
    return 1;
}