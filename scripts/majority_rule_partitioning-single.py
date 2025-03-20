#!/usr/bin/env python3

import sys

mapped_paf = sys.argv[1]
out_file = sys.argv[2]

# how to use it
# script input.paf output.txt

# Use dictionaries to store accumulated values and counts for each target per query
accumulated_values = {}

with open(mapped_paf, "r") as paf_file:
    for line in paf_file:
        columns = line.split()
        query = columns[0]
        target = columns[5]
        length = int(columns[10])
        id_value = float(columns[12].split(":")[2])

        # Calculate the accumulated value for this line
        value = length * id_value

        # Update the dictionaries
        if query not in accumulated_values:
            accumulated_values[query] = {}
        if target not in accumulated_values[query]:
            accumulated_values[query][target] = 0
        accumulated_values[query][target] += value

# Determine the target with the maximum accumulated value for each query
assignments = {}
for query, targets in accumulated_values.items():
    best_target = max(targets, key=targets.get)
    assignments[query] = best_target

with open(out_file, "w") as output:
    for query, target in assignments.items():
        output.write(f"{query}\t{target}\n")
