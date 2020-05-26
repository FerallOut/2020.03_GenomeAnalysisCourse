#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 2			# nr of cores/ nodes
#SBATCH -t 05:00:00		# time needed (dd-hh:mm:ss)
#SBATCH -J Trimmomatic_RNA	# a name for your job
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
source_files=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/transcriptomics_data/RNA-Seq_BH/
output_folder=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/9_RNA_trimmomatic_BHI/		#output saved in "scratch" folder
mkdir -p ${output_folder}		# creates the output folders if they don't exist yet

out_file_basename=BHI

slurm_out=/home/miba8458/2020.03_GenomeAnalysisCourse/results/reports/2_DNA_trimmomatic_fastqc_DNA_Illumina/	# the path to the folder where "slurm.out" file will be moved to ("results" folder)
mkdir -p ${slurm_out}
####################################

# Code to run
# !code bug: if you use -basein or -baseout, you need to put these options _before_ the explicit file names - even if this means putting the templated output files (via -baseout) before the explicit input files. 

java -jar $TRIMMOMATIC_HOME/trimmomatic.jar PE -threads 2 -phred64\
-trimlog ${output_folder}trimlog.txt -baseout ${output_folder}${out_file_basename}\
${source_files}${in_file1} ${source_files}${in_file2} LEADING:10 SLIDINGWINDOW:4:10 MINLEN:25	# dropped TRAILING 10

mv *.out ${slurm_out}	# move "slurm.out" file to "results" folder
