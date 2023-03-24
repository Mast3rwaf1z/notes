# OS workshop 1 presentation
*   Operativsystem
    *   Vi bruger linux mint til at teste systemet til sidst men da jeg selv bruger linux på min ejen computer er det også blevet testet der
*   Kompilering
    *   Der er en lille fejl her i starten af dette afsnit, jeg vil gerne lige klargøre at makefiles ikke er eksklusivt til C og C ikke nødvendigvis skal kompileres med makefiles
    *   GCC er vores kompiler, dette er heller ikke rigtigt nævnt i afsnittet, den virker som så mange andre command line værktøjer i linux, du kan sætte flags på den og de her flags gør noget for den primære kommando
        *   -c kompilerer til en .o fil, dette kan også kaldes en output fil efter det er kompileret
        *   -o specificerer et sted du vil outputte din final kode til, tager en .o fil
        *   -Wall viser alle warnings
    *   GCC er heller ikke specifikt en C compiler, den kan også kompile C++, Fortran, Go m.fl.
*   Processer og threads
    *   vi bruger 2 processer:
        *   Tempstub, et program der genererer data og sender det gennem en pipe i /tmp directory
        *   main er et program der henter denne data fra /tmp/myfifo i en thread og gemmer det i ./data
    *   vi bruger 2 threads:
        *   writeThread læser fra laststr og kører myfilewriter metoden med en concatenated string af current og tempstr
        *   threaden slutter med at kopiere stringen tempstr til laststr
        *   readThread læser fra /tmp/myfifo og gemmer det i tempstr
*   Synkronisering
    *   mutexes
        *   kort sagt så fungerer de til at låse enkelte resourcer der bliver brugt af forskellige programmer
            *   hvis der er flere programmer der vil bruge den samme resource er det vigtigt at de ikke fx. læser samtidigt
            *   binaray semafor
    *   semaforer
        *   bestemmer hvor mange resourcer programmet bruger
        *   i recursion for eksempel kan den samme thread access den samme semafor flere gange, dette vil give en måling af hvor mange resourcer denne thread bruger.
*   Memory management
    *   Vi bruger en variabel af 400MB størrelse, 1 char = 2 bytes
        *   not good½
    *   memory er bygget op således fra hurtigste til langsomste:
        *   CPU'ens registre
        *   cache
        *   RAM
        *   Virtual memory (Swap partition/file)
