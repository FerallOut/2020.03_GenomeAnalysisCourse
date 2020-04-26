# Sun, 2020-04-26

- [ ] assembly evaluation

  - [ ] Quast script  
    - [ ] Canu_PacBio
    - [ ] Spades_PacBio + Illumina - issue with assembly, so skipped
    - [ ] Spades_Nano + Illumina
  - [ ] Mummerplot script 
    - [ ] Canu_PacBio
    - [ ] Spades_PacBio + Illumina - skipped
    - [ ] Spades_Nano + Illumina

  ------

  * to run Quast, I can either use it with or without a reference genome, or to compare 2 assemblies resulted from the same data set

  * I used NCBI Genome to find a reference genome for Enterococcus faecium:

    https://www.ncbi.nlm.nih.gov/genome/?term=Enterococcus%20faecium[Organism]&cmd=DetailsSearch

  * upload file to Uppmax:

    `scp ./GCF_000174395.2_ASM17439v2_genomic.fna.gz usernameRackham@rackham.uppmax.uu.se:/home/usernameRackham/2020.03_GenomeAnalysisCourse/data/`

  * ran Quast with and without a reference genome:

    









 1. [ ] read about Trimmomatic  
 2. [ ] do Trimmomatic on the samples and save the graphs/ report. Explain what the results mean.

1. [ ] again quality control on reads  
     1. [ ] do FASTQC on the samples and save the graphs/ report. Explain what the results mean.
2. [ ] document steps, scripts and results  
3. [ ] push changes to git  