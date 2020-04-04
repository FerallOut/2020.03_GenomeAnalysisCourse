  # Thu, 2020-04-02
 
to do:  
1. [ ] quality control on short reads (DNA - Illumina, RNA - Illumina)  
    1. [ ] read about FASTQC   
    2. [ ] do FASTQC on the samples and save the graphs/ report. Explain what the results mean.
2. [ ] pre-processing of short reads      
    1. [ ] read about Trimmomatic  
    2. [ ] do Trimmomatic on the samples and save the graphs/ report. Explain what the results mean.
3. [ ] again quality control on reads  
    1. [ ] do FASTQC on the samples and save the graphs/ report. Explain what the results mean.
4. [ ] document steps, scripts and results  
5. [ ] push changes to git  
***  
### Where is the data?
`pwd`  
- genomic: Illumina DNA short-reads  
    /home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/genomics_data/Illumina  
  
    E745-1.L500_SZAXPI015146-56_1_clean.fq.gz  
    E745-1.L500_SZAXPI015146-56_2_clean.fq.gz  
      
***  
### 1.A. FASTQC - theory   
- see the FASTQC tutorials    
***  
### 1.B. Running FASTQC on the data  
  
- basic command:  
    'fastqc [-o output dir] [--(no)extract] [-f fastq|bam|sam] [-c contaminant file] seqfile1 .. seqfileN'  
    
`fastqc --outdir=where_you_want_the_report file1_gzipped file2_gzipped file3_gzipped `  etc    
- new file name: adds prefix "fastqc.html"
- open report: `firefox SRR453566_yeast_rnaseq_fastqc.html &`  
- have a look through the QC results to try to answer the following questions:
    - Did any of the QC modules trigger a warning or alert condition?  
    - Do the base call qualities provided by the sequencer suggest the data is high quality, or might it benefit from being quality trimmed?  
    - Are there any consistent sequence biases in the data?  If so, can these be explained by the presence of contaminating sequences or other artefacts which are known to affect RNA-Seq datasets?  
    - Is there any suggestion of the presence of adapter sequence which might need to be removed?  
    - Does the duplication level of the data look reasonable given that this is RNA-Seq data?  
- also answer these questions for the report:  
    - What is the structure of a FASTQ file?
    - How is the quality of the data stored in the FASTQ files? How are paired reads identified?
    - How is the quality of your data?
    - What can generate the issues you observe in your data? Can these cause any problems during subsequent analyses?
***  
- log in Uppmax:  
`ssh -AX username@rackham.uppmax.uu.se`  
- loading FastQC on Uppmax:  
    - figure out which module:  
    `module avail --starts-with, -F`
    `module spider Fastqc`  
    recommended "module spider FastQC/0.11.8"
    - `module purge` -Unload all loaded modulefiles  
    - `module load bioinfo-tools`  
    - `module load FastQC`
    - `fastqc --version`  
    FastQC v0.11.8  
    - `module list [-t|-l]` - List loaded modules in short/long format.
    - `avail [-d|-L] [-t|-l] [-S|-C] [--indepth|--no-indepth] [path...]` - List all available modules default/latest, short/long format, whose name starts/=`
- where to put the reports? in **results/reports/1fastqc_DNA_Illumina**  
- from within that folder, run command:  
`fastqc --outdir=/home/miba8458/2020.03_GenomeAnalysisCourse/results/reports/0fastqc_DNA_Illumina /home/miba8458/2020.03_GenomeAnalysisCourse/data/raw_ext/link_to_raw_data/genomics_data/Illumina/E745-1.L500_SZAXPI015146-56_*`  
   
- check the report:  
`firefox E745-1.L500_SZAXPI015146-56_1_clean_fastqc.html &`  
- Copy a file from your home directory on UPPMAX to your computer:  
`scp user@rackham.uppmax.uu.se:/home/username/some-file local_file_or_directory`  
***  
- submit script to slurm:  
`sbatch 1_DNA_fastqc_Illumina.sh`  
>Submitted batch job 13143181  
  
***  
2.A. TRIMMOMATIC - theory
- see the downloaded manuals   
  
Reads preprocessing  
  
An essential step when working with short-reads is removing the low quality base-calls and
present adapters from the reads. Sometimes this is done directly by the assembler, but other
times this is a manual step that cannot be skipped. 
  
Trimmomatic is a fast, multithreaded command line tool that can be used to trim and crop Illumina (FASTQ) data as well as to remove adapters. These adapters can pose a real problem depending on the library preparation and downstream application.

***
2.B. Running Trimmomatic on the data  
  
- basic command for **paired-end** reads:  
    - For paired-end data, two input files, and 4 output filesare specified, 2 for the 'paired' output where both reads survived the processing, and2 for corresponding 'unpaired' output where a read survived, but the partner read did not.  
     
Notes:
- **Trimmomatic will perform the different filtering steps in the same order as specified on the command line. In this case the order of the settings is important!**  
  
'java -jar \<path to trimmomatic.jar> PE [-threads <threads] [-phred33 | -phred64] [-trimlog \<logFile>] >] [-basein \<inputBase> |\<input 1> \<input 2>][-baseout \<outputBase> |<unpaired output 1> <paired output 2> <unpaired output 2> <step 1> ... '
 
***  
Example:  
`java -jar trimmomatic-0.30.jar PE s_1_1_sequence.txt.gz s_1_2_sequence.txt.gz lane1_forward_paired.fq.gz lane1_forward_unpaired.fq.gz lane1_reverse_paired.fq.gz lane1_reverse_unpaired.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36`  
  
This will perform the following in this order:
- Remove Illumina adapters provided in the TruSeq3-PE.fa file (provided). Initially Trimmomatic will look for seed matches (16 bases) allowing maximally 2mismatches. These seeds will be extended and clipped if in the case of paired end reads a score of 30is reached (about 50 bases), orin the case of single ended reads a score of 10, (about 17 bases).
- Remove leading low quality or N bases (below quality 3)
- Remove trailing low  quality or N bases (below quality 3)
- Scan the read with a 4-base wide sliding window, cutting when the average quality per base drops below 15
- Drop reads which are less than 36bases longafter these steps 
***  
#### Decisions
- since both DNA files show no adaptors in QC, will use Trimmomatic for **quality trimming**.  

Trimmomatic parameters:  
  
| Threshold - per base quality | %reads retained |  
|---|---|  
|15||  
|20||  
|22||  

  
- from each DNA sequence, trimm all bases that have a quality per base < 20 and if the sliding window of 4 gives a < 15 value. 
***  
#### To think about:  
  
Since this analysis can be
time-consuming and occupy much of the allocated storage space, we are providing you with
already trimmed reads. However, you might need to do it anyway for some specific sample.

To think about:
- How many reads have been discarded after trimming?
- How can this affect your future analyses and results?
- How is the quality of your data after trimming?
- What do the LEADING, TRAILING and SLIDINGWINDOW options do?  
***  

`module spider trimmomatic`
>trimmomatic: trimmomatic/0.36

`module load bioinfo-tools`  
`module load trimmomatic`   
`module help trimmomatic/0.36`  
> Usage: java -jar $TRIMMOMATIC_HOME/trimmomatic.jar followed by options  

- made a script (**2_DNA_trimmomatic_Illumina.sh**) in the **code** folder.  

- run script  
`sbatch 2_DNA_trimmomatic_Illumina.sh` 
> Submitted batch job 13148819  

