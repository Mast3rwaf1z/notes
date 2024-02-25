if [[ "$@" =~ "--init" ]]; then
    cmake -B build -S .
elif [[ "$@" =~ "--build" ]]; then
    cmake --build build
elif [[ "$@" =~ "--test" ]]; then
    ctest --test-dir build
else
    cmake -B build -S .
    cmake --build build
    ctest --test-dir build
    cat build/Testing/Temporary/LastTest.log
fi
