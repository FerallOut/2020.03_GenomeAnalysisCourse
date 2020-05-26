#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 1			# nr of cores/ nodes
#SBATCH -t 02:00:00		# time needed (dd-hh:mm:ss)
#SBATCH -J bwa_Canu_PacBio	# a name for your job
####################################

# Load modules
module purge
module load bioinfo-tools
module load bwa
module load samtools
####################################

# map Illumina reads to PacBio assembly with 'bwa'
# prep file using 'samtools' (needs to be indexed again, bam format, and for that needs to be sorted before)

# bwa index [-p prefix] [-a algoType] <in.db.fasta> 
# bwa mem [-aCHMpP] [-t nThreads] [-k minSeedLen] [-w bandWidth] [-d zDropoff] [-r seedSplitRatio] [-c maxOcc] [-A matchScore] [-B mmPenalty] [-O gapOpenPen] [-E gapExtPen] [-L clipPen] [-U unpairPen] [-R RGline] [-v verboseLevel] db.prefix reads.fq [mates.fq] 
####################################

input_Canu_Pacbio=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2_DNA_canu_PacBio/canu_pacbio.contigs.fasta
source_serum_files=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/transcriptomics_data/RNA-Seq_Serum/ 

output_folder_rep1=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/10_RNA_bwa_BHI_onCanu/serum_rep1
output_folder_rep2=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/10_RNA_bwa_BHI_onCanu/serum_rep2
output_folder_rep3=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/10_RNA_bwa_BHI_onCanu/serum_rep3

mkdir -p ${output_folder_rep1} ${output_folder_rep2} ${output_folder_rep3}		# creates the output folders if they don't exist yet
####################################

# Code to run
# BWA first needs to construct the FM-index for the contigs resulted from Canu on PacBio sequences 
bwa index -p ${output_folder_rep1}/pacbio_index ${input_Canu_Pacbio}
bwa index -p ${output_folder_rep2}/pacbio_index ${input_Canu_Pacbio}
bwa index -p ${output_folder_rep3}/pacbio_index ${input_Canu_Pacbio}

# Alignment algorithms are invoked with sub-command 'mem' for the BWA-MEM algorithm
# the algorithm works by seeding alignments with maximal exact matches (MEMs) and then extending seeds with the affine-gap Smith-Waterman algorithm (SW). 
# -M to flag shorter split hits as secondary to longer hits 
# 'sort' outputs directly to 'bam' (no need for separate 'sam' to 'bam' conversion), and sorts

bwa mem -M ${output_folder_rep1}/pacbio_index ${source_serum_files}trim_paired_ERR1797969_pass_1.fastq.gz ${source_serum_files}trim_paired_ERR1797969_pass_2.fastq.gz | \
samtools sort -o ${output_folder_rep1}/align_serum_to_pacbio_sorted_rep1.bam
 
bwa mem -M ${output_folder_rep2}/pacbio_index ${source_serum_files}trim_paired_ERR1797970_pass_1.fastq.gz ${source_serum_files}trim_paired_ERR1797970_pass_2.fastq.gz | \
samtools sort -o ${output_folder_rep2}/align_serum_to_pacbio_sorted_rep2.bam

bwa mem -M ${output_folder_rep3}/pacbio_index ${source_serum_files}trim_paired_ERR1797971_pass_1.fastq.gz ${source_serum_files}trim_paired_ERR1797971_pass_2.fastq.gz | \
samtools sort -o ${output_folder_rep3}/align_serum_to_pacbio_sorted_rep3.bam


# index the sorted bam file
samtools index ${output_folder_rep1}/align_serum_to_pacbio_sorted_rep1.bam
samtools index ${output_folder_rep2}/align_serum_to_pacbio_sorted_rep2.bam
samtools index ${output_folder_rep3}/align_serum_to_pacbio_sorted_rep3.bam



