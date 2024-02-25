#include <iostream>
#include <chrono>
#include <vector>

using namespace std;

const int arr_size = 10000000;

void swap_ends(int arr[], int size){
    for(int i = size/2-1, j = size - 1; i >= 0; --i, --j)
        swap(arr[i], arr[j]);
}

int main(){
	int arr[arr_size] = {0};
	auto t0 = chrono::high_resolution_clock::now();
	swap_ends(arr, sizeof(arr)/sizeof(int));
	auto t1 = chrono::high_resolution_clock::now();
	for(auto val : arr) cout << val << " ";
	cout << endl;
	cout << "time: " << t1-t0 << endl;
}
