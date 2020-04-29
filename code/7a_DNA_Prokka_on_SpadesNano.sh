#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 1			# nr of cores/ nodes
#SBATCH -t 01:00:00		# time needed (dd-hh:mm:ss)
#SBATCH -J Prokka_Spades	# a name for your job
####################################

# Load modules
module purge
module load bioinfo-tools
module load prokka
####################################

# annotate assemblies with 'prokka'

# Choose the names of the output files
# prokka --outdir mydir --prefix mygenome contigs.fa

# Visualize it in Artemis
# art mydir/mygenome.gff
####################################

# Input sources
input_Spades_Nano=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2a_DNA_spades_Nano_Illumina/contigs.fasta
output_directory=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/7a_DNA_prokka_onSpades
####################################

# Code to run
prokka --outdir ${output_directory} \
--prefix prokka_spades \
${input_Spades_Nano}

art mydir/prokka_spades.gff
