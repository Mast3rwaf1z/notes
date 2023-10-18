# Exercises

## Exercise 1: C program
```C
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(){
    char *p, *q;
    p = NULL;
    printf("%s",p);
    q = (char*)malloc(100);
    p = q;
    free(q);
    *p = 'x';
    free(p);
    p = (char*)malloc(100);
    p = (char*)malloc(100);
    q = p;
    strcat(p, q);
}
```

faults:
assignment to p after freeing the memory of q, which is the same memory
double free, since p is already unallocated as its memory is the same as q, the memory is freed twice

alernate solution:
as we don't have a specification, it could be argued the program is not faulty, since the purpose of the program is to fail ;)

## Exercise 2: Semantics of programming languages
### a
```
x := -7/5;
y := -7%5;
```

if we consider the two languages C and python, then we could have the following code:
```c
#include <stdio.h>

int main(){
    int x,y;
    x = -7 / 5;
    y = -7 % 5;
    printf("%d\n", x);
    printf("%d\n", y);
}   
```

```py
x = -7 / 5
y = -7 % 5
print(f"{x}\n{y}")
```
here i have defined x and y as integers, which makes the c code do floor division instead of regular division as for modulus? XX

python is a weak typed language meaning that the type of x can be changed at runtime. This means despite using integers in our division, python will automatically output a float type from the divion. as for modulus? XX

### b
in c you would have an issue where the signed integer limit is like 2147483646, and this number would be 2147483647, resulting in a integer overflow, and the value would become -2147483646.

if the type is an unsigned integer, then this would result in 2147483647
