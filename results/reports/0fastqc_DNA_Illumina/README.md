## Report on the QC of the Illumina short DNA reads  
### The contents of the fastq files:  
- Look at the header of each read in both files:  
`zcat E745-1.L500_SZAXPI015146-56_1_clean.fq.gz | head -n 10`  
  
>@FCC171FACXX:2:1101:2120:2201#CTTCCTCC/1
TCCCATCTGTTTCTATTATACATAATCAACTTTTAAATAGCTACCTTTTTTTCATAATTTTTTTAAAAAAATGAAAGTTATCTAAGGTTA  
\+  
bbbeeeeegggggiiiiiiiiiihiihihiiiiihiiighiiiiiiiiiiihihihiiiiiiiggggdeccccccbcccddccecccccc  
  
`zcat E745-1.L500_SZAXPI015146-56_1_clean.fq.gz | head -n 10`  
  
>@FCC171FACXX:2:1101:2120:2201#CTTCCTCC/2  
TAATGCAATCTCTGTGGAATTTTCGAAAGATTTATTTTTTTAATACAGTCTCAATATAACTATTCAAACATAAAATAACGTTATTTGATT  
\+  
bbbeeeeegggggighhiihiiihhehhiffghhhiiiiiifhhfhhhhheghihihihiihiihiiifgfdgeeeeeccddcccc_cbb   

    - structure:  
        1. Header - unique identifier  
            - starts with @  
            - Instrument ID (FCC171FACXX)  
            - Flowcell Lane (2)
            - tile number within the flowcell lane (1101)
            - X-position (2120)
            - Y-position (2201)
            - #CTTCCTCC - index number for a multiplexed sample
            - /1 - shows the member of a pair in a pair-read
        2. Base calls   
        3. Mid-line - starts with + usually empty
        4. Quality scores - per base signal
     
     > each member of a pair-read is in a separate file, with prefix "1" or "2".  
- check files:  
`zcat E745-1.L500_SZAXPI015146-56_2_clean.fq.gz | grep @ | wc -l`  
    > each file has 1666667 reads.

***  
  
### Commands:  
  
`module load bioinfo-tools  
module load FastQC`  
  
`fastqc --outdir=/home/miba8458/2020.03_GenomeAnalysisCourse/results/reports/0fastqc_DNA_Illumina /home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/genomics_data/Illumina/E745-1.L500_SZAXPI015146-56_*`  

- I obtained 2 reports that can be visualized with:  
  
`firefox E745-1.L500_SZAXPI015146-56_*.html &`  
  
### The quality of the reads in the 2 files:

- the reads have passed all the QC modules without triggering any warning or alert  
- for file 1 (E745-1.L500_SZAXPI015146-56_1_clean.fq.gz), **base quality** varies between 28 and 41, showing that the reads have a high quality. For file 2 (E745-1.L500_SZAXPI015146-56_2_clean.fq.gz), base quality varies a lot more, the overall base quality being between 2 and 41. In both cases, there is an overall tendency for base quality to drop towards the end of the reads. The plot didn't trigger a warning because the lower quantile is not < 10 nor is the median < 25.  
  
![New_dir_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/fastqc_Illumina_DNA_1base_qual.png)  

- overall: 
    - the **per sequence** quality score shows that most reads have a consistent high quality (the distribution is fairly tight in the upper range of the plot). Is is better for the first pair.
    - the **per tile sequence quality** shows that the quality scores are high and constant across all of the flowcell tile;  
    - the **per base sequence content** profile shows a uniform representation of each of the four bases with %A = %T and %G = %C, meaning that the library is diverse (no bias); 
    - normal **per sequence GC content**: normal distribution with the peak of the curve at the mean GC content for the organism sequenced (37% in this case);
    - uniform, very low **per base N content**;
    - all sequences have a length of 90 bp; 
    - no **overrepresented sequences** 
    - **sequence duplication levels** shows that most of the DNA sequences are unique (~83% and ~84% respectively);
    - no **adapter sequences** were identified in the reads.  
  
![New_dir_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/fastqc_Illumina_DNA_2tile_qual.png)    
  
![New_dir_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/fastqc_Illumina_DNA_3seq_qual.png)     
  
![New_dir_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/fastqc_Illumina_DNA_4base_content.png)     
  
![New_dir_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/fastqc_Illumina_DNA_5cg_content.png)      
  
![New_dir_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/fastqc_Illumina_DNA_6base_n_content.png)     
  
![New_dir_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/fastqc_Illumina_DNA_7length.png)      
  
![New_dir_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/fastqc_Illumina_DNA_8duplication.png)     
  
![New_dir_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/fastqc_Illumina_DNA_9adapters.png)     
  