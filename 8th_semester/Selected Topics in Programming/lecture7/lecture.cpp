#include <iostream>
#include <vector>
#include <iterator>
#include <typeinfo>

void print(std::vector<int> vec){
    std::cout << "{";
    
    for(auto e : vec){
        std::cout << e << ",";
    }
    std::cout << "}";
}

/*std::ostream& operator<<(std::ostream& os, const std::vector<int>& vec){
    os << "{";
    for(auto e : vec)
        os << e << ",";
    os << "}";
    return os;
}

template<typename T>
std::ostream& operator<<(std::ostream& os, const std::vector<T>& vec){
    os << "{";
    for(auto e : vec)
        os << e << ",";
    os << "}";
    return os;
}*/

template <typename C, typename = typename C::value_type>
std::ostream& operator<<(std::ostream &os, C container){
    os << "{";
    for(auto e : container){
        os << e << ",";
    }
    os << "}";
    return os;
}

int main(){
    print(std::vector<int>{1,2,3});
    std::cout << std::vector{1,2,3}; // should print "{1,2,3}"
    std::cout << std::vector{1,2,3} << std::endl; // should still print "{1,2,3}"
    std::cout << std::vector{2.7,3.14} << std::endl; // should print "{2.7,3.14}"
    std::cout << std::vector{std::vector{"hello", "template"}, std::vector{"world"}} << std::endl;

    auto l = std::initializer_list{1,2,3,4};
    std::cout << l << std::endl; 
    
}
