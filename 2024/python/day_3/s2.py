import re

INPUT_FILE = "input_s1"

def read_input():
    with open(INPUT_FILE, "r") as f:
        return f.read()


def find_multiplications(data):
    return re.findall(r"mul\([0-9]{1,3},[0-9]{1,3}\)|do\(\)|don't\(\)", data)


def compute_multiplications(multiplications):
    result = 0
    enabled = True
    for m in multiplications:
        if m == "do()":
            enabled = True

        if m == "don't()":
            enabled = False

        if enabled and m not in ["do()", "don't()"]:
            a, b = map(int, m[4:-1].split(","))
            result += a * b

    return result


def interpret_data():
    data = read_input()
    multiplications = find_multiplications(data)
    return compute_multiplications(multiplications)


if __name__ == "__main__":
    print(interpret_data())
