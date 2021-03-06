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
input_Spades=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2a_DNA_spades_Nano_Illumina/contigs.fasta
reference_file_475=/home/miba8458/2020.03_GenomeAnalysisCourse/data/GCF_000174395.2_ASM17439v2_genomic.fna
reference_file_VRE=/home/miba8458/2020.03_GenomeAnalysisCourse/data/GCF_009697285.1_ASM969728v1_genomic.fna

output_directory=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/8a_DNA_blast_act_Spades
####################################

# Code to run
makeblastdb -in ${input_Spades} -dbtype nucl -out spades

blastn -query ${reference_file_475} -out spades_475.crunch -db spades -outfmt 6  > spades_vs_ref475.act
blastn -query ${reference_file_VRE} -out spades_VRE.crunch -db spades -outfmt 6 > spades_vs_refVRE.act

# open user interface
act
