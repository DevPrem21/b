import hashlib, random

# Hash function using SHA-1
def sha1_hash(x, seed=0):
    s = f"{seed}|{x}".encode()
    return int(hashlib.sha1(s).hexdigest(), 16)

# Function to count trailing zeros
def trailing_zeros(n):
    return (n & -n).bit_length() - 1 if n else 0

# Flajolet–Martin algorithm
def flajolet_martin(stream, num_hashes=32):
    phi = 0.77351
    max_zeros = [0] * num_hashes

    # Apply multiple hash functions
    for x in stream:
        for i in range(num_hashes):
            h = sha1_hash(x, i)
            max_zeros[i] = max(max_zeros[i], trailing_zeros(h))

    # Estimate number of distinct elements
    avg = sum(2 ** r for r in max_zeros) / num_hashes
    return int(avg / phi)

# Main program
if __name__ == "__main__":
    data = [random.randint(0, 2000) for _ in range(5000)]
    print("Flajolet–Martin Algorithm")
    print("Actual distinct elements:", len(set(data)))
    print("Estimated distinct elements:", flajolet_martin(data))
