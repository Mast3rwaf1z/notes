# Polygon

## Objective 
Get acquainted with the following:
1) basic class structure
2) special constructors and assignment operators
3) other customization points:
    * custom constructors
    * printing to output stream
    * subscripting with []
    * iteration with ranged-for-loop

## Instructions
1) Read [polygon.hpp](polygon.hpp) and get acquainted with the library interface, identify special members (ctor, dtor, assignment), pay attention to documenting comments, the text in quotes gets printed when the member is called.
2) Open [polygon_test.cpp](polygon_test.cpp), follow TODO comments and add your predictions what is going to be printed.
3) Run [polygon_test.cpp](polygon_test.cpp) and compare the outputs with your predictions.
4) Open [polygon.cpp](polygon.cpp), follow TODO comments and fix the code.

## Disclaimer
This polygon class design is *NOT* a good practice! **Not good code** for the exam!
 * It is artificially inflated just to demonstrate all kinds of constructors. It can (and should) be simplified (a lot). The point of this exercise is to do just that.
 * In practice one would use smart-pointers and the rule of zero instead (next lecture).
 * This shows a gist of how standard libraries are implemented from scratch.
