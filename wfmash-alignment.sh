#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="map long reads wfmash"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=highmem
#SBATCH --qos=public
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --mem=164G
#SBATCH --cpus-per-task=12

source /scratch/brscott4/gelada/gelada_pangenome/_include_options.sh
sample_ID=${samples[${SLURM_ARRAY_TASK_ID} - 1]}

module load samtools-1.21-gcc-12.1.0
samtools faidx 1Mb_fastas/${sample_ID}.HiFiONT.hifiasm.dualscaf.1Mb.fa.gz

module load mamba/latest
source activate wfmash 

mkdir -p mapped_reads/

wfmash ${genome_path} 1Mb_fastas/${sample_ID}.HiFiONT.hifiasm.dualscaf.1Mb.fa.gz -s 5k -p 90 -m \
    > mapped_reads/${dataset}.${sample_ID}.HiFiONT.hifiasm.dualscaf.aligned-${genome}.1Mb.wfmash.paf
