  # Wed, 2020-04-01
 
to do:  
1. [ ] figure out how to correctly export jupyter to pdf (the images are not showing and the font is wrong)  
2. [x] correct README.md showing directory tree  
3. [x] change the diagram for the project plan to include received comments:  
    1. [x] "You don’t need to run QC on the PacBio reads, neither trimmomatic or FastQC are very good at handle long reads so you can skip that step."  
    2. [x] "For the Spades assembly you can input both long and short reads if you would like."  
    3. [x] "For the annotation part, it is enough to run Prokka, Maker2 is designed to run on eukaryotic genomes."  
    4. [x] "Also, please add a section on how you are going to organise scripts, data from analysis and so forth."   
4. [x] push changes to git  
***  
### Task 1  
Tried and failed:  
- export from jupyter notebook depends on 'nbconvert' settings. It needs to have installed:  
    - 'pandoc' (`sudo apt-get install pandoc`)  
    - 'XeLaTex' (`sudo apt-get install texlive-xetex texlive-fonts-recommended texlive-generic-recommended`)  
    - the output is bad, no image included  
- export as html then convert to pdf with wkhtmltopdf (`sudo apt-get install wkhtmltopdf`)  
    - didn't get it to work  
- same but with pandoc  
    - `pandoc test.html -t latex -o test.pdf`- works better (images are there and structure is preserved) but the layout need improving.  
    - but directly from .ipynb to .pdf it doesn't work.  
    - "Pandoc first converts the Markdown file to LaTeX which then gets compiled to PDF"-so the issue might be with LaTex.  
- use 'nbconvert' directly:  **jupyter nbconvert --to output_format input_notebook**  
    `jupyter nbconvert --to markdown wiki_daily_log.ipynb `  
        
- installed pandoc2. nothing works  
        
Will just export .ipybn to .md and upload it like that to git.  
- `pandoc wiki_daily_log.ipynb -o wiki_daily_log_pandoc.md`  
As pdf:  
- `pandoc wiki_daily_log.ipynb -t latex -o test_pandoc.pdf`  
***  
Pandoc options:  
    `--resource-path` defines the path where Pandoc will look for resources that are linked in the notebook. This allows us to discover images etc that are in a different folder from where we are invocing pandoc.  
    `--extract-media` is a path where images and other media will be extracted at conversion time. Any links to images etc should point to files at this path in the output format.  
    `-s` (or `--standalone`) tells Pandoc that the output should be a "standalone" format. This does different things depending on the output, such as adding a header if converting to HTML.  
    `-o` the output file, and implicitly the output file type (e.g., markdown)  
    `-t` the type of output file if we want to override the default (e.g., GitHub-flavored markdown vs. Pandoc markdown)  
***  
In the end, I realized that I can just write directly in .md with a simpler Markdown syntax. JupyterLab helps with the simultaneous "Markdown Previewer". In order for the images to appear in the Markdown document on gitHub, they have to be uploaded and linked to, using URL. 