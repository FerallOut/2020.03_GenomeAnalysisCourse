## Project Execution

The outline of the approach can be found in the [Project Plan](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/wiki/Project-Plan-with-workflow-and-data-management#project-plan). Each of the analysis has a separate entry complete with the explanations, basic code structure, results and comments. The full scripts for the code can be found in the [Code](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/code) folder. The extra questions are answered within the description of the method.

### Genome assembly on​ _E. faecium_  
The first of the three main analysis to be done is genome assembly on _E. faecium_. As detailed in the [Project Plan](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/wiki/Project-Plan-with-workflow-and-data-management#project-plan), there are 2 different approaches to doing this: 
1. Before starting, do quality control of the reads using **FastQC**, and if needed, trim the reads with **Trimmomatic**:
     1) QC for Illumina
     2) Trimming Illumina?
     3) QC for PacBio
     4) Trimming for PacBio
     5) QC for NanoPore
     4) Trimming for NanoPore  
  
2. do assembly on long reads (PacBio, Nanopore) and include Illumina reads for polishing:    
   A) genome assembly with **Canu** using (cleaned) reads  
   B) assembly evaluation with **Quast** and **Mummerplot**  
   C) polish assembly with Illumina short reads by:  
            &emsp; a) mapping the short reads to the assembly using **BWA-MEM**  
            &emsp; b) correct the genome assembly using **Pilon**   
   D) assembly evaluation with **Quast** and **Mummerplot**  
  
3. do assembly on short Illumina reads and include long reads as well to assemble the contigs correctly:  
   A) genome assembly with **SPAdes**   
   B) assembly evaluation with **Quast** and **Mummerplot**  
***
1. Quality control with **FastQC**:  
Low quality input data can lead to errors or artefacts later in the subsequent analysis steps. Therefore we need to check the quality of the data and if necessary, to remove parts of the reads or ever complete reads, if they are below the threshold we set. Other problems might be the presence of adapters in the reads. Recheck by doing another quality control.  
The software I use, **FastQC** has a variety of graphical depictions of read quality. It can take in 'BAM', 'SAM' or 'FastQ' files. In my case, I have '.fq' files that are structured like this:  
   * a sequence identifier with information about the sequencing run and the cluster (starts with **@**)
   * sequence
   * a separator
   * quality scores of base calling - in encoded as ASCII character; the character varies depending on what Phred quality score was used (e.g. Phred+33)  

To check if the reads are single or paired end, you can look at the number of files with reads and at the reads within the files. If the reads are paired end, then you would have 2 de-interleaved files, one for each pair (e.g. R1.fastq and R2.fastq). Else, if you have just one file, one can parse through the data to make sure all the IDs are unique. If they are not unique, you have paired ends in an interleaved file.   
`module load bioinfo-tools`   
`module load samtools`  
`zcat E745-1.L500_SZAXPI015146-56_1_clean.fq.gz | head` # check the first few lines to get a sense of the IDs  
   * in my case, the first ID is: '@FCC171FACXX'  
   * so I use the next line to check if it is unique:  
`zgrep @FCC171FACXX E745-1.L500_SZAXPI015146-56_1_clean.fq.gz | head -100000  | sort | uniq -c | sort -rgk 1,1 | head`  
   * the results show that my IDs are unique in each file, therefore _I have paired end reads separated in 2 files_.  
  
What is the accepted minimal quality for a read? It varies on the overall quality of the sequencing and the amount of data you have. For the various modules, there are different pass/fail parameters. For example, per base quality raises an error if the median value is < 25.  
  
   * basic command:  
  'fastqc [-o output dir] [--(no)extract] [-f fastq|bam|sam] [-c contaminant file] seqfile1 .. seqfileN'  
  
     1) QC for Illumina
*code in file: '1a_DNA_trimmomatic_Illumina.sh' 


Extra-questions to answer

- How is the quality of your data?
- What can generate the issues you observe in your data? Can these cause any problems during subsequent analyses?
     1) QC for Illumina
     2) Trimming Illumina?
     3) QC for PacBio
     4) Trimming for PacBio
     5) QC for NanoPore
     4) Trimming for NanoPore

     




