setwd('/home/ferall/Dropbox/0MSc_Bioinfo_Uppsala/Sem1_1MB462_Genome_Analysis/2020.03_GenomeAnalysisCourse/Counts/11_RNA_htseq_ID_gene')

# create a matrix that has all the gene counts from all 3 repeats of the 2 experimental conditions
BHI_1 <- read.csv2("BHI_ERR1797972_rep1.txt", row.names = 1, col.names = c('ID', 'gene_name', 'count_BHI_1'), sep = "\t", na.strings = "NA", fill = TRUE)
BHI_2 <- read.csv2("BHI_ERR1797973_rep2.txt", row.names = 1, col.names = c('ID', 'gene_name', 'count_BHI_2'), sep = "\t", na.strings = "NA", fill = TRUE)
BHI_3 <- read.csv2("BHI_ERR1797974_rep3.txt", row.names = 1, col.names = c('ID', 'gene_name', 'count_BHI_3'), sep = "\t", na.strings = "NA", fill = TRUE)

Ser_1 <- read.csv2("serum_ERR1797969_rep1.txt", row.names = 1, col.names = c('ID', 'gene_name', 'count_ser_1'), sep = "\t", na.strings = "NA", fill = TRUE)
Ser_2 <- read.csv2("serum_ERR1797970_rep2.txt", row.names = 1, col.names = c('ID', 'gene_name', 'count_ser_2'), sep = "\t", na.strings = "NA", fill = TRUE)
Ser_3 <- read.csv2("serum_ERR1797971_rep3.txt", row.names = 1, col.names = c('ID', 'gene_name', 'count_ser_3'), sep = "\t", na.strings = "NA", fill = TRUE)

expData <- data.frame(BHI_1, BHI_2['count_BHI_2'], BHI_3['count_BHI_3'], Ser_1['count_ser_1'], Ser_2['count_ser_2'], Ser_3['count_ser_3'])
write.csv(expData, "Matrix_reads_gene.csv", row.names=T)
#######

  # get number of aligned reads for each experiment 
  OnlyNumCol <- expData[c(2:7)] 
totalReads <- colSums(OnlyNumCol)
notAlignedReads <- OnlyNumCol["__not_aligned",]
AlignedReads <- totalReads - notAlignedReads
percentAlignedReads <- OverallAlignedReads * 100 / OverallTotalReads
#######

# get number of aligned reads in total
OverallTotalReads <- sum(totalReads)
OverallNotAlignedReads <- sum(notAlignedReads)
OverallAlignedReads <- sum(AlignedReads)
########

# percentual calculation of the overall number of reads that has mapped to the reference
PercentOverallAlignedReads <- OverallAlignedReads * 100 / OverallTotalReads
PercentOverallAlignedReads
##############

# remove the table from the end of the files and save that matrix
lenMatrix<-dim(OnlyNumCol)[1]
ReadsFeatures<-OnlyNumCol[1:(lenMatrix-5),]

#OnlyNumCol <- ReadsFeatures[c(2:7)] 
OverallTotalReadsFeatures <- sum(colSums(OnlyNumCol))
PercentReadsFeatures <- OverallTotalReadsFeatures * 100 / OverallTotalReads
PercentReadsFeatures

OverallNoFeatures <- sum(OnlyNumCol["__no_feature",])
OverallNoFeatures