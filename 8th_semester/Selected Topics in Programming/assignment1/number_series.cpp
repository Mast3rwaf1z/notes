/// Created by Marius Mikucionis <marius@cs.aau.dk>
/**
 * Definitions/implementation of some number_series methods
 */

#include "number_series.hpp"

#include <random>

namespace data_series
{
    number_series::number_series() = default;
    number_series::number_series(int value){
        this->add_value(value);
    }
    number_series::number_series(std::initializer_list<int> values){
        for(auto value : values){
            this->add_value(value);
        }
    }
    number_series::number_series(const number_series& other){
        for(auto value : other.data){
            this->add_value(value);
        }
    }
    number_series& number_series::operator=(const number_series& other){
        this->data = other.data;
        this->maximum = other.maximum;
        this->minimum = other.minimum;
        std::cout << "copy constructor" << std::endl;
        return *this;
    }

    number_series::number_series(number_series&& other) = default;
    number_series& number_series::operator=(number_series&& other) = default;

    number_series::~number_series() = default;

    int number_series::size() const {
        return this->data.size();
    }
    int number_series::get_min() const {
        return this->minimum;
    }
    
    int number_series::get_max() const {
        return this->maximum;
    }
    void number_series::add_value(int value){
        if(value > this->maximum || this->maximum == NULL){
            this->maximum = value;
        }
        if(value < this->minimum || this->minimum == NULL){
            this->minimum = value;
        }
        return this->data.push_back(value);
    }

    number_series number_series::fn(std::vector<int> values){
        number_series series;
        for(auto value : values){
            series.add_value(value);
        }
        return series;
    }

    number_series number_series::make_random(int amount){
        std::random_device device;
        std::mt19937 random_engine(device());
        std::uniform_int_distribution<int> distribution_1_100(1, 100);
        std::vector<int> numbers;
        for(int i = 0; i < amount; i++){
            numbers.push_back(distribution_1_100(random_engine));
        }
        return number_series::fn(numbers);
    }

    number_series number_series::operator+=(number_series other){
        for(auto value : other.data){
            this->add_value(value);
        }
        return *this;
    }

    number_series number_series::operator+(number_series other){
        number_series obj1 = this->size() > other.size() ? *this : other;
        number_series obj2 = this->size() > other.size() ? other : *this;
        for(int i = 0; i < obj2.size(); i++){
            obj1.data[i] = obj1.data[i] + obj2.data[i];
        }
        return obj1;
    }

    bool number_series::operator<(number_series other){
        int amplitude1 = this->get_max() - this->get_min();
        int amplitude2 = other.get_max() - other.get_min();
        return amplitude1 < amplitude2;
    }

    number_series_wrap::number_series_wrap() = default;
}  // namespace data_series
