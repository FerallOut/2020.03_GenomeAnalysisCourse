#!/bin/bash -l

#SBATCH -A g2020008		# code of the project
#SBATCH -p core			# core/ node
#SBATCH -n 4			# nr of cores/ nodes
#SBATCH -t 10:00:00		# time needed (dd-hh:mm:ss)
#SBATCH -J bwa_Canu_PacBio	# a name for your job
####################################

# Load modules
module purge
module load bioinfo-tools
module load htseq
####################################

input_mapped_RNA=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/10_RNA_bwa_second
input_annotation=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/7_DNA_prokka_onCanu/prokka_canu_rename.gff

output_folder=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/11_RNA_htseq_second
mkdir -p ${output_folder}		# creates the output folders if they don't exist yet
####################################

# Code to run

htseq-count -t CDS -i ID -f bam -s reverse \
	${input_mapped_RNA}/BHI_rep1/align_BHI_to_pacbio_sorted_rep1.bam \
	${input_mapped_RNA}/BHI_rep2/align_BHI_to_pacbio_sorted_rep2.bam \ 
	${input_mapped_RNA}/BHI_rep3/align_BHI_to_pacbio_sorted_rep3.bam \	
	${input_mapped_RNA}/serum_rep1/align_serum_to_pacbio_sorted_rep1.bam \
	${input_mapped_RNA}/serum_rep2/align_serum_to_pacbio_sorted_rep2.bam  \
	${input_mapped_RNA}/serum_rep3/align_serum_to_pacbio_sorted_rep3.bam \	
	${input_annotation} > ${output_folder}/all_counts_ID.txt

htseq-count -t CDS -i locus_tag -f bam -r pos \
	${input_mapped_RNA}/BHI_rep1/align_BHI_to_pacbio_sorted_rep1.bam \
        ${input_mapped_RNA}/BHI_rep2/align_BHI_to_pacbio_sorted_rep2.bam \
        ${input_mapped_RNA}/BHI_rep3/align_BHI_to_pacbio_sorted_rep3.bam \
        ${input_mapped_RNA}/serum_rep1/align_serum_to_pacbio_sorted_rep1.bam \
        ${input_mapped_RNA}/serum_rep2/align_serum_to_pacbio_sorted_rep2.bam  \
        ${input_mapped_RNA}/serum_rep3/align_serum_to_pacbio_sorted_rep3.bam \
        ${input_annotation} > ${output_folder}/all_counts_locus.txt

#htseq-count -t CDS -i ID -f bam -s reverse ${input_mapped_RNA}/serum_rep1/align_serum_to_pacbio_sorted_rep1.bam ${input_annotation} > ${output_folder}/serum_ERR1797969_rep1.txt 
 
