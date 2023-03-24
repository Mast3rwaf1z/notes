%{
#include <stdio.h>
#define END_T      258

int Count = 0;
int Index = 0;
int Valid = 1;
%}

%%
end     {return END_T;}
0$      {Count--; return 1;}
1$      {Count++; return 1;}
0       {Count--; return 0;}
1       {Count++; return 0;}
.       {Valid = 0; return 1;}

%%

int yywrap() {return 1;}

int
main()
{
  int token;
  while ((token = yylex()) != END_T)
  {
    if(token)
    {
      //printf("Entered main");
      if(Valid)
      {
        if(Count)
        {
          printf("The number does not contain an equal amount of zeroes and ones\n");
        }
        else
        {
          printf("The number contains an equal amount of zeroes and ones\n");
        }
      }
      else
      {
        printf("The string entered contains characters other than zeroes and ones\n");
      }

      Count = 0;
      Valid = 1;
    }
  }
}



