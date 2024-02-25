/// Created by Marius Mikucionis <marius@cs.aau.dk>
/**
 * Definitions of number_series and number_series_wrap classes.
 */

#ifndef INCLUDE_NUMBER_SERIES_H
#define INCLUDE_NUMBER_SERIES_H

#include <vector>
#include <limits>
#include <memory>
#include <iostream>

namespace data_series
{
    class number_series
    {
    private:
        // TODO: add data field
        std::vector<int> data;
        // TODO: add minimum and maximum fields
        int minimum = NULL;
        int maximum = NULL;
    public:
        // TODO: add necessary ctors and dtors
        number_series();
        number_series(int);
        number_series(std::initializer_list<int>);
        number_series(const number_series&); // copy constructor
        number_series& operator=(const number_series&); //copy assignment
        number_series(number_series&&); //move constructor
        number_series& operator=(number_series&&); //move assignment
        ~number_series(); // destructor
        // TODO: add getter "size()" giving the count of numbers in the series
        int size() const;
        // TODO: add getters for minimum and maximum
        int get_min() const;
        int get_max() const;
        // TODO: add add_value method to add numbers to the series and maintain min/max
        void add_value(int);
        // TODO: add static member fn for factory method
        static number_series fn(std::vector<int>);
        static number_series make_random(int);
        // TODO: add operator+= to forward calls to add_value
        number_series operator+=(number_series);
        // TODO: add operator+ which calls operator+
        number_series operator+(number_series);
        // TODO: add operator< to compare amplitudes (difference between maximum and minimum)
        bool operator<(number_series);
    };

    // TODO: create a light-weight wrapper class around number_series
    class number_series_wrap
    {
        // TODO: add number_series member in a smart pointer
    public:
        number_series_wrap();
        // TODO: add the same interface as in number_series which forwards all the calls
    };

}  // namespace data_series

#endif  // INCLUDE_NUMBER_SERIES_H
