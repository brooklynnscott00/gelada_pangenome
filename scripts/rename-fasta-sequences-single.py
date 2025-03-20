#!/usr/bin/env python3

import sys
import gzip
import argparse

# stores command line arguments
arguments = sys.argv

fasta_file = arguments[1]
mapped_paf = arguments[2]
out_file = arguments[3]

# Extract sample name from the fasta file name 
sample_name = fasta_file.split("/")[-1].split(".")[0]

# Parse PAF file to create a mapping contig:chromosome
contig_map = {cols[0]: cols[5] for cols in (line.split() for line in open(mapped_paf))}

with gzip.open(fasta_file, "rt") as infile, gzip.open(out_file, "wt") as outfile:
    for line in infile:
        if line.startswith(">"):
            contig = line.strip()[1:]  # Remove '>'
            chromosome = contig_map.get(contig, "unmapped")  # Lookup chromosome, default to "unmapped"

            # Replace prefix "h1" → "H1", "h2" → "H2"
            if contig.startswith("h1"):
                contig_prefix = "H1"
            elif contig.startswith("h2"):
                contig_prefix = "H2"
            else:
                contig_prefix = contig  # Keep original if it doesn't start with h1 or h2

            # Construct new header with the switched order
            new_name = f"> {sample_name} {contig_prefix} {chromosome}"
            outfile.write(new_name + "\n")
        else:
            outfile.write(line)
