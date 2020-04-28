#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 1			# nr of cores/ nodes
#SBATCH -t 01:00:00		# time needed (dd-hh:mm:ss)
#SBATCH -J Quast_Canu_PacBio_ref	# a name for your job
####################################

# Load modules
#module purge
module load bioinfo-tools
module load quast
####################################

# evaluate assemblies with 'quast'

# python quast.py [options] <contig_file(s)>
####################################

# Input sources
input_Canu_Pacbio=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/5_DNA_Pilon_onCanu_PacBio/pilon_output_canu_nano.fasta
intput_Spades_Nano=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2a_DNA_spades_Nano_Illumina/contigs.fasta
output_folder_name=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/6x_DNA_quast_Canu_vs_Spades
####################################

# Code to run
quast.py ${input_Canu_Pacbio} \
-R ${intput_Spades_Nano} \
-o ${output_folder_name}
