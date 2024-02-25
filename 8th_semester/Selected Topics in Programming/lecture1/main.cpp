#include <iostream>
#include <chrono>
#include <vector>

using namespace std;
using namespace std::chrono;

const int arr_size = 1'000'000;

void swap_ends(int arr[], int size){
    for(int i = size/2-1, j = size - 1; i >= 0; --i, --j)
        swap(arr[i], arr[j]);
}

void swap_ends(vector<int>& arr){
    for(int i = arr.size()/2 - 1, j = arr.size() - 1; i >= 0; --i, --j)
        swap(arr[i], arr[j]);
}

int main(){
	int arr[arr_size];
	auto t0 = chrono::high_resolution_clock::now();
	swap_ends(arr, sizeof(arr)/sizeof(int));
	auto t1 = chrono::high_resolution_clock::now();
	//for(auto val : arr) cout << val << " ";
	//cout << endl;
	cout << "array time: " << duration<double, milli>(t1-t0) << endl;

    vector<int> vec(arr_size); 
    auto t2 = chrono::high_resolution_clock::now();
    swap_ends(vec);
    auto t3 = chrono::high_resolution_clock::now();
    //for(auto val : vec) cout << val << " ";
    //cout << endl;
	cout << "vector time: " << duration<double, milli>(t3-t2) << endl;
}
