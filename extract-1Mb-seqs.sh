#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="extract long sequences"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1

module load samtools-1.21-gcc-12.1.0
source /scratch/brscott4/gelada/gelada_pangenome/_include_options.sh

sample_ID=${samples[${SLURM_ARRAY_TASK_ID} - 1]}

awk '$2 >= 1000000 {print $1}' assemblies/${sample_ID}.HiFiONT.hifiasm.dualscaf.fa.gz.fai > data/${dataset}.${sample_ID}.seqs_over_1Mb.txt

mkdir -p 1Mb_fastas

samtools faidx assemblies/${sample_ID}.HiFiONT.hifiasm.dualscaf.fa.gz \
    $(cat data/${dataset}.${sample_ID}.seqs_over_1Mb.txt) | gzip > \
    1Mb_fastas/${sample_ID}.HiFiONT.hifiasm.dualscaf.1Mb.fa.gz


