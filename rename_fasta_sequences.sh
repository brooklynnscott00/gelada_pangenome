#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="rename fasta sequences"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1

source /scratch/brscott4/gelada/pangenome_assembly/_include_options.sh

sample_ID=${samples[${SLURM_ARRAY_TASK_ID} - 1]}

mkdir -p panSN_fastas

scripts/rename-fasta-sequences-single.py \
    assemblies/${sample_ID}.HiFiONT.hifiasm.dualscaf.fa.gz \
    mapped_reads/${dataset}.${sample_ID}.HiFiONT.hifiasm.dualscaf.aligned-Theropithecus_gelada_HiC.paf \
    panSN_fastas/${dataset}.${sample_ID}.HiFiONT.hifiasm.dualscaf.panSN.fa.gz

