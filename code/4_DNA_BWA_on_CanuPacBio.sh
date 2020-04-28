#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 1			# nr of cores/ nodes
#SBATCH -t 01:00:00		# time needed (dd-hh:mm:ss)
#SBATCH -J bwa_Canu_PacBio	# a name for your job
####################################

# Load modules
module purge
module load bioinfo-tools
module load bwa
module load samtools
####################################

# map Illumina reads to PacBio assembly with 'bwa'
# prep file for Pilon using 'samtools' (needs to be indexed again, bam format, and for that needs to be sorted before)

# bwa index [-p prefix] [-a algoType] <in.db.fasta> 
# bwa mem [-aCHMpP] [-t nThreads] [-k minSeedLen] [-w bandWidth] [-d zDropoff] [-r seedSplitRatio] [-c maxOcc] [-A matchScore] [-B mmPenalty] [-O gapOpenPen] [-E gapExtPen] [-L clipPen] [-U unpairPen] [-R RGline] [-v verboseLevel] db.prefix reads.fq [mates.fq] 
####################################

# Input sources
input_Canu_Pacbio=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2_DNA_canu_PacBio/canu_pacbio.contigs.fasta
source_Ill_files=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/genomics_data/Illumina/
in_file1=E745-1.L500_SZAXPI015146-56_1_clean.fq.gz
in_file2=E745-1.L500_SZAXPI015146-56_2_clean.fq.gz

output_folder_name=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/4_DNA_bwa_onCanu_PacBio
mkdir -p ${output_folder_name}		# creates the output folders if they don't exist yet
####################################

# Code to run
# BWA first needs to construct the FM-index for the contigs resulted from Canu on PacBio sequences 
bwa index -p ${output_folder_name}/pacbio_index ${input_Canu_Pacbio}

# Alignment algorithms are invoked with sub-command 'mem' for the BWA-MEM algorithm
# the algorithm works by seeding alignments with maximal exact matches (MEMs) and then extending seeds with the affine-gap Smith-Waterman algorithm (SW). 
# -M to flag shorter split hits as secondary to longer hits 
# bwa mem pacbio_index ${source_files}${in_file1} ${source_files}${in_file2} > ${output_folder_name}/align_ill_to_pacbio.sam 
bwa mem -M ${output_folder_name}/pacbio_index ${source_Ill_files}${in_file1} ${source_Ill_files}${in_file2} > ${output_folder_name}/align_ill_to_pacbio.sam
#samtools sort -o ${output_folder_name}/align_ill_to_pacbio_sorted.bam

# convert 'sam' to 'bam' (-b) and sort the 'bam' file
#samtools view -u ${output_folder_name}/align_ill_to_pacbio.sam -o ${output_folder_name}/align_ill_to_pacbio.bam
# sort the 'bam' file
#samtools sort ${output_folder_name}/align_ill_to_pacbio.sam -o ${output_folder_name}/align_ill_to_pacbio_sorted.bam
# index the sorted bam file
#samtools index ${output_folder_name}/align_ill_to_pacbio_sorted.bam



