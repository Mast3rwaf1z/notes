#include "polygon.hpp"
#include <iostream>
#include <vector>

/**
 * Code to test the understanding of special member functions and references.
 * @author Marius Mikucionis <marius@cs.aau.dk>
 */

polygon polygon_factory(size_t count){ return polygon(count); }

void draw_value(polygon) { std::cout << "passed-by-value\n"; }
void draw(const polygon&) { std::cout << "passed-by-const-reference\n"; }
void draw(polygon&) { std::cout << "passed-by-lvalue-reference\n"; }
void draw(polygon&&) { std::cout << "passed-by-rvalue-reference\n"; }

int main()
{
    const auto ruler = std::string(40, '=');
    // TODO: Replace "???" with your predictions: what gets printed after each line?
    //       Note that some statements may print more than one line.
    // TODO: After all "???" are gone, step through the program in debugger and check your answers against output.
    // TODO: Answer the additional questions below.
    {   // for example:
        std::cout << "0) " << ruler << std::endl;
        polygon poly;
        // default-constructor
        // destructor
    }
    {
        std::cout << "1) " << ruler << std::endl;
        polygon poly(1);
        // TODO: ???
    }
    {
        std::cout << "2) " << ruler << std::endl;
        polygon poly = 1;
        // TODO: ???
    }
    {
        std::cout << "3) " << ruler << std::endl;
        const polygon poly0;
        // TODO: ???

        std::cout << "4) " << ruler << std::endl;
        polygon poly1 = poly0;
        // TODO: ???

        std::cout << "5) " << ruler << std::endl;
        polygon poly2 = polygon(2);
        // TODO: ???

        std::cout << "6) " << ruler << std::endl;
        polygon poly3{{1,2},{3,4},{5,6},{7,8}};
        // TODO: ???

        std::cout << "7) " << ruler << std::endl;
        poly2 = poly1;
        // TODO: ???

        std::cout << "8) " << ruler << std::endl;
        poly2 = polygon_factory(3);
        // TODO: ???

        std::cout << "9) " << ruler << std::endl;
        draw_value(poly0);
        // TODO: ???

        std::cout << "10) " << ruler << std::endl;
        draw(poly0);
        // TODO: ???

        std::cout << "11) " << ruler << std::endl;
        draw(poly1);
        // TODO: ???

        std::cout << "12) " << ruler << std::endl;
        draw(polygon_factory(4));
        // TODO: ???

        std::cout << "13) " << ruler << std::endl;
        std::vector<polygon> polies(4, poly3);
        // TODO: ???

        std::cout << "14) " << ruler << std::endl;
        polies.push_back(poly3);
        // TODO: ???
        // TODO: Why are so many operations here?

        std::cout << "15) " << ruler << std::endl;
        polies.push_back(poly3);
        // TODO: ???
        // TODO: Why is the number of operations fewer here than for the above one?

        std::cout << "16) " << ruler << std::endl;
        for (polygon p : polies)
            std::cout << p << " at " << &p << '\n';
        // TODO: ???!
        // TODO: Can we make the loop above more efficient?
        // TODO: This is an incredibly common mistake, make sure to fix it, or ask.
    }
    {
        std::cout << "17) " << ruler << std::endl;
        draw(1);
        // TODO: ???
        // TODO: What is going on here? Why "1" is treated as polygon? This is unlikely to be intentional.
        // TODO: Can we forbid the last statement without breaking the previous code?
        // TODO: Fix it in polygon.hpp so that this line does not compile.
    }
    {
        std::cout << "18) " << ruler << std::endl;
        polygon poly = polygon(2);
        std::cout << poly << " at " << &poly << std::endl;
        draw_value(std::move(poly));
        // TODO: ???
        std::cout << poly << " at " << &poly << std::endl;
        // TODO: What was inside poly before draw_value call?
        // TODO: What is inside poly after draw_value call? Why?
    }
    {
        std::cout  << "19) "<< ruler << std::endl;
        polygon poly = polygon(2);
        std::cout << poly << " at " << &poly << std::endl;
        draw(std::move(poly));
        // TODO: ???
        std::cout << poly << " at " << &poly << std::endl;
        // TODO: What was inside poly before draw call?
        // TODO: What is inside poly after draw call? Why?
    }
    std::cout << ruler << std::endl;
}
