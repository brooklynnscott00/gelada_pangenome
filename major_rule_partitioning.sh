#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="major rule partioning"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --mem=2G
#SBATCH --cpus-per-task=1

source /scratch/brscott4/gelada/gelada_pangenome/_include_options.sh

sample_ID=${samples[${SLURM_ARRAY_TASK_ID} - 1]}

mkdir -p data/

scripts/majority_rule_partitioning-single.py \
    mapped_reads/${dataset}.${sample_ID}.HiFiONT.hifiasm.dualscaf.aligned-${genome}.wfmash.paf \
    data/${dataset}.${sample_ID}.${genome}.contig-to-chr_map.txt
