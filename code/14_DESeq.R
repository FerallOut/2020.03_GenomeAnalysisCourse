#bh1 <- read.table("htseq_readcount_BH_paired_ERR1797972.txt", row.names = 1, col.names = c('gene', 'ERR1797972'))
#bh2 <- read.table("htseq_readcount_BH_paired_ERR1797973.txt", row.names = 1, col.names = c('gene', 'ERR1797973'))
#bh3 <- read.table("htseq_readcount_BH_paired_ERR1797974.txt", row.names = 1, col.names = c('gene', 'ERR1797974'))
#serum1 <- read.table("htseq_readcount_Serum_paired_ERR1797969.txt", row.names = 1, col.names = c('gene', 'ERR1797969'))
#serum2 <- read.table("htseq_readcount_Serum_paired_ERR1797970.txt", row.names = 1, col.names = c('gene', 'ERR1797970'))
#serum3 <- read.table("htseq_readcount_Serum_paired_ERR1797971.txt", row.names = 1, col.names = c('gene', 'ERR1797971'))

#countData <- data.frame(bh1, bh2, bh3, serum1, serum2, serum3)
############################################

# download DESeq2 package
#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")

#BiocManager::install("DESeq2")
#########################################

#Load DESeq2 library
library("DESeq2")
#sampleFile <- "/Users/nadiahassanshamas/documents/Genome-Analysis/result_files/counts.file"

directory <- "/home/ferall/Dropbox/0MSc_Bioinfo_Uppsala/Sem1_1MB462_Genome_Analysis/2020.03_GenomeAnalysisCourse/Counts/13_deseq_simple/"
setwd(directory)

sampleFiles<- grep("_add.txt",list.files(directory),value=TRUE) #c("a1.txt","a2.txt","a3.txt","a4.txt","a5.txt")
sampleNames <- c("BHI_1","BHI_2","BHI_3","Serum_1","Serum_2", "Serum_3")
sampleCondition <- c("BHI","BHI","BHI","Serum","Serum", "Serum")
sampleTable <- data.frame(sampleName = sampleNames, fileName = sampleFiles, condition = sampleCondition)

ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable, directory = directory, design= ~ condition)

# Calculating the actual differential expression
dds <- DESeq(ddsHTSeq)

res <- results(dds)

rld <- rlog(dds, blind=FALSE)

# heatmap to illustrate the differences
library("pheatmap") 

mat = assay(rld)[ head(order(res$padj),10), ] # select the top 20 genes with the lowest padj
mat = mat - rowMeans(mat) # Subtract the row means from each value
# Optional, but to make the plot nicer:
df = as.data.frame(colData(rld)[,c("condition")]) # Create a dataframe with a column of the conditions
colnames(df) = "condition" # Rename the column header
rownames(df) = colnames(mat) # add rownames
# and plot the actual heatmap
pheatmap(mat, annotation_col=df)