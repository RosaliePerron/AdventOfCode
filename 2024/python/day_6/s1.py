INPUT_FILE = "input_s1"


def read_input():
    with open(INPUT_FILE, "r") as f:
        current_position = [0, 0, "^"]
        obstacles = []
        room_dimensions = [0, 0]

        y = 1
        for line in f:
            if room_dimensions[0] == 0:
                room_dimensions[0] = len(line) - 1

            x = 1
            for position in line:
                if position == "#":
                    obstacles.append((x, y))

                if position in ("^", "<", ">", "v"):
                    current_position = [x, y, position]

                x += 1
            y += 1

        room_dimensions[1] = y - 1
        return current_position, obstacles, room_dimensions


def travel_to_next_obstacle(current_position, obstacles, room_dimensions):
    x, y, direction = current_position
    positions = []

    position = (x, y)
    i = 1
    while position not in obstacles and room_dimensions[0] >= position[0] > 0 and room_dimensions[1] >= position[1] > 0:
        if direction == "^":
            position = (x, y - i)
        elif direction == ">":
            position = (x + i, y)
        elif direction == "v":
            position = (x, y + i)
        elif direction == "<":
            position = (x - i, y)

        positions.append(position)
        i += 1

    return positions


def get_next_direction(current_direction):
    if current_direction == "^":
        return ">"
    elif current_direction == ">":
        return "v"
    elif current_direction == "v":
        return "<"
    elif current_direction == "<":
        return "^"


def compute_path(data):
    current_position, obstacles, room_dimensions = data
    positions = [(current_position[0], current_position[1])]

    exited_the_room = False
    while not exited_the_room:
        positions += travel_to_next_obstacle(
            current_position, 
            obstacles, 
            room_dimensions
        )
        last_direction = current_position[2]
        current_position = [*positions[-2], get_next_direction(last_direction)]

        exited_the_room = (
            current_position[0] == 0 
            or current_position[1] == 0
            or current_position[0] == room_dimensions[0]
            or current_position[1] == room_dimensions[1]
        )

    print_room(room_dimensions, obstacles, positions)


def print_room(room_dimensions, obstacles, positions):
    result = 0
    y = 1
    for line in range(room_dimensions[1]):

        x = 1
        for position in range(room_dimensions[0]):
            if (x, y) in obstacles:
                print("#", end="")

            elif (x, y) in positions:
                print("x", end="")
                result += 1

            else:
                print(".", end="")
            x += 1

        print()
        y += 1

    print(f"{result} total positions visited.")


if __name__ == "__main__":
    compute_path(read_input())
