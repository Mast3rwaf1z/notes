from time import perf_counter

def timer(func, *args):
    def wrapper(*args):
        pre = perf_counter()
        result = func()
        post = perf_counter()
        return result, post-pre
    return wrapper

def new_timer(func, *args):
    pre = perf_counter()
    result = func()
    post = perf_counter()
    return result, post-pre

if __name__ == "__main__":
    @timer
    def func():
        pass
    
    print(func())