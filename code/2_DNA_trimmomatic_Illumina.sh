#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 2			# nr of cores/ nodes
#SBATCH -t 01:00:00		# time needed (dd-hh:mm:ss)
#SBATCH -J Trimmomatic_DNA	# a name for your job
####################################

# Load modules
module purge
module load bioinfo-tools
module load trimmomatic
####################################

# run 'trimmomatic' on '.fq.gz' files, to do a quality trim on the Illumina DNA pair-end reads.
# java -jar <path to trimmomatic.jar> PE [-version] [-threads <threads>] [-phred33|-phred64] [-trimlog <trimLogFile>] [-quiet] [-validatePairs] [-basein <inputBase> | <inputFile1> <inputFile2>] [-baseout <outputBase> | <outputFile1P> <outputFile1U> <outputFile2P> <outputFile2U>] <trimmer1>...
####################################

# Input sources
source_files=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/genomics_data/Illumina/
output_folder=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2_DNA_trimmomatic_Illumina_1/		#output saved in "scratch" folder
mkdir -p ${output_folder}		# creates the output folders if they don't exist yet

in_file1=E745-1.L500_SZAXPI015146-56_1_clean.fq.gz
in_file2=E745-1.L500_SZAXPI015146-56_2_clean.fq.gz
out_file_basename=E745-1.L500_SZAXPI015146-56_clean.fq.gz

slurm_out=/home/miba8458/2020.03_GenomeAnalysisCourse/results/reports/2trimmomatic_fastqc_DNA_Illumina/	# move "slurm.out" file to "results" folder 
####################################

# Code to run
   java -jar $TRIMMOMATIC_HOME/trimmomatic.jar PE -threads 2 -phred64 -trimlog ${output_folder}trimlog.txt ${source_files}${in_file1} ${source_files}${in_file2} –baseout ${out_file_basename} LEADING:10 TRAILING:10 SLIDINGWINDOW:4:10 MINLEN:50

mv *.out ${slurm_out}
