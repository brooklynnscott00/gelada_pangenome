# Gelada pangenome

## Link data files

```shell
# create a symlink to assembly 1 
ln -s /scratch/aguarrac/projects/gelada/assemblies/DRT_2020_14_TGE.HiFiONT.hifiasm.dualscafTelom/DRT_2020_14_TGE.HiFiONT.hifiasm.dualscafTelom.bp.dip.fa.gz assemblies/DRT_2020_14_TGE.HiFiONT.hifiasm.fa.gz

ln -s /scratch/aguarrac/projects/gelada/assemblies/DRT_2020_14_TGE.HiFiONT.hifiasm.dualscafTelom/DRT_2020_14_TGE.HiFiONT.hifiasm.dualscafTelom.bp.dip.fa.gz.fai assemblies/DRT_2020_14_TGE.HiFiONT.hifiasm.fa.gz.fai

# create a symlink to assembly 2
cd /scratch/brscott4/gelada/data/long_read_genome_assembly/assemblies/joint_pacbio_ont
cat TID_1039885.hifiasm.hifi-pacbio.hap1.p_ctg.fasta TID_1039885.hifiasm.hifi-pacbio.hap2.p_ctg.fasta > TID_1039885.hifiasm.hifi-pacbio.dualscaf.fa
bgzip TID_1039885.hifiasm.hifi-pacbio.dualscaf.fa
samtools faidx TID_1039885.hifiasm.hifi-pacbio.dualscaf.fa.gz

ln -s /scratch/brscott4/gelada/data/long_read_genome_assembly/assemblies/joint_pacbio_ont/TID_1039885.hifiasm.hifi-pacbio.dualscaf.fa.gz assemblies/TID_1039885.HiFiONT.hifiasm.dualscaf.fa.gz 

ln -s /scratch/brscott4/gelada/data/long_read_genome_assembly/assemblies/joint_pacbio_ont/TID_1039885.hifiasm.hifi-pacbio.dualscaf.fa.gz.fai assemblies/TID_1039885.HiFiONT.hifiasm.dualscaf.fa.gz.fai
```

## minimap2 map assemblies to dnazoo

```shell
sbatch --array=1,2 minimap2-alignment.sh
```
jobID: 23933983		FAILED  
jobID: 23934200     **DONE**  

Didn't end up using these pafs, remapping with wfmash.  

## Filter assemblies for sequences > 1Mb, re map with wfmash map, and retain "major" sequences"

```shell 
# install wfmash 
conda create -n wfmash -c conda-forge -c bioconda wfmash=0.14.0 -y
```
Installing wfmash

```shell
sbatch --array=1-2 extract-1Mb-seqs.sh
```
Extracting sequences greater than 1Mb from both assemblies       
jobID: 24095218  	**DONE** 

## Map assemblies with wfmash to dnazoo 1Mb

```shell
sbatch --array=1,2 wfmash-alignment.sh
```
Align assemblies to the DNA zoo reference (1Mb)
jobID: 24454587		  
jobID: 24457742		**DONE**   

```shell
sbatch --array=1-2 major_rule_partitioning.sh
```
jobID: 24480338		**DONE**   

```shell
sbatch --array=1-2 filter_for_major_contigs.sh
```
Use the contig to chr map to retain only sequences that map to their "true" chromosome assignment            
jobID: 24480437		**DONE**   

```shell
grep 'HiC_scaffold_7' pangenome.TID_1039885.HiFiONT.hifiasm.dualscaf.aligned-Theropithecus_gelada_HiC_1Mb.major_rule_filtered.wfmash.paf > pangenome.TID_1039885.HiFiONT.hifiasm.dualscaf.aligned-Theropithecus_gelada_HiC_1Mb.major_rule_filtered.HiC_scaffold_7.wfmash.paf

grep 'h1' pangenome.TID_1039885.HiFiONT.hifiasm.dualscaf.aligned-Theropithecus_gelada_HiC_1Mb.major_rule_filtered.HiC_scaffold_7.wfmash.paf > pangenome.TID_1039885.HiFiONT.hifiasm.dualscaf.aligned-Theropithecus_gelada_HiC_1Mb.major_rule_filtered.HiC_scaffold_7.wfmash.H1.paf

grep 'h2' pangenome.TID_1039885.HiFiONT.hifiasm.dualscaf.aligned-Theropithecus_gelada_HiC_1Mb.major_rule_filtered.HiC_scaffold_7.wfmash.paf > pangenome.TID_1039885.HiFiONT.hifiasm.dualscaf.aligned-Theropithecus_gelada_HiC_1Mb.major_rule_filtered.HiC_scaffold_7.wfmash.H2.paf

```
grep chromosome 7 from the hybrid assemlby, then separate into H1 and H2 files.   



## rename fasta sequences

```shell
sbatch --array=1,2 rename_fasta_sequences.sh
```
Rename the sequences headers in fasta files to include sample name and haplotype information
jobID: 24344550
jobID: 24346643
