#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 2			# nr of cores/ nodes
#SBATCH -t 06:30:00		# time needed (dd-hh:mm:ss)
#SBATCH -J Canu_DNA_PacBio		# a name for your job
####################################

# Load modules
module purge
module load bioinfo-tools
module load canu
####################################

# run 'canu' on PacBio reads, to assemble the genome

# canu -p name_prefix_for_resulting_files -d output_folder \
# genomeSize=(nr_in_milion)m \
# -pacbio-raw files_with_reads
####################################

# Input sources
extension=fastq.gz               # work only on '.fastq.gz' files
source_files=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/genomics_data/PacBio/
prefix_files=canu_pacbio         # -p is the assembly prefix and will be prefixed to all output Files
output_folder_name=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2_DNA_canu_PacBio
                                 #-d is the directory that it will make and write all the files to.
genome_size=2.8                  # size of chromosome from paper 
####################################

# Code to run

canu -p ${prefix_files} -d ${output_folder_name} \
genomeSize=${genome_size}m \
-pacbio-raw ${source_files}*.${extension}
