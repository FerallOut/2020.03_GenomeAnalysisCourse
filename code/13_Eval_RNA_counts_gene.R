setwd('/home/ferall/Dropbox/0MSc_Bioinfo_Uppsala/Sem1_1MB462_Genome_Analysis/2020.03_GenomeAnalysisCourse/Counts/11_RNA_htseq_ID_gene')

# create a matrix that has all the gene counts from all 3 repeats of the 2 experimental conditions
BHI_1 <- read.csv2("BHI_ERR1797972_rep1.txt", row.names = 1, col.names = c('ID', 'gene_name', 'count_BHI_1'), sep = "\t", na.strings = "NA", fill = TRUE)
BHI_2 <- read.csv2("BHI_ERR1797973_rep2.txt", row.names = 1, col.names = c('ID', 'gene_name', 'count_BHI_2'), sep = "\t", na.strings = "NA", fill = TRUE)
BHI_3 <- read.csv2("BHI_ERR1797974_rep3.txt", row.names = 1, col.names = c('ID', 'gene_name', 'count_BHI_3'), sep = "\t", na.strings = "NA", fill = TRUE)

Ser_1 <- read.csv2("serum_ERR1797969_rep1.txt", row.names = 1, col.names = c('ID', 'gene_name', 'count_ser_1'), sep = "\t", na.strings = "NA", fill = TRUE)
Ser_2 <- read.csv2("serum_ERR1797970_rep2.txt", row.names = 1, col.names = c('ID', 'gene_name', 'count_ser_2'), sep = "\t", na.strings = "NA", fill = TRUE)
Ser_3 <- read.csv2("serum_ERR1797971_rep3.txt", row.names = 1, col.names = c('ID', 'gene_name', 'count_ser_3'), sep = "\t", na.strings = "NA", fill = TRUE)

expData <- data.frame(BHI_1, BHI_2['count_BHI_2'], BHI_3['count_BHI_3'], Ser_1['count_ser_1'], Ser_2['count_ser_2'], Ser_3['count_ser_3'])
#write.csv(expData, "Matrix_reads_gene.csv", row.names=T)
#############################################

# get number of aligned reads for each experiment 
OnlyNumCol <- expData[c(2:7)] 

# Distribution of mapped reads
hist(OnlyNumCol[,1], main="Distribution of RNA reads", xlab="Counts")

log2_counts <- log2(OnlyNumCol+1)

boxplot(log2_counts, main="Distribution of log2-normalized RNA reads data")
hist(log2_counts[,1], main="Distribution of log2-normalized RNA reads data", xlab="Counts")