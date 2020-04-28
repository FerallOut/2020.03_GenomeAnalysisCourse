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
# prep file for Pilon using 'samtools' (needs to be indexed again, and for that needs to be sorted before)

# bwa index [-p prefix] [-a algoType] <in.db.fasta> 
# bwa mem [-aCHMpP] [-t nThreads] [-k minSeedLen] [-w bandWidth] [-d zDropoff] [-r seedSplitRatio] [-c maxOcc] [-A matchScore] [-B mmPenalty] [-O gapOpenPen] [-E gapExtPen] [-L clipPen] [-U unpairPen] [-R RGline] [-v verboseLevel] db.prefix reads.fq [mates.fq] 
####################################

# Input sources
input_Canu_Pacbio=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2_DNA_canu_PacBio/canu_pacbio.contigs.fasta
source_Ill_files=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/genomics_data/Illumina/
in_file1=E745-1.L500_SZAXPI015146-56_1_clean.fq.gz
in_file2=E745-1.L500_SZAXPI015146-56_2_clean.fq.gz

output_folder_name=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/4_DNA_bwa_onCanu_PacBio
####################################

# Code to run
# BWA first needs to construct the FM-index for the contigs resulted from Canu on PacBio sequences 
bwa index -p pacbio_index ${input_Canu_Pacbio}

# Alignment algorithms are invoked with sub-command 'mem' for the BWA-MEM algorithm
# the algorithm works by seeding alignments with maximal exact matches (MEMs) and then extending seeds with the affine-gap Smith-Waterman algorithm (SW). 
# -M to flag shorter split hits as secondary to longer hits 
bwa mem pacbio_index ${source_files}${in_file1} ${source_files}${in_file2} > align_ill_to_pacbio.sam

samtools sort -T tmp -o aln-pb.sorted.bam aln-pb.bam
samtools view -bt ref.fa.fai aln-pe.sam > aln-pb.bam
samtools index aln-pb.sorted.bam
