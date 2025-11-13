import csv


INPUT_FILE = "input_s1.csv"


def get_lists():
    lists = [[], []]

    with open(INPUT_FILE) as file:
        reader = csv.reader(file)
        for row in reader:
            for result_list in lists:
                result_list.append(int(row.pop(0)))

    return lists


def compare_lists():
    lists = get_lists()

    for listt in lists:
        listt.sort()

    result = 0
    i = 0
    for location in lists[0]:
        result += abs(location - lists[1][i])
        i += 1

    return result


if __name__ == "__main__":
    print(compare_lists())
