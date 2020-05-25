#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 1			# nr of cores/ nodes
#SBATCH -t 01:00:00		# time needed (dd-hh:mm:ss)
#SBATCH -J Prokka_Canu	# a name for your job
####################################

# Load modules
module purge
module load bioinfo-tools
module load prokka
module load artemis
####################################

# annotate assemblies with 'prokka'

# Choose the names of the output files
# prokka --outdir mydir --prefix mygenome contigs.fa

# Visualize it in Artemis
# art mydir/mygenome.gff
####################################

# Input sources
input_Canu_Pacbio=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/5_DNA_Pilon_onCanu_PacBio/tig01
output_directory=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/7_DNA_prokka_onCanu_chromosome
####################################

# Code to run
prokka --outdir ${output_directory} \
--prefix prokka_canu \
${input_Canu_Pacbio}

#art mydir/prokka_canu.gff
