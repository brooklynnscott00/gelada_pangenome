#!/usr/bin/env python3

import sys
import gzip
import argparse

# stores command line arguments
arguments = sys.argv

fasta_file = arguments[1]
out_file = arguments[2]

# Extract sample name from the fasta file name 
sample_name = fasta_file.split("/")[-1].split(".")[0]


with gzip.open(fasta_file, "rt") as infile, gzip.open(out_file, "wt") as outfile:
    for line in infile:
        if line.startswith(">"):
            # Store the header line without the '>'
            header_line = line[1:].strip()

            # Replace prefix "h1" → "H1", "h2" → "H2"
            if header_line.startswith("h1"):
                contig_prefix = "H1"
            elif header_line.startswith("h2"):
                contig_prefix = "H2"
            else:
                contig_prefix = header_line  # Keep original if it doesn't start with h1 or h2

            # Construct new header with the switched order
            new_name = f">{sample_name}#{contig_prefix}#{header_line}"
            outfile.write(new_name + "\n")
        else:
            outfile.write(line)

