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
extension=fastq.gz
source_files=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/transcriptomics_data/RNA-Seq_Serum/untrimmed/
output_folder=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/9_RNA_trimmomatic_serum		#output saved in "scratch" folder
mkdir -p ${output_folder}		# creates the output folders if they don't exist yet

base_name_in="ERR1797969_pass_ ERR1797970_pass_ ERR1797971_pass_"

out_file_basename=serum
####################################

# Code to run
# !code bug: if you use -basein or -baseout, you need to put these options _before_ the explicit file names - even if this means putting the templated output files (via -baseout) before the explicit input files. 

for name in ${base_name_in}
do
  java -jar $TRIMMOMATIC_HOME/trimmomatic.jar PE -threads 2 -phred64\
  -trimlog ${output_folder}trimlog.txt -baseout ${output_folder}${out_file_basename}\
  ${source_files}/"${base_name_in}1*" ${source_files}/"${base_name_in}2*"\
  ${output_folder}/${base_name_in}1P.extension ${output_folder}/${base_name_in}1U.extension\
  ${output_folder}/${base_name_in}2P.extension ${output_folder}/${base_name_in}2U.extension\
  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:10 TRAILING:20 SLIDINGWINDOW:4:15 MINLEN:50
done
