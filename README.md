## Project Plan

### Introduction

The data that I am working on is extracted from the paper:  
"RNA-seq and Tn-seq reveal fitness determinants *Enterococcus faecium* during growth in human serum of vancomycin-resistant" - Zhang X, de Maat V, Guzmán Prieto A.M, Prajsnar T.K, Bayjanov J.R, de Been M, Rogers M.R.C, Bonten M.J.M, Mesnage S, Willems R.J.L, van Schaik W.  
  
The aim of this project is to determine which genetic elements are responsible for the growth of *Enterococcus faecium* vancomycin-resistant strain in human serum. This is important because *E. faecium* frequently causes bloodstream infections in hospitalized patients. After a *de-novo* assembly of the genome of *E. faecium*, is required to do a differential expression analysis of the transcriptome between 2 different states: the bacteria grown in rich medium or in human serum.  
  
The genome is available from NCBI Genbank (**CP014529 - CP014535**). The available DNA, RNA and transposons reads are in FASTQ format, and are arranged like this:    
  
![directory_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/short_data_dir_tree.png)  
  
### Extracting information from paper  
#### Genomics:   
- DNA-seq:  
    - short reads: Illumina HiSew 100 bp pair-end  
    - long reads: Pacific Biosciences RS II SMRT  
    - long reads: MinION with R7 flowcell   
- genomic assembly of corrected PacBio reads: Celera (v. 8.1)
    > corrected with what?  
- correct the assembly: align Illumina reads with BWA (v. 0.7.9a)  
    - indexing with default parameters  
    - aligning with BWA-MEM algorithm and *-M* option  
- QC on the 15 resulting contigs:  
    - 1 covers the entire chromosome 
        - 2.77 Mbp or 2.765.010 nt
    - discard low-coverage contigs  
    - remain 10 contig:  
        - 5 circular plasmids   
        - 5 non-overlapping contigs:  
            - aligning against the NCBI Genbank -> they are part of the pMG1 *E. faecium* plasmid  
            > is it a plasmid used for creating the library? Used for cloning?  
            - to close the 6th plasmid, they did gap-spanning PCR and sequencing. This closed most gaps, except one. Afterwards they did an assebly of Illumina reads together with MinION 2D reads, assembling them with SPAdes (v. 3.0). The resulting contig closed the last gap on the 6th plasmid.  
        - so in total 6 plasmids (9.3 kbp - 223.7 kbp)  
- Sequence coverage - done with SAMtools (v. 0.1.18) using short reads alignments to the assembly, which were generated with BWA (v. 0.7.9a).   
- check for base-calling and assebly errors by aligning short reads to assebled contigs - using SAMtools (v. 0.1.18). Correction by using the consensus of aligned reads.  
- annotation using Prokka (v. 1.10)   
    - 3 095 predicted coding sequences  
  
#### Filogenetic analysis  
- a maximum likelihood phylogenetic tree, based on the core genome of *E. facium* E745 and an additional 72 *E. facium* strains - using ParSNP, with settings -c (forcing inclusion of all genome sequences) and -x (enabling recombination detection and filtering).
- visualize phylogenetic tree with MEGA (v. 7.0.26)  
    - *E. faecium* is part of clade A-1 strain  
- antibiotic resistance genes were identified with ResFinder.
    - a pathogenicity island, with *esp* gene (involved in biofilm formation and infection)  
    - vancomycin resistance genes are:
        - of *vanA* type and are carried on the 32.4 kbp plasmid pE745-2.  
        - the trimethoprim resistance gene *dfrG* on plasmid pE745-6.  
        - macrolide resistance gene *msrC* encoded on the chromosome  
  
#### Transcriptomics:  
- RNA-seq: 100 bp paired end reads on Illumina HiSeq 2500  
- analyse with Rockhopper, default settings.  
    - 27.8% of genes were differentially expressed between the 2 growth conditions  
    - among the most upregulated genes when *E. faecium* grows in serum is a gene cluster with a role in purine biosynthesis  
    
#### Transposon mutant library:    
- Tn-seq:  
    - Illumina HiSeq 2500  
- analysis: 
    - sequences split on Galaxy platform  
    - 16-mer were mapped to the E745 genome with Bowtie 2.  
    - results were sorted and counted by IGV using a 25-nucleotide window and then summed over the gene. Read mapping to the final 10% of a gene were discarded as these insertions may not inactivate gene function.  
    > what does this mean?  
    - read counts per gene were then normalized to the total nr of reads that mapped to the genome in each replicate.
        - RPKM (reads per klobase per million input reads) = (nr of reads mapped to a gene x 10^6)/(total mapped input reads in the sample x gene length in kbp) 
    - statistical analysis done with Cyber-T (BH corrected p-value was < 0.05 and the difference in abundance of the transposon mutant during growth in BHI and serum was >2)  
    - upregulated in serum are genes involved in *de novo* nucleotide biosynthesis (e.g. *pyrK_2*, *pyrF*, *purD*, *purH*) and a gene encoding an phosphotransferase system subunit (*manY_2*) - carbohydrate metabolism.  
        
            
            
### Organization of new data  
  
- In order to keep the project organized, I have decided on the types of files that I will have and on the organizational framework of the project.  
- To create all the folders that I need, I wrote the script **"0directory_tree.sh"** to automaticall create the directory tree  
    - to use it, invoke it like this:   
`./0directory_tree.sh path_to_where_you_want_the_new_folder project_name`  
  
- this is the resulting directory tree:  
  
![New_dir_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/organiz_dir_tree2.png)  
<!-- ![](images/long_data_dir_tree2.png) -->  
  
The script for each step and each software goes into a folder with its name in **code** folder and the analysis result from each software go into a folder with the software's name in **results** folder.
*** 

### Workflow  
  
1. Genome assembly of long reads (PacBio)  
    - use **Canu** and **SPAdes**, each with various parameters     
2. Quality control of the short DNA reads (Illumina)  
    - use **FASTQC** and generate a quality control report  
3. Pre-processing the short reads    
    - **Trimmomatic** and do another quality control  
4. Mapping processed Illumina reads to PacBio assembly:  
    - **BWA-MEM** for mapping   
    - **Pilon** to combine genome assembly  
5. Evaluate genome assembly  
    - **QUAST**, **BCFtools**, **MUMmerplot**  
6. Genome assembly annotation  
    - **Prokka**   
7. Homology search  
    - **Blastn**   
8. Synteny  
    - **ACT**  
  
9. Quality control of the RNA reads (Illumina)  
    - use **FASTQC** and generate a quality control report  
10. Pre-processing the short reads    
    - **Trimmomatic** and do another quality control  
11. RNA Mapping  
    - **BWA-MEM**  
12. Counting RNA reads  
    - **HTseq-count**  
13. Differential expression   
    - **DEseq2**  
14. Biological interpretation of results  
    - **R**  
***  
  
### Deadlines 

|Done?|Day| Hours | Prokaryotes|
|:---:|:---:|:---:|:------|
|[x]|24/3 | 2 |Seminar|
|[x]|30/3 |4 |Project planning|
|[ ]|17/4 |4 |Genome Assembly + Genome annotation |
|[ ]|29/4 |4 |Comparative genomics|
|[ ]|8/5 |4| RNA mapping |  

***  
  
### Estimated analyses and their running time  
  
| Analysis | Software |Running time (for paper I)|
|------|------|------|
| Reads preprocessing | Trimmomatic | ~ 50 min per file (1 core) |
| DNA assembly | Spades | (short reads + long reads) ~ 2 h (1 core) |
|  | Canu | ~ 4,5 h (1 core) |
| Assembly evaluation | Quast | < 15 min (1 core) |
|  | MUMmerplot | < 5 min (1 core) |
|  | BCFtools | ~ 90 min (1 core) |
| Annotation | Prokka | < 5 min (1 core) |
| Aligner | BWA | (paired-end reads): ~ 30 min (1 core) |
|  |  | (single reads): < 15 min (1 core) |
| Differential Expression | Htseq | (paired-end reads) ~ 2-7 h (1 core) |
|  |  | (single reads) < 10 min (1 core) |
|  | Deseq2 (R library) | Variable |
