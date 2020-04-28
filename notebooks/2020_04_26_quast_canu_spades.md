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

  ## Quast 

  * to run Quast, I can either use it with or without a reference genome, or to compare 2 assemblies resulted from the same data set

  * I used NCBI Genome to find a reference genome for Enterococcus faecium:

    https://www.ncbi.nlm.nih.gov/genome/?term=Enterococcus%20faecium[Organism]&cmd=DetailsSearch

  * upload file to Uppmax:

    `scp ./GCF_000174395.2_ASM17439v2_genomic.fna.gz usernameRackham@rackham.uppmax.uu.se:/home/usernameRackham/2020.03_GenomeAnalysisCourse/data/`

  * ran Quast with a reference genome:

  * 'report.txt' and 'report.pdf' have the stats we need

  * https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3624806/ 

    2.1.1 Contig sizes

    The following metrics (except for NGx) can be evaluated with or without a  reference genome. We also provide filtered versions of them, restricted  to contigs of length above a specified minimum size, to exclude short  contigs that may not be of much use.

    - *No. of contigs*: The total number of contigs in the assembly.
    - *Largest contig*: The length of the largest contig in the assembly.
    - *Total length*: The total number of bases in the assembly.
    - *Nx (where* ![An external file that holds a picture, illustration, etc. Object name is btt086i1.jpg](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3624806/bin/btt086i1.jpg)*)*: The largest contig length, *L*, such that using contigs of length ![An external file that holds a picture, illustration, etc. Object name is btt086i2.jpg](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3624806/bin/btt086i2.jpg) accounts for at least *x*% of the bases of the assembly.
    - *NGx, Genome Nx*: The contig length such that using equal or longer length contigs produces *x*% of the length of the reference genome, rather than *x*% of the assembly length.

    2.1.2 Misassemblies and structural variations 

    The following metrics describe structural errors in the contigs. QUAST can  evaluate them only with respect to a known reference genome. If the  reference genome exactly matches the dataset being assembled,  differences may be attributed to misassemblies by the software or to  sequencing errors, such as chimeric reads. Sometimes one uses a  reference genome that is related to but different than the dataset being sequenced. In this case, the differences may still be misassemblies,  but they may also be true structural variations, such as rearrangements, large indels, different repeat copy numbers and so forth.

    - *No. of misassemblies*: The number of misassemblies, using Plantagora’s definition. Plantagora defines a *misassembly breakpoint* as a position in the assembled contigs where the left flanking sequence aligns over 1 kb away from the right flanking sequence on the  reference, or they overlap by >1 kb, or the flanking sequences align  on opposite strands or different chromosomes. QUAST also generates a  report with the number of misassemblies because of each of these  reasons. See the [Supplementary Methods](http://bioinformatics.oxfordjournals.org/lookup/suppl/doi:10.1093/bioinformatics/btt086/-/DC1) for details.
    - *No. of misassembled contigs*: The number of contigs that contain misassembly breakpoints.
    - *Misassembled contigs length*: The total number of bases contained in all contigs that have one or more misassemblies.
    - *No. of unaligned contigs*: The number of contigs that have no alignment to the reference sequence.
    - *No. of ambiguously mapped contigs*: The number of contigs that have high-scoring reference alignments of  equal quality in multiple locations on the reference genome.
    - In addition to these summary statistics, QUAST also generates reports with detailed information about each contig, including whether the contig is unaligned, ambiguously mapped, misassembled or correct.

    

    

    #### 2.1.3 Genome representation and its functional elements 

    This section lists metrics evaluating genome representation in contigs and  the number of assembled functional elements, such as genes and operons.  Most of these require a reference genome.

    - *Genome fraction (%)*: The total number of aligned bases in the reference, divided by the  genome size. A base in the reference genome is counted as aligned if at  least one contig has at least one alignment to this base. Contigs from  repeat regions may map to multiple places, and thus may be counted  multiple times in this quantity.
    - *Duplication ratio*: The total number of aligned bases in the assembly (i.e. total length  minus unaligned contigs length), divided by the total number of aligned  bases in the reference [see the genome fraction (%) metric]. If the  assembly contains many contigs that cover the same regions of the  reference, its duplication ratio may be much >1. This may occur due  to overestimating repeat multiplicities and due to small overlaps  between contigs, among other reasons.
    - *GC (%)*: The total number of G and C nucleotides in the assembly, divided by the total length of the assembly. This metric can be computed without a  reference genome.
    - *No. of mismatches per 100 kb*: The average number of mismatches per 100 000 aligned bases. QUAST also  generates a more detailed report with the coordinates of mismatches.  This metric does not distinguish between *single-nucleotide polymorphisms,* which are true differences in the assembled genome versus the reference genome, and *single-nucleotide errors,* which are due to errors in reads or errors in the assembly algorithm.
    - *No. of indels per 100 kb*: The average number of single nucleotide insertions or deletions per 100 000 aligned bases. A detailed report with coordinates of indels for all assemblies is also available.
    - *No. of genes*: The number of genes in the assembly (complete and partial), based on a  user-provided annotated list of gene positions in the reference genome. A gene is *partially covered* if the assembly contains at least  100 bp of the gene but not the whole gene. QUAST also reports a list of  the completely covered genes for each assembly. If an annotated list of  gene positions is not available, this metric cannot be computed, but the *number of predicted genes* (see later in the text) can be used instead.
    - *No. of operons*: Complete and partial operons are counted in a similar fashion to genes, using a user-provided annotated list of operon positions in the  reference genome.
    - *No. of predicted genes*: The number of genes in the assembly predicted by QUAST’s gene-finding module, which is based on GeneMark.hmm ([Lukashin and Borodovsky 1998](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3624806/#btt086-B16)) for prokaryotes and GlimmerHMM ([Majoros *et al.*, 2004](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3624806/#btt086-B10)) for eukaryotes. The GeneMark.hmm authors have kindly allowed use of  their software inside QUAST, and GlimmerHMM is an open-source tool. If  the user provides a reference genome with an annotated list of genes, we use the *number of genes* statistic instead. Otherwise, QUAST  counts the number of genes annotated by GeneMark.hmm or GlimmerHMM and  then filters them to count only those with lengths above one or more  specified minimum thresholds.

download the folder containing the report:

`scp -r usernameRackham@rackham.uppmax.uu.se:/home/usernameRackham/2020.03_GenomeAnalysisCourse/scratch/3a_DNA_quast_onSpades_Nano_Illumina ./`

***

## Mummerplot

http://mummer.sourceforge.net/manual/#mummerplot 

```#Load modules
module load bioinfo-tools 
module load MUMmer/3.9.4alpha

mummer -mum -b -L /home/nadia/refrence_genome.fasta.txt \ 
/home/nadia/efaecium-pacbio2/efaecium.contigs.fasta \ 
> matches_assembly.mummer
mummerplot -t png -p mummerplot_assembly_only_chromosomal matches_assembly.mummer```
```

`mummer -mum -b -c H_pylori26695_Eslice.fasta H_pyloriJ99_Eslice.fasta   > mummer.mums`

1. This command will find all maximal unique matches (`-mum`) between   the reference and query on both the forward and reverse strands (`-b`)   and report all the match positions relative to the forward strand (`-c`).   Output is to `stdout`, so we will redirect it into a file named `mummer.mums`.   This file lists all of the MUMs of the default length or greater between the   two input sequences

2. | `-b` | `Compute both forward and reverse complement matches`        |
   | ---- | ------------------------------------------------------------ |
   | `-c` | `Report the query position of a reverse complement match relative to the forward strand of the query sequence` |
   | `-L` | `Show the length of the query sequence on the header line`   |

`mummerplot -x "[0,275287]" -y "[0,265111]" -postscript   -p mummer mummer.mums`

* This command will plot all of the MUMs in the `mummer.mums` file   in postscript format (`-postscript`) between the given ranges for   the X and Y axes. When plotting `mummer` output, it is necessary   to use the lengths of the input sequences to set the plot ranges, otherwise   the plot will be automatically scaled around the minimum and maximum data points.   The four output files are prefixed by the string specified with the `-p`   option. The `plot` files contains the data points, `mummer.gp`   is a gnuplot script for plotting the data points in the `plot` files,   and `mummer.ps` is the postscript plot generated by the gnuplot script.   Below, you can see the `mummer.ps` file displayed with ghostview.   Note that with newer versions of `mummerplot` the color and thickness   of the plot lines may be different.

* | `-p string                     --prefix`   | `Set the output file prefix (default 'out')`                 |
  | ------------------------------------------ | ------------------------------------------------------------ |
  | `-t string                     --terminal` | `Set the output terminal to x11, postscript or png              --x11 --postscript --png` |
  | `-x range                      --xrange `  | `Set the x-range for the plot in the form "[min,max]"`       |
  | `-y range                      --yrange `  | `Set the y-range for the plot in the form "[min,max]"`       |