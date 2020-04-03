#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 2			# nr of cores/ nodes
#SBATCH -t 00:20:00		# time needed (dd-hh:mm:ss)
#SBATCH -J FastQC_DNA		# a name for your job

# Load modules
module purge
module load bioinfo-tools
module load FastQC

# run 'fastqc' on '.fq.gz' files, to get the quality report on the Illumina DNA pair-end reads
# fastqc --outdir=path_to_output_folder file_with_reads

extension=fq.gz
source_files=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/genomics_data/Illumina/
output_folder=/home/miba8458/2020.03_GenomeAnalysisCourse/results/reports/1fastqc_DNA_Illumina

my_file=${source_files}/*.${extension}

for i in $my_file 			#to print one by one
do
   fastqc --outdir="$output_folder" "$my_file"
done

