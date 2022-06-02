from time import perf_counter
from DCT_CUDA import Test3 as cuda_test
from DCT_JIT import Test3 as jit_test
from DCT_Tests import Test3 as sequential_test
from DCT_Tests import Test3_parallel as parallel_test



def run(image, block_size, quality):
    print("cuda")
    time1 = perf_counter()
    cuda_test(image, block_size, quality)
    time2 = perf_counter()
    print("jit")
    jit_test(image, block_size, quality)
    time3 = perf_counter()
    print("sequential")
    sequential_test(image, block_size, quality)
    time4 = perf_counter()
    print("parallel")
    parallel_test(image, block_size, quality)
    time5 = perf_counter()
    return image, block_size, time2-time1, time3-time2, time4-time3, time5-time4

def print_results(image, block_size, cuda, jit, sequential, parallel):
    print(f'execution times for image {image} with block size {block_size}:')
    print(f'\tcuda:         {cuda}')
    print(f'\tjit:          {jit}')
    print(f'\tsequential:   {sequential}')
    print(f'\tparallel:     {parallel}')


images = ["cat.jpg", "4k_image.jpg"]
block_sizes = [8, 32, 128]
results = list()
for i in range(len(block_sizes)):
    for j in range(len(images)):
        results.append(run(images[j], block_sizes[i], 50))
results.append(run("cat.jpg", 1280, 50))
results.append(run("4k_image.jpg", 4608, 50))

for result in results:
    print_results(result[0], result[1], result[2], result[3], result[4], result[5])
