#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 1			# nr of cores/ nodes
#SBATCH -t 01:00:00		# time needed (dd-hh:mm:ss)
#SBATCH -J synteny_Spades	# a name for your job
####################################

# Load modules
module purge
module load bioinfo-tools
module load blast
module load artemis
####################################

# synteny comparison with 'blast' and 'artemis ACT'

# Make a reference file

# Visualize it in Artemis ACT
# act
####################################

# Input sources
input_Spades_Nano=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2a_DNA_spades_Nano_Illumina/contigs.fasta
reference_file=/home/miba8458/2020.03_GenomeAnalysisCourse/data/GCF_000174395.2_ASM17439v2_genomic.fna
output_directory=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/8a_DNA_blast_act_onCanu
####################################

# Code to run
makeblastdb -in ${reference_file} -dbtype 'nucl' -out db/ref_db -parse_sequids

blastn -db ${reference_file} -query ${input_pilon_Canu_Pacbio} -outfmt 6 > pilon_vs_ref.act

# open user interface
act
