# Matrix Multiplication using MapReduce

M = [[1,2,3],
     [4,5,6],
     [7,8,9]]

V = [[1],[2],[3]]

# MAP PHASE
def mapper():
    pairs = []
    for i in range(3):
        for j in range(3):
            pairs.append(((i,0), ('M', j, M[i][j])))
    for j in range(3):
        for i in range(3):
            pairs.append(((i,0), ('V', j, V[j][0])))
    return pairs

# SHUFFLE
def shuffle(pairs):
    grouped = {}
    for k,v in pairs:
        grouped.setdefault(k, []).append(v)
    return grouped

# REDUCE
def reducer(grouped):
    result = {}
    for k, values in grouped.items():
        m = {}
        v = {}
        for t, j, val in values:
            if t == 'M': m[j] = val
            else: v[j] = val
        total = sum(m[j]*v[j] for j in m)
        result[k] = total
    return result

# RUN
grouped = shuffle(mapper())
result = reducer(grouped)

print(result)
