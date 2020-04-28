#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 1			# nr of cores/ nodes
#SBATCH -t 01:00:00		# time needed (dd-hh:mm:ss)
#SBATCH -J pilon_Canu_PacBio	# a name for your job
####################################

# Load modules
module purge
module load bioinfo-tools
module load Pilon
####################################

# correct the PacBio assembly 
# pilon --genome genome.fasta [--frags frags.bam] [--jumps jumps.bam] [--unpaired unpaired.bam]	[...other options...]

# --frags <frags.bam> for paired-end sequencing of DNA fragments, such as Illumina paired-end reads of fragment size <1000bp
# --bam <any.bam> (sorted in coordinate order and indexed)
####################################

# Input sources
input_Canu_Pacbio=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2_DNA_canu_PacBio/canu_pacbio.contigs.fasta
input_Ill_alignment=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/4_DNA_bwa_onCanu_PacBio

output_folder=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/5_DNA_Pilon_onCanu_PacBio
mkdir -p ${output_folder}		# creates the output folders if they don't exist yet
####################################

# Code to run
pilon --genome ${input_Canu_Pacbio} --frags ${input_Ill_alignment} --outdir ${output_folder} --output pilon_
