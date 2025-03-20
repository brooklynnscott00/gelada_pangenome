# Gelada pangenome

### Link data files

`ln -s /scratch/aguarrac/projects/gelada/assemblies/DRT_2020_14_TGE.HiFiONT.hifiasm.dualscafTelom/DRT_2020_14_TGE.HiFiONT.hifiasm.dualscafTelom.bp.dip.fa.gz assemblies/DRT_2020_14_TGE.HiFiONT.hifiasm.fa.gz`

`ln -s /scratch/aguarrac/projects/gelada/assemblies/DRT_2020_14_TGE.HiFiONT.hifiasm.dualscafTelom/DRT_2020_14_TGE.HiFiONT.hifiasm.dualscafTelom.bp.dip.fa.gz.fai assemblies/DRT_2020_14_TGE.HiFiONT.hifiasm.fa.gz.fai`
create a symlink to assembly 1 

```shell 
cd /scratch/brscott4/gelada/data/long_read_genome_assembly/assemblies/joint_pacbio_ont
cat TID_1039885.hifiasm.hifi-pacbio.hap1.p_ctg.fasta TID_1039885.hifiasm.hifi-pacbio.hap2.p_ctg.fasta > TID_1039885.hifiasm.hifi-pacbio.dualscaf.fa
bgzip TID_1039885.hifiasm.hifi-pacbio.dualscaf.fa
samtools faidx TID_1039885.hifiasm.hifi-pacbio.dualscaf.fa.gz
```
` ln -s /scratch/brscott4/gelada/data/long_read_genome_assembly/assemblies/joint_pacbio_ont/TID_1039885.hifiasm.hifi-pacbio.dualscaf.fa.gz assemblies/TID_1039885.HiFiONT.hifiasm.dualscaf.fa.gz`

`ln -s /scratch/brscott4/gelada/data/long_read_genome_assembly/assemblies/joint_pacbio_ont/TID_1039885.hifiasm.hifi-pacbio.dualscaf.fa.gz.fai assemblies/TID_1039885.HiFiONT.hifiasm.dualscaf.fa.gz.fai`
create a symlink to assembly 2

### minimap2 map assemblies to dnazoo

`sbatch --array=1,2 minimap2-alignment.sh`
jobID: 23933983		FAILED
jobID: 23934200     **DONE**

### wfmash map assemblies to dnazoo 
```shell 
# install wfmash 
conda create -n wfmash -c conda-forge -c bioconda wfmash=0.14.0 -y
```

`sbatch --array=1,2 wfmash-alignment.sh` align assemblies to the dnazoo reference with wfmash 
jobID: 24061623


END PROGRESS
---------------------------

`sbatch major_rule_partitioning.sh`

### re name fasta sequences headers for pangenome

`sbatch --array=1,2 rename_fasta_sequences.sh`
jobID: 23961582     FAILED
jobID: 24054997     FAILED
jobID: 24055258     FAILED
jobID: 24055286     FAILED no python, change to python3
jobID: 24055373     FAILED
jobID: 24055445     FAILED
jobID: 24055499     

