import csv 


INPUT_FILE = "input_s1"


def read_input():
    result = []

    with open(INPUT_FILE, "r") as f:
        reader = csv.reader(f, delimiter=" ")
        for row in reader:
            result.append([])

            for el in row:
                result[-1].append(int(el))

    return result


def verify_increases(line):
    return all([line[i] < line[i+1] for i in range(len(line) - 1)])


def verify_gaps(line):
    return all([1 <= abs(line[i+1] - line[i]) <= 3 for i in range(len(line) - 1)])


def verify_line(line):
    reversed_line = line.copy()
    reversed_line.reverse()

    return (
        verify_increases(line) or verify_increases(reversed_line)
    ) and verify_gaps(line)


def verify_report():
    report = read_input()
    result = 0

    for line in report:
        safe = verify_line(line)
        if safe:
            result += 1

    return result


if __name__ == "__main__":
    print(verify_report())
