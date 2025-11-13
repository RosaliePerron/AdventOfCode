from math import floor


INPUT_FILE = "input_s1"


def read_input():
    with open(INPUT_FILE, "r") as f:
        rules = []
        updates = []

        for line in f:
            if "|" in line:
                rules.append(
                    [int(n) for n in line.strip().split("|")]
                )

            if "," in line:
                updates.append(
                    [int(n) for n in line.strip().split(",")]
                )

        return rules, updates


def build_acyclic_graph(rules):
    graph = {}

    for rule in rules:
        if str(rule[1]) not in graph:
            graph[str(rule[1])] = []

        graph[str(rule[1])].append(rule[0])

    return graph


def check_update(graph, update):
    for i, node in enumerate(update):
        node_str = str(node)
        if node_str not in graph:
            continue

        if i == len(update) - 1:
            return True

        must_be_before = graph[node_str]
        for next_node in update[i+1:]:
            if next_node in must_be_before:
                return False


def find_middle(update):
    return update[floor(len(update) / 2)]


if __name__ == "__main__":
    rules, updates = read_input()
    graph = build_acyclic_graph(rules)
    middles = [
        find_middle(update) 
        for update in updates 
        if check_update(graph, update)
    ]
    print(sum(middles))
