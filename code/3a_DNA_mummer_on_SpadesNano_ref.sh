#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 1			# nr of cores/ nodes
#SBATCH -t 00:30:00		# time needed (dd-hh:mm:ss)
#SBATCH -J Mummer_Spades_Nano+Ill_ref	# a name for your job
####################################

# Load modules
module purge
module load bioinfo-tools
#module load MUMmer
####################################

# evaluate assemblies with 'MUMmerplot'

# mummer [options] <reference file> <query file1> . . . [query file32]
# find all maximal unique matches (-mum) between the reference and query on both the forward and reverse strands (-b) 
# and report all the match positions relative to the forward strand (-c). Output is to file 'mummer.mums'. 

# mummerplot -x "[0,275287]" -y "[0,265111]" -postscript -p mummer mummer.mums
# plot all of the MUMs in the 'mummer.mums' file in postscript format (-postscript) between the given ranges for the X and Y axes (necessary). 
# The four output files are prefixed by the string specified with the -p option. 
# mummer.ps is the postscript plot generated by the gnuplot script (displayed with ghostview).
####################################

# Input sources
input_Spades_Nano_Illumina=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2a_DNA_spades_Nano_Illumina/contigs.fasta

# I could not make 'nucmer' work before I have unzipped the reference file 
reference_file=/home/miba8458/2020.03_GenomeAnalysisCourse/data/GCF_000174395.2_ASM17439v2_genomic.fna
####################################

# Code to run
nucmer ${reference_file} ${input_Spades_Nano_Illumina}

mummerplot --png out.delta
