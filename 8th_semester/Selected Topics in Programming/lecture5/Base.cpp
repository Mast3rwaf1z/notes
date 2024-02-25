#include <iostream>
#include <vector>
#include <memory>
#include <chrono>

using namespace std;

class Base{
    public:
    int value{0};

    virtual void increment() = 0;

    void decrement(){
        this->value -= 1;
    }
};

class Derived : public Base{
    public:
    void increment() override {
        this->value += 1;
    }
};

int main(){
    vector<shared_ptr<Base>> objects(10'000'000, make_shared<Derived>());
    
    auto t1 = chrono::high_resolution_clock::now();
    for(auto& ptr : objects){
        ptr->increment();
    }
    auto t2 = chrono::high_resolution_clock::now();
    cout << "Time to increment: \n\t" << chrono::duration<double, milli>(t2 - t1).count() << endl;

    auto t3 = chrono::high_resolution_clock::now();
    for(auto& ptr : objects){
        ptr->decrement();
    }
    auto t4 = chrono::high_resolution_clock::now();
    cout << "Time to decrement: \n\t" << chrono::duration<double, milli>(t4-t3).count() << endl;

    vector<Derived> objects1(10'000'000, Derived());
    auto t5 = chrono::high_resolution_clock::now();
    for(auto obj : objects1){
        obj.increment();
    }
    auto t6 = chrono::high_resolution_clock::now();
    cout << "Time to increment without pointers: \n\t" << chrono::duration<double, milli>(t6-t5).count() << endl;

    auto t7 = chrono::high_resolution_clock::now();
    for(auto obj : objects1){
        obj.decrement();
    }
    auto t8 = chrono::high_resolution_clock::now();
    cout << "Time to decrement without pointers: \n\t" << chrono::duration<double, milli>(t8-t7).count() << endl;
}