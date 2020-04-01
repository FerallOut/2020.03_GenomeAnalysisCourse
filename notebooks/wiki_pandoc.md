\hypertarget{mon-2020-03-30}{%
\section{Mon, 2020-03-30}\label{mon-2020-03-30}}

to do:

\begin{itemize}
\tightlist
\item[$\boxtimes$]
  start a daily log\\
\item[$\boxtimes$]
  download git repository on Uppmax\\
\item[$\boxtimes$]
  do some organizatorial stuff:

  \begin{itemize}
  \tightlist
  \item[$\boxtimes$]
    where are the data?\\
  \item[$\boxtimes$]
    how it looks like?\\
  \item[$\boxtimes$]
    create directory structure for the project\\
  \item[$\boxtimes$]
    link raw data into my "raw\_ext" folder\\
  \end{itemize}
\item[$\boxtimes$]
  make the project plan
\item[$\boxtimes$]
  save daily log and project plan into "notebooks"\\
\item[$\boxtimes$]
  make the diagram for work flow\\
\item[$\boxtimes$]
  push changes to git
\end{itemize}

\begin{itemize}
\tightlist
\item
  log in to Uppmax: \texttt{ssh\ -AX\ username@rackham.uppmax.uu.se}\\
\item
  project number: \textbf{g2020008}\\
\item
  where to run analyses: \textbf{/home/username/}\\
\item
  where is the raw data:
  \textbf{/proj/g2020008/nobackup/private/1\_Zhang\_2017/}
\end{itemize}

\texttt{sudo\ apt-get\ install\ tree}~\\
the directory tree: tree\\
\includegraphics{images/long_data_dir_tree1.png}

\includegraphics{images/long_data_dir_tree2.png}

\begin{itemize}
\tightlist
\item
  connect to github to save the \textbf{code}, \textbf{results} and
  \textbf{notebook} folders.

  \begin{itemize}
  \tightlist
  \item
    copy repository to local machine:
    \texttt{git\ clone\ URL\_of\_your\_repo}\\
  \end{itemize}
\item
  create a directory tree in my "/home/username/git\_repo/" folder using
  a custom script:

  \begin{itemize}
  \tightlist
  \item
    write custom script: \textbf{0directory\_tree.sh}
  \item
    copy script to uppmax (you need to be \emph{not logged in}
    Uppmax):\\
    \texttt{scp\ address/local\_file\ user@rackham.uppmax.uu.se:/home/usernameRackham/}~\\
  \item
    make script executable: \texttt{chmod\ u+x\ 0directory\_tree.sh}\\
  \item
    run script like this:
    \texttt{./0directory\_tree.sh\ path\_to\_where\_you\_want\_the\_new\_folder\ project\_name}
  \end{itemize}
\end{itemize}

\includegraphics{images/organiz_dir_tree.png}

\begin{itemize}
\tightlist
\item
  copy script into the correct folder:

  \begin{itemize}
  \tightlist
  \item
    make a new folder in \textbf{code}, named \textbf{0\_organization}:
    \texttt{mkdir\ 0\_organization}
  \item
    paste file there and add a README
  \end{itemize}
\item
  create a soft link from the \textbf{raw\_ext} folder in my directory
  tree to the raw data in the project:\\
  \textbf{ln -s \{source-filename\} \{symbolic-filename\}}\\
  \texttt{ln\ -s\ /proj/g2020008/nobackup/private/1\_Zhang\_2017/\ link\_to\_raw\_data}
\end{itemize}

\# Wed, 2020-04-01

to do:

\begin{enumerate}
\tightlist
\item[$\boxtimes$]
  figure out how to correctly export jupyter to pdf (the images are not
  showing and the font is wrong)\\
\item[$\boxtimes$]
  correct README.md showing directory tree\\
\item[$\boxtimes$]
  change the diagram for the project plan to include received comments:

  \begin{enumerate}
  \tightlist
  \item[$\boxtimes$]
    "You don't need to run QC on the PacBio reads, neither trimmomatic
    or FastQC are very good at handle long reads so you can skip that
    step."\\
  \item[$\boxtimes$]
    "For the Spades assembly you can input both long and short reads if
    you would like."\\
  \item[$\boxtimes$]
    "For the annotation part, it is enough to run Prokka, Maker2 is
    designed to run on eukaryotic genomes."\\
  \item[$\boxtimes$]
    "Also, please add a section on how you are going to organise
    scripts, data from analysis and so forth."\\
  \end{enumerate}
\item[$\boxtimes$]
  push changes to git
\end{enumerate}

\hypertarget{task-1}{%
\subsubsection{Task 1}\label{task-1}}

Tried and failed:

\begin{itemize}
\item
  export from jupyter notebook depends on 'nbconvert' settings. It needs
  to have installed:

  \begin{itemize}
  \tightlist
  \item
    'pandoc' (\texttt{sudo\ apt-get\ install\ pandoc})\\
  \item
    'XeLaTex'
    (\texttt{sudo\ apt-get\ install\ texlive-xetex\ texlive-fonts-recommended\ texlive-generic-recommended})\\
  \item
    the output is bad, no image included\\
  \end{itemize}
\item
  export as html then convert to pdf with wkhtmltopdf
  (\texttt{sudo\ apt-get\ install\ wkhtmltopdf})

  \begin{itemize}
  \tightlist
  \item
    didn't get it to work\\
  \end{itemize}
\item
  same but with pandoc

  \begin{itemize}
  \tightlist
  \item
    \texttt{pandoc\ test.html\ -t\ latex\ -o\ test.pdf}- works better
    (images are there and structure is preserved) but the layout need
    improving.\\
  \item
    but directly from .ipynb to .pdf it doesn't work.\\
  \item
    "Pandoc first converts the Markdown file to LaTeX which then gets
    compiled to PDF"-so the issue might be with LaTex.\\
  \end{itemize}
\item
  use 'nbconvert' directly: \textbf{jupyter nbconvert -\/-to
  output\_format input\_notebook}\\
  \texttt{jupyter\ nbconvert\ -\/-to\ markdown\ wiki\_daily\_log.ipynb}
\item
  installed pandoc2. nothing works
\end{itemize}

Will just export .ipybn to .md and upload it like that to git.

\begin{itemize}
\tightlist
\item
  \texttt{pandoc\ wiki\_daily\_log.ipynb\ -o\ wiki\_daily\_log\_pandoc.md}~\\
  As pdf:\\
\item
  \texttt{pandoc\ wiki\_daily\_log.ipynb\ -t\ latex\ -o\ test\_pandoc.pdf}
\end{itemize}

Pandoc options:\\
\texttt{-\/-resource-path} defines the path where Pandoc will look for
resources that are linked in the notebook. This allows us to discover
images etc that are in a different folder from where we are invocing
pandoc.\\
\texttt{-\/-extract-media} is a path where images and other media will
be extracted at conversion time. Any links to images etc should point to
files at this path in the output format.\\
\texttt{-s} (or \texttt{-\/-standalone}) tells Pandoc that the output
should be a "standalone" format. This does different things depending on
the output, such as adding a header if converting to HTML.\\
\texttt{-o} the output file, and implicitly the output file type (e.g.,
markdown)\\
\texttt{-t} the type of output file if we want to override the default
(e.g., GitHub-flavored markdown vs. Pandoc markdown)

\begin{Shaded}
\begin{Highlighting}[]

\end{Highlighting}
\end{Shaded}
