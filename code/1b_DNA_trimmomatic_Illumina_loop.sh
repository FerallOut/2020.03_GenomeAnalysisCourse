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
output_folder=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2_DNA_trimmomatic_Illumina_2/		#output saved in "scratch" folder
mkdir -p ${output_folder}		# creates the output folders if they don't exist yet

in_file1=E745-1.L500_SZAXPI015146-56_1_clean.fq.gz
in_file2=E745-1.L500_SZAXPI015146-56_2_clean.fq.gz
out_file_basename=E745-1.L500_SZAXPI015146-56_clean.fq.gz

slurm_out=/home/miba8458/2020.03_GenomeAnalysisCourse/results/reports/2_DNA_trimmomatic_fastqc_DNA_Illumina/	# the path to the folder where "slurm.out" file will be moved to ("results" folder)
mkdir -p ${slurm_out}

threshold_quality="10 15 20 25 28"
min_len="25 50"
####################################

# Code to run
# !code bug: if you use -basein or -baseout, you need to put these options _before_ the explicit file names - even if this means putting the templated output files (via -baseout) before the explicit input files. 

for threshold in ${threshold_quality}
do
  for len in ${min_len}
  do
    ${output_folder}$trim_Q${threshold}_Len${len}
   java -jar $TRIMMOMATIC_HOME/trimmomatic.jar PE -threads 2 -phred64 -trimlog ${output_folder}trimlog.txt -baseout ${output_folder}${out_file_basename}_Q${threshold}_Len${len} ${source_files}${in_file1} ${source_files}${in_file2} LEADING:${threshold} SLIDINGWINDOW:4:10 MINLEN:${len}                       #dropped TRAILING 10
  done
done

mv *.out ${slurm_out}    # move "slurm.out" file to "results" folder
