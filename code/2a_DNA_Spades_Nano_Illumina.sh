#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 1			# nr of cores/ nodes
#SBATCH -t 04:00:00		# time needed (dd-hh:mm:ss)
#SBATCH -J Spades_DNA	# a name for your job
####################################

# Load modules
#module purge
module load bioinfo-tools
module load spades
####################################

# run 'spades' on DNA reads, to assemble the genome

# spades.py [options] -o <output_dir>
####################################

# Input sources
input_PacBio=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/genomics_data/PacBio/
            # file names: *.subreads.fastq.gz
input_Illumina=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/genomics_data/Illumina/
            # forward and reverse file names: *_1_clean.fq.gz and *_2_clean.fq.gz
input_Nanopore=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/genomics_data/Nanopore/
            # just 1 file: E745_all.fasta.gz
            # '--nanopore' specifies this file type 
output_folder_name=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/3a_DNA_spades_Nano_Illumina
####################################

# Code to run

spades.py --pe1-1 ${input_Illumina}*_1_clean.fq.gz --pe1-2 ${input_Illumina}*_2_clean.fq.gz \
--nanopore ${input_Nanopore}E745_all.fasta.gz \
-o ${output_folder_name}
