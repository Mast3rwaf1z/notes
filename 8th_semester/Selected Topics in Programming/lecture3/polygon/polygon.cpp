#include "polygon.hpp" // include your headers first to test that they are self-contained
#include <iostream>

/**
 * Implementation of the polygon class methods.
 * They are mostly printing, but other content (copy and move constructor and assignment)
 * are representative of good practice. There are still some minor details left to fix.
 * @author Marius Mikucionis <marius@cs.aau.dk>
 */

/**
 * TODO: 1) Very important: fix the memory leak. Address sanitizer may help (add -DASAN=ON to cmake in Linux).
 * TODO: 2) Change the initializations to uniform initializations with curly braces.
 *          Be careful, not all make sense.
 * TODO: 3) move-constructor and move-assignment operator have identical code,
 *          which is difficult to maintain. How can we apply the DRY principle? Fix it!
 *          DRY = Don't Repeat Yourself, i.e. get rid of the code duplicates by reusing the code.
 * TODO: 4) copy-constructor and copy-assignment operator have almost identical code,
 *          which is difficult to maintain. How can we apply the DRY principle? Fix it!
 * TODO: 5) Nearly all constructors have identical initializations, DRY them by using constructor delegation.
 * TODO: 6) Use std::copy instead of for() loop when copying array data.
 * TODO: 7) Compare the performance of copy-assignment vs move-assignment (mentally).
 * TODO: 8) Install SonarLink plugin for Clion (Settings -> Plugins -> search for SonarLint,
 *          click install, restart) and check if there are more issues in this file and polygon.hpp.
 */

std::ostream& operator<<(std::ostream& os, const point& p)
{
    return os << "point{" << p.x << ',' << p.y << "}";
}

polygon::~polygon() noexcept
{
    std::cout << "destructor\n";
}

polygon::polygon():
    count(0), points(nullptr) // initialize
{
    std::cout << "default-constructor\n";
}

polygon::polygon(size_t count):
    count(count), points(count ? new point[count]() : nullptr)
{
    std::cout << "custom-constructor(" << count << ")\n";
}

polygon::polygon(const std::initializer_list<point>& ps):
    count(ps.size()), points(count ? new point[count] : nullptr)
{
    std::cout << "custom-constructor{";
    for (auto i = 0u; i < count; ++i)
        points[i] = std::data(ps)[i]; // initialize each array member

    if (count > 0) {
        auto b = begin(), e = end();
        std::cout << b;
        while (++b != e)
            std::cout << ',' << *b;
    }
    std::cout << "}\n";
}

polygon& polygon::operator=(const polygon& other)
{
    if (this != &other) {
        std::cout << "copy-assignment\n";
        // First, release our resources (fragments the dynamic memory, not nice):
        delete [] points;
        // Second, allocate memory:
        count = other.count; // copy
        points = new point[count]; // allocate -- expensive
        // Third, copy the data:
        for (auto i = 0u; i < count; ++i) // many assignments -- expensive
            points[i] = other[i]; // copy-assignment -- potentially expensive
    }
    return *this; // remember to return, otherwise wicked memory issues
}

polygon::polygon(const polygon& other):
    count(other.count),
    points(count ? new point[count] : nullptr) // allocation: expensive
{
    std::cout << "copy-constructor\n";
    for (auto i = 0u; i < count; ++i)
        points[i] = other[i]; // assignment operation: potentially expensive
}

polygon& polygon::operator=(polygon&& other) noexcept
{
    std::cout << "move-assignment\n";
    // The other is about to be destroyed, so let's just put our garbage there.
    // Overall, this boils down to a simple resource exchange:
    std::swap(count, other.count);   // cheap
    std::swap(points, other.points); // super cheap!
    // no allocation, no element copying => very efficient, no chance for exceptions
    return *this; // remember to return, otherwise all kinds of weird memory issues
}

polygon::polygon(polygon&& other) noexcept: count(0), points(nullptr)
{
    std::cout << "move-constructor\n";
    std::swap(count, other.count);   // cheap
    std::swap(points, other.points); // super cheap!
}

std::ostream& operator<<(std::ostream& os, const polygon& poly)
{
    if (poly.empty()) {
        os << "(empty polygon)";
    } else {
        for (auto point : poly) // FIXME: is this really safe and efficient?
            os << point << " ";
    }
    return os; // remember to return, otherwise wicked memory issues
}
