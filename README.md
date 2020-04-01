## Project Plan

### Introduction

The data that I am working on is extracted from the paper:  
"RNA-seq and Tn-seq reveal fitness determinants *Enterococcus faecium* during growth in human serum of vancomycin-resistant" - Zhang X, de Maat V, Guzmán Prieto A.M, Prajsnar T.K, Bayjanov J.R, de Been M, Rogers M.R.C, Bonten M.J.M, Mesnage S, Willems R.J.L, van Schaik W.  
  
The aim of this project is to determine which genetic elements are responsible for the growth of *Enterococcus faecium* vancomycin-resistant strain in human serum. This is important because *E. faecium* frequently causes bloodstream infections in hospitalized patients. After a *de-novo* assembly of the genome of *E. faecium*, is required to do a differential expression analysis of the transcriptome between 2 different states: the bacteria grown in rich medium or in human serum.  
  
The genome is available from NCBI Genbank (**CP014529 - CP014535**). The available DNA, RNA and transposons reads are in FASTQ format, and are arranged like this:    
  
![directory_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/short_data_dir_tree.png)  
  
### Organization of new data  
  
- In order to keep the project organized, I have decided on the types of files that I will have and on the organizational framework of the project.  
- To create all the folders that I need, I wrote the script **"0directory_tree.sh"** to automaticall create the directory tree  
    - to use it, invoke it like this:   
`./0directory_tree.sh path_to_where_you_want_the_new_folder project_name`  
  
- this is the resulting directory tree:  
  
![New_dir_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/organiz_dir_tree2.png)  
<!-- ![](images/long_data_dir_tree2.png) -->  
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
