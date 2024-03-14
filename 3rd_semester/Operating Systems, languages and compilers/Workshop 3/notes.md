# OS Workshop 3 presentation
*   Parsing
    *   en parser består generelt af 2 elementer en lexical analyser og en syntax analyser (ofte også kaldt i sig selv parseren)
        *   en lexical analyser er kort sagt et stykke software der tager og omdanner nogle datatyper til tokens, i dette eksempel bruger vi JSON
            *   man kunne også have brugt XML, her er datatyperne sat op på en lidt anderledes måde da det er bygget meget mere omkring objekterne der er defineret i filen.
        *   en syntax analyser tager de tokens den får ind og checker dem igennem om deres syntax stemmer overens med hvordan sprogets syntax er defineret.
        *   det vil sige at syntax analyseren ikke ville kunne fungere uden en lexicalsk analyse inden
    *   I JSON vil man gerne se en opbygning der ligner key-value databaser.
        *   der er et par undtagelser, i en JSON fil skal der være et objekt der wrapper resten af dataen i filen, vi kan se denne som en slags root hvis vi ville sætte det op i et tree
        *   hvis der er et JSON objekt i en value et sted så begynder vi på et helt nyt sæt key-value par som syntax analyseren skal læse, dette objekt kan ses som et child i tree'et
    *   idet JSON filen er helt gennem parseren så vil du typisk have et JSON objekt i det programmeringssprog man arbejder med.
*   Lex
    *   vi bruger sproget Flex
        *   flex er baseret på C, det bliver brugt til at lave lexical analysis
        *   der er noget forskelligt syntax man kan bruge heri, man starter med en definitions section, det er C syntax
        *   så er der en "rules" section, her kan man bruge Flex' syntax
            *   Flex's syntax fungerer ved at der er en definition på syntaxen fx. [a-z] hvilket er alle små bogstaver i det engelske alfabet eller, [01] som er enten 0 eller 1 som i den her opgave.
            efter definitionen så er der et par brackets {} hvor man kan behandle de characters man fik ind, som fx. {printf("%s is not valid",yytext)}
            *   der er forskel på [] og (), [] matcher med 1 character i bracketen, i () matcher programmet med hele stringen
                *   med det sagt så er det ikke helt ligegyldigt at bruge parenteser eller ej, fordi de betyder lidt noget andet end i matematik.
        *   til sidst er der en normal C syntax, her vil der være en int main()
            *   i int main er der skrevet yylex() der spørger om en string af characters, den checker de her characters som en lexical analysis
            *   den er ligeglad med rækkefølge af de her characters ligesom ovenfor, så længe de passer ind i en af reglerne.
    *   man kan bruge en lexer til at checke flere ting end man lige regner med
        *   en e-mail adresse for eksempel

            ` [a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-zA-Z0-9]+    {printf("valid")}`
    *   terminaler og non-terminaler
        *   en non-terminal kan ses som et funktionskald, så S0 er base funktionen, vi starter altid med den
        *   når vi får en karakter ind terminal kan det gå til en af de tre states i grammar
        *   en terminal kan ses som et return statement, når vi får en terminal ind så returnerer Sn hvadend den terminal har af state
*   Context free grammar
    *   basicly regular grammar men der er ikke nogen restrictions om du har A -> aB eller A -> Ba, det betyder at du kan skrive A -> aBa