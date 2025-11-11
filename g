# Word Count using MapReduce

text = "Big data is powerful. Big data drives document"

# MAP PHASE
def mapper(line):
    words = line.lower().replace('.', '').split()
    return [(w, 1) for w in words]

# SHUFFLE & GROUP
def shuffle(pairs):
    grouped = {}
    for word, val in pairs:
        grouped.setdefault(word, []).append(val)
    return grouped

# REDUCE PHASE
def reducer(grouped):
    return {w: sum(vals) for w, vals in grouped.items()}

# RUN
mapped = mapper(text)
grouped = shuffle(mapped)
reduced = reducer(grouped)

print(reduced)
