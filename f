from collections import defaultdict

# Input Matrices (2x2)
A = {
    (0, 0): 1, (0, 1): 2,
    (1, 0): 3, (1, 1): 4
}

B = {
    (0, 0): 5, (0, 1): 6,
    (1, 0): 7, (1, 1): 8
}

# Map Phase – emit key-value pairs
mapped = []
for (i, k), v in A.items():
    mapped.append((k, ('A', i, v)))
for (k, j), v in B.items():
    mapped.append((k, ('B', j, v)))

# Shuffle Phase – group by key
grouped = defaultdict(list)
for k, value in mapped:
    grouped[k].append(value)

# Reduce Phase – multiply and sum
C = defaultdict(int)
for k, values in grouped.items():
    A_values = [v for v in values if v[0] == 'A']
    B_values = [v for v in values if v[0] == 'B']
    for a in A_values:
        for b in B_values:
            i = a[1]
            j = b[1]
            C[(i, j)] += a[2] * b[2]

# Print Resultant Matrix
rows = max(i for i, _ in C.keys()) + 1
cols = max(j for _, j in C.keys()) + 1
print("Resultant Matrix (C = A x B):")
for i in range(rows):
    row = [C[(i, j)] for j in range(cols)]
    print(row)
