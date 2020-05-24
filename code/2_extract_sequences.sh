
file_with_contig_seq=canu_pacbio.contigs.fasta
open (file that contains name of contigs) -> extract only the name of contig? (or just grepping by '>' is enough?):
list_names = cat canu_pacbio.contigs.fasta | grep '>'| cut -d" " -f1 
for name in 
    
   for each name/line:
        extract sequence data
        save as a file