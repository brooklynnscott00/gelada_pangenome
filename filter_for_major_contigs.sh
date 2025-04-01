#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter fasta for major contigs"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=4G

source /scratch/brscott4/gelada/gelada_pangenome/_include_options.sh

sample_ID=${samples[${SLURM_ARRAY_TASK_ID} - 1]}

awk 'NR==FNR {pairs[$1","$2]; next} ($1","$6) in pairs' \
	data/${dataset}.${sample_ID}.${genome}.contig-to-chr_map.txt \
	mapped_reads/${dataset}.${sample_ID}.HiFiONT.hifiasm.dualscaf.aligned-${genome}.wfmash.paf > \
	mapped_reads/${dataset}.${sample_ID}.HiFiONT.hifiasm.dualscaf.aligned-${genome}.major_rule_filtered.wfmash.paf

