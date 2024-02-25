#include <iostream>
#include <chrono>
#include <vector>

using namespace std;

void swap_ends(vector<int>& arr){
    for(int i = arr.size()/2 - 1, j = arr.size() - 1; i >= 0; --i, --j)
        swap(arr[i], arr[j]);
}

int main(){
    vector<int> vec = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    auto t0 = chrono::high_resolution_clock::now();
    swap_ends(vec);
    auto t1 = chrono::high_resolution_clock::now();
    for(auto val : vec) cout << val << " ";
    cout << endl;
    cout << "time: " << t1-t0 << endl;
}
