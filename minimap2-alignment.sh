#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="map long reads"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=highmem
#SBATCH --qos=public
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --mem=164G
#SBATCH --cpus-per-task=12

module load mamba/latest
source activate minimap
source /scratch/brscott4/gelada/pangenome_assembly/_include_options.sh

sample_ID=${samples[${SLURM_ARRAY_TASK_ID} - 1]}

mkdir -p mapped_reads/

minimap2 -c -t 12 ${genome_path} assemblies/${sample_ID}.HiFiONT.hifiasm.dualscaf.fa.gz > mapped_reads/${dataset}.${sample_ID}.HiFiONT.hifiasm.dualscaf.aligned-${genome}.paf
