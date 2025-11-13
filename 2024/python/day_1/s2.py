import csv


INPUT_FILE = "input_s2.csv"


def get_lists():
    lists = [[], []]

    with open(INPUT_FILE) as file:
        reader = csv.reader(file)
        for row in reader:
            for result_list in lists:
                result_list.append(int(row.pop(0)))

    return lists


def count_instances_of_locations(locations):
    location_map = {}
    for location in locations:
        str_location = str(location)
        if str_location in location_map:
            location_map[str_location] += 1
        else:
            location_map[str_location] = 1

    return location_map


def compare_lists():
    lists = get_lists()
    lists[0].sort()

    location_map = count_instances_of_locations(lists[1])

    result = 0
    i = 0
    for location in lists[0]:
        result += location * location_map.get(str(location), 0)
        i += 1

    return result


if __name__ == "__main__":
    print(compare_lists())
