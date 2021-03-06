#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 2			# nr of cores/ nodes
#SBATCH -t 02:20:00		# time needed (dd-hh:mm:ss)
#SBATCH -J FastQC_RNA		# a name for your job
####################################

# Load modules
module purge
module load bioinfo-tools
module load FastQC
####################################

# run 'fastqc' on '.fq.gz' files, to get the quality report on the RNA reads
# fastqc --outdir=path_to_output_folder file_with_reads
####################################

# Input sources
extension=fastq.gz                 # work only on '.fastq.gz' files
source_files_BHI=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/transcriptomics_data/RNA-Seq_BH/
output_folder_BHI=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/9_fastqc_RNA_BHI

mkdir -p ${output_folder_BHI} ${output_folder_serum}	# creates the output folders if they don't exist y
####################################

# Code to run for BHI files
my_file_BHI=${source_files_BHI}*.${extension}

for i in $my_file_BHI 		
do
   fastqc --extract --outdir="$output_folder_BHI" $my_file_BHI
done

mv *.out ${output_folder_BHI}
