# Wed, 2020-04-15

to do:  
- [x] start the assembly with canu
- [x] start the assembly with spades
- [x] do some organizatorial stuff:  
    - [x] where is the needed data?  
    - [x] how it looks like?  
- [x] understand the results
- [x] save daily log 
- [x] push changes to git  
***  
- log in to Uppmax: ```ssh -AX username@rackham.uppmax.uu.se```  
- project number: **g2020008**  
- where to run analyses: **/home/username/**  
- where is the raw data: **/proj/g2020008/nobackup/private/1_Zhang_2017/**   
***  
CANU
-- Generating assembly 'canu_pacbio' in '/domus/h1/miba8458/2020.03_GenomeAnalysisCourse/scratch/2_DNA_canu_PacBio':
--    - correct raw reads.
--    - trim corrected reads.
--    - assemble corrected and trimmed reads.

canu [-correct | -trim | -assemble | -trim-assemble] \
  [-s <assembly-specifications-file>] \
   -p <assembly-prefix> \
   -d <assembly-directory> \
   genomeSize=<number>[g|m|k] \
   [other-options] \
   [-pacbio-raw | -pacbio-corrected | -nanopore-raw | -nanopore-corrected] *fastq
    
data location:
source_files=/home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/genomics_data/PacBio/
output_folder_name=/home/miba8458/2020.03_GenomeAnalysisCourse/scratch/2_DNA_canu_PacBio

6 '.fastq.gz' files 
*** 
outcome
files:
  * <prefix>.report - status messages, execution logs, Most of the analysis 
        * the histogram of read lengths
        * the histogram of k-mers in the raw and corrected reads
        * the summary of corrected data 
        * summary of overlaps
        * the summary of contig lengths.

You can use the k-mer corrected read histograms with tools like GenomeScope to estimate heterozygosity and genome size. In particular, histograms with more than 1 peak likely indicate a heterozygous genome. See the Canu FAQ for some suggested parameters.
    * <prefix>.contigs.fasta - assembled sequence where contigs are the primary output
    * <prefix>.unitigs.fasta - assembled sequence where unitigs are the primary output split at alternate paths
    * <prefix>.unassembled.fasta - assembled sequence where unassembled are the leftover pieces

***
    
SPADES

