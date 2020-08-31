setwd('/home/ferall/Dropbox/0MSc_Bioinfo_Uppsala/Sem1_1MB462_Genome_Analysis/2020.03_GenomeAnalysisCourse/Counts/11_RNA_htseq_second')

# create a matrix that has all the gene counts from all 3 repeats of the 2 experimental conditions
BHI_1 <- read.table("BHI_ERR1797972_rep1.txt", row.names = 1, col.names = c('ID', 'count_BHI_1'))
BHI_2 <- read.table("BHI_ERR1797973_rep2.txt", row.names = 1, col.names = c('ID', 'count_BHI_2'))
BHI_3 <- read.table("BHI_ERR1797974_rep3.txt", row.names = 1, col.names = c('ID', 'count_BHI_3'))

Ser_1 <- read.table("serum_ERR1797969_rep1.txt", row.names = 1, col.names = c('ID', 'count_ser_1'))
Ser_2 <- read.table("serum_ERR1797970_rep2.txt", row.names = 1, col.names = c('ID', 'count_ser_2'))
Ser_3 <- read.table("serum_ERR1797971_rep3.txt", row.names = 1, col.names = c('ID', 'count_ser_3'))

expData <- data.frame(BHI_1, BHI_2, BHI_3, Ser_1, Ser_2, Ser_3)
write.csv(expData, "Matrix_reads.csv", row.names=T)
#######

# get number of aligned reads for each experiment 
totalReads <- colSums(expData)
notAlignedReads <- expData["__not_aligned",]
AlignedReads <- totalReads - notAlignedReads
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

lenMatrix<-dim(expData)[1]
ReadsFeatures<-expData[1:(lenMatrix-5),]

OverallTotalReadsFeatures <- sum(colSums(ReadsFeatures))
PercentReadsFeatures <- OverallTotalReadsFeatures * 100 / OverallTotalReads
PercentReadsFeatures

OverallNoFeatures <- sum(expData["__no_feature",])
OverallNoFeatures