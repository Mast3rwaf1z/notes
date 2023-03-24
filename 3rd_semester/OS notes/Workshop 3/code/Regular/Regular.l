%{
#include <stdio.h>
%}

%%

begin   {printf("predef:  \t BEGIN\n");}
end     {printf("predef:  \t END\n");}
[01]*((0000)|(1111))+[01]*      {printf("Value: %s is not valid binary number\n",yytext);}
[01]*                           {printf("Value: %s is a valid binary number\n", yytext);}
.                               {printf("Value: %s is not a binary number\n", yytext);}
%%

main()
{
  yylex();
}


