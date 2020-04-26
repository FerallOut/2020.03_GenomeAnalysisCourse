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
https://github.com/ablab/spades
    
SPAdes performs a trimming of the read data.

spades.py [options] -o <output_dir>
***********
Input data
Specifying single library (paired-end or single-read)
SPAdes added support for taking short and long reads as inputs in SPAdes 3.0
    
--12 <file_name>     File with interlaced forward and reverse paired-end reads.

-1 <file_name>     File with forward reads.

-2 <file_name>     File with reverse reads.

--merged <file_name>     File with merged paired reads. If the properties of the library permit, overlapping paired-end reads can be merged using special software. Non-empty files with (remaining) unmerged left/right reads (separate or interlaced) must be provided for the same library for SPAdes to correctly detect the original read length.

-s <file_name>     File with unpaired reads.    
*********
- SPAdes takes as input paired-end reads, mate-pairs and single (unpaired) reads in FASTA and FASTQ. 
- For IonTorrent data SPAdes also supports unpaired reads in unmapped BAM format (like the one produced by Torrent Server). However, in order to run read error correction, reads should be in FASTQ or BAM format. Sanger, Oxford Nanopore and PacBio CLR reads can be provided in both formats since SPAdes does not run error correction for these types of data.

-To run SPAdes 3.14.0 you need at least one library of the following types:

    Illumina paired-end/high-quality mate-pairs/unpaired reads
    IonTorrent paired-end/high-quality mate-pairs/unpaired reads
    PacBio CCS reads

- Illumina and IonTorrent libraries should not be assembled together. All other types of input data are compatible. SPAdes should not be used if only PacBio CLR, Oxford Nanopore, Sanger reads or additional contigs are available.

********************
SPAdes stores all output files in <output_dir> , which is set by the user.

    <output_dir>/corrected/ directory contains reads corrected by BayesHammer in *.fastq.gz files; if compression is disabled, reads are stored in uncompressed *.fastq files
    <output_dir>/scaffolds.fasta contains resulting scaffolds (recommended for use as resulting sequences)
    <output_dir>/contigs.fasta contains resulting contigs
    <output_dir>/assembly_graph.gfa contains SPAdes assembly graph and scaffolds paths in GFA 1.0 format
    <output_dir>/assembly_graph.fastg contains SPAdes assembly graph in FASTG format
    <output_dir>/contigs.paths contains paths in the assembly graph corresponding to contigs.fasta (see details below)
    <output_dir>/scaffolds.paths contains paths in the assembly graph corresponding to scaffolds.fasta (see details below)

        
        