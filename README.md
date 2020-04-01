# Project Plan

The data that I am working on is extracted from the paper:  
"RNA-seq and Tn-seq reveal fitness determinants *Enterococcus faecium* during growth in human serum of vancomycin-resistant" - Zhang X, de Maat V, Guzmán Prieto A.M, Prajsnar T.K, Bayjanov J.R, de Been M, Rogers M.R.C, Bonten M.J.M, Mesnage S, Willems R.J.L, van Schaik W.  
  
The aim of this project is to determine which genetic elements are responsible for the growth of *Enterococcus faecium* vancomycin-resistant strain in human serum. This is important because *E. faecium* frequently causes bloodstream infections in hospitalized patients. After a *de-novo* assembly of the genome of *E. faecium*, is required to do a differential expression analysis of the transcriptome between 2 different states: the bacteria grown in rich medium or in human serum.  
  
The genome is available from NCBI Genbank (**CP014529 - CP014535**). The available DNA, RNA and transposons reads are in FASTQ format, and are arranged like this:    
  
![directory_tree](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/short_data_dir_tree.png)  
  
# Organization of new data  
- In order to keep the project organized, I have decided on the types of files that I will have and on the organizational framework of the project.  
- To create all the folders that I need, I wrote the script **"0directory_tree.sh"** to automaticall create the directory tree  
    - to use it, invoke it like this:   
`./0directory_tree.sh path_to_where_you_want_the_new_folder project_name`  
  
- this is the resulting directory tree:  
  
![GitHub Logo](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/long_data_dir_tree2.png)  
<!-- ![](images/long_data_dir_tree2.png) -->  
