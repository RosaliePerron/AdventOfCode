INPUT_FILE = "input_s1"
KEY = "XMAS"


class Xmax:
    def read_input(self):
        with open(INPUT_FILE, "r") as f:
            result = []
            for line in f:
                result.append(list(line.strip()))

        return result

    def check_direction(self, start_coords, increments, index_key=1):
        i, j = start_coords
        i_inc, j_inc = increments

        if (0 > j or j > len(self.data[0])) or (0 > i or i > len(self.data)):
            return

        if self.data[i][j] == KEY[-1]:
            self.total_xmas += 1
            return

        try:
            if self.data[i + i_inc][j + j_inc] == KEY[index_key]:
                self.check_direction(
                    (i + i_inc, j + j_inc), 
                    increments, 
                    index_key + 1,
                )

        except IndexError:
            return

    def find_xmas(self):
        directions = (
            (0, -1), # left
            (-1, -1), # diag-left-up
            (-1, 0), # up
            (-1, 1), # diag-right-up
            (0, 1), # right
            (1, 1), # diag-right-down
            (1, 0), # down
            (1, -1) # diag-left-down
        )

        for i in range(len(self.data)):
            for j in range(len(self.data[0])):
                if self.data[i][j] == KEY[0]:
                    for direction in directions:
                        self.check_direction((i, j), direction)

    def __init__(self):
        self.total_xmas = 0
        self.data = self.read_input()

        self.find_xmas()
        print(self.total_xmas)


if __name__ == "__main__":
    Xmax()
