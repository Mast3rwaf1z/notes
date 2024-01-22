from sys import argv

def main():
    valid = []
    if not all(map(str.isnumeric, argv[1:])):
        return 0
    else:
        for num in [int(i) for i in argv[1:]]: 
            if num > 2 and num < 200: 
                valid.append(num)
            else: 
                print(f"invalid: {num}")
    return sum(valid)