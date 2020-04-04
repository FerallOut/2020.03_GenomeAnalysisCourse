# Mon, 2020-03-30

to do:  
- [x] start a daily log  
- [x] download git repository on Uppmax  
- [x] do some organizatorial stuff:  
    - [x] where are the data?  
    - [x] how it looks like?  
    - [x] create directory structure for the project  
    - [x] link raw data into my "raw_ext" folder  
- [x] make the project plan 
- [x] save daily log and project plan into "notebooks"  
- [x] make the diagram for work flow  
- [x] push changes to git  
***  
- log in to Uppmax: ```ssh -AX username@rackham.uppmax.uu.se```  
- project number: **g2020008**  
- where to run analyses: **/home/username/**  
- where is the raw data: **/proj/g2020008/nobackup/private/1_Zhang_2017/**   
***  
`sudo apt-get install tree`  
the directory tree: tree  
***  
![](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/long_data_dir_tree1.png)
![](https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/long_data_dir_tree2.png)

***    
  - connect to github to save the **code**, **results** and **notebook** folders. 
    - copy repository to local machine: `git clone URL_of_your_repo`  
  - create a directory tree in my "/home/username/git_repo/" folder using a custom script:  
    - write custom script: **0directory_tree.sh** 
    - copy script to uppmax (you need to be *not logged in* Uppmax):  
   	`scp address/local_file user@rackham.uppmax.uu.se:/home/usernameRackham/`  
    - make script executable: `chmod u+x 0directory_tree.sh`  
    - run script like this: `./0directory_tree.sh path_to_where_you_want_the_new_folder project_name`  
***   
![](images/https://github.com/FerallOut/2020.03_GenomeAnalysisCourse/blob/master/notebooks/images/organiz_dir_tree.png)  
  
- copy script into folder **code**.  
- create a soft link from the **raw_ext** folder in my directory tree to the raw data in the project:  
  **ln -s {source-filename} {symbolic-filename}**  
`ln -s /proj/g2020008/nobackup/private/1_Zhang_2017/ link_to_raw_data`  
***  