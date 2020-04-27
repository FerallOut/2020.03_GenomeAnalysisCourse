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
input_Canu_Pacbio=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2_DNA_canu_PacBio/canu_pacbio.contigs.fasta
output_folder_name=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/3_DNA_quast_onCanu_PacBio
reference_file=/home/miba8458/2020.03_GenomeAnalysisCourse/data/GCF_000174395.2_ASM17439v2_genomic.fna.gz
####################################

# Code to run
quast.py ${input_Canu_Pacbio} \
-R ${reference_file} \
-o ${output_folder_name}
