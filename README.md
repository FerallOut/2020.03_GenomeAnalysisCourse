- the files in this folder are used to create the organizational framework of the project  
  
- script "0directory_tree.sh" creates a directory tree for a new project with various folders   
- to use it, invoke it like this:   
./0directory_tree.sh path_to_where_you_want_the_new_folder project_name  
  
- this is the resulting directory path:  
![](./images/organiz_dir_tree.png) 

![GitHub Logo](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/long_data_dir_tree1.png)

project_name
|- doc/            		documentation for the data, type, origin, dates
|
|- data/			raw and primary data - all input files, NEVER EDIT!!
|  |- raw_external/			
|  |- raw_internal/		
|  |- metadata/
|
|- code/			all scripts needed to go from input files to final results. Save in different folders
|- notebooks/			document day-to-day work
|
|- temp/			temporary files, can be deleted at any time by anyone, will not be backed up
|- scratch/			intermediate results, your little sandbox to test things, will not be backed up
|- logs/			if you need to save logs
|
|- results/       		output from workflows and analyses
|  |- NAME_HERE/		use the name of the program so we know what generated what
|  |- figures/			try to use dates in the file names if possible
|  |- reports/			reports for external people, PDF format, can include a text file with google docs links
|  |- tables/
  

