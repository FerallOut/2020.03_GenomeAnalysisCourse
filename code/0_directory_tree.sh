#!/bin/bash

### PROJECT FILE STRUCTURE
# run it like ./0directory_tree.sh data_location project_name
# creates 1 file tree, named 'project_name'

display_usage() { 
	echo "This script will create folder structure for a project" 
	echo "It will output one directory structure for data and analyses"
	echo "Please use like this:" 
	echo "./0directory_tree.sh data_location project_name"
	echo "Use a . if you want to create the data location here"
	} 
# if less than two arguments supplied, display usage 
	if [  $# -le 1 ] 
	then 
		display_usage
		exit 1
	fi 
####################################

# Spawning the directories
mkdir -p $1/$2/{doc,data/raw_ext,data/raw_int,data/metadata,code,notebooks,temp,scratch,logs,results/figures,results/reports,results/tables}
####################################

# Print the readme.md file to the right places
struture="
# $2 Directories Structure 

project_name
|- doc/            		documentation for the data, type, origin, dates
|
|- data/			raw and primary data - all input files, NEVER EDIT!!
|  |- raw_external/			
|  |- raw_internal/		
|  |- metadata/
|
|- code/			all scripts needed to go from input files to final results
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
|
|- readme.md			a readme file with this structure so future people can understand it
"
####################################

echo "$struture" >> $1/$2/readme.md
