#setwd("~/Documents/2018/R_BOOTCAMP/CLASS")

#### INSTALL R CRAN PACKAGES
#install.packages("ggplot2")
#install.packages("readr")
install.packages("RColorBrewer")
#install.packages("pheatmap") 
#install.packages("dplyr")
install.packages("statmod")

#### IMPORT BIOCONDUCTOR ENVIRONMENT####
source("http://bioconductor.org/biocLite.R")

#### UPDATE BIOCONDUCTOR ENVIRONMENT & PACKAGES####
biocLite()

#### INSTALL BIOCONDUCTOR PACKAGES ####
biocLite("BiocStyle")
biocLite("Biobase")
biocLite("GEOquery", dependencies = TRUE)
biocLite("tximport")
biocLite("tximportData")
biocLite("edgeR", dependencies = TRUE)
biocLite("limma", dependencies = TRUE)
#biocLite("DESeq2", dependencies = TRUE)
#biocLite("vsn")


#############################
##### SIMPLE ANALYSIS #######
#############################

#### CHECK EXAMPLE OUTPUTS FOR DIFFERENT READ COUNT PROGRAMS ####
#### This is RNA sequencing data set of human lymphoblastoid cell line samples
#### project info can be viewed here: https://www.ebi.ac.uk/ena/data/view/PRJEB3366

library(tximport)
library(tximportData)
txDatDir <- system.file("extdata", package = "tximportData")
list.files(txDatDir)

test_samples <- read.table(file.path(txDatDir, "samples.txt"), header = TRUE)


#### READ EXAMPLE RSEM OUTPUT
rsem_files <- file.path(txDatDir, "rsem", test_samples$run, paste0(test_samples$run, ".genes.results"))
names(rsem_files) <- paste0("sample", 1:6)
all(file.exists(rsem_files))

txi_rsem <- tximport(rsem_files, type = "rsem", txIn = FALSE, txOut = FALSE)
names(txi_rsem)
head(txi_rsem$counts)         # expected read counts
head(txi_rsem$abundance)      # FPKM
head(txi_rsem$length)         # effective length


#### PREPARE DATA FOR DIFFERENTIAL EXPRESSION ANALYSIS WITH edgeR package
library(edgeR)

### check this tutorial for more detailed instructions
### https://www.bioconductor.org/packages/devel/bioc/vignettes/edgeR/inst/doc/edgeRUsersGuide.pdf

# create normalization matrix based on gene lengths
normMat <- txi_rsem$length/exp(rowMeans(log(txi_rsem$length)))

# calculate normalization factor for each sample
o <- log(calcNormFactors(txi_rsem$counts/normMat)) + log(colSums(txi_rsem$counts/normMat))

# create edgeR class
y <- DGEList(txi_rsem$counts) 

# add notmalization matrix (offset)
y$offset <- t(t(log(normMat)) + o)

# add group info
y$samples$group <- factor(rep(c("A", "B"), each = 3))

#create study design matrix
cell_lines <- factor(rep(c("A", "B"), each = 3))
design <- model.matrix(~ cell_lines)


# filter lowly expressed tags
y <- y[rowSums(y$counts) >= 5,]
dim(y)

# Fast TMM normalization to account for compositional difference between RNA-seq libraries
y <- calcNormFactors(y)

# multidimensional scaling plot for samples  
plotMDS(y, labels=colnames(y))

# EM estimates for NB dispersion
y <- estimateDisp(y, design, robust=TRUE)        # estimate common dispersion

#plot dispersion
plotBCV(y)

#### DIFFERENTIAL EXPRESSION TEST IN edgeR ####
rsem_fit <- glmFit(y,design)
rsem_lrt <- glmLRT(rsem_fit)
topTags(rsem_lrt)

# Counts-per-million in individual samples for the top ten differentially expressed genes
topCPM <-  order(rsem_lrt$table$PValue)
cpm(y)[topCPM[1:10],]

summary(decideTests(rsem_lrt))

plotMD(rsem_lrt)
abline(h=c(-1, 1), col="blue")


################################
################################
#### MORE ADVANCED ANALYSIS ####
################################
################################

#### INSTALL REFERENCE GENOME ##### 
#biocLite("Mus.musculus")

#### Modified example from https://www.bioconductor.org/help/workflows/RNAseq123/

#### IMPORT PACKAGES ####
library(Biobase)   # core package in Bioconductor
library(GEOquery)
#library(Mus.musculus)
library(RColorBrewer)
library(limma)
library(gplots)


#### READ PROJECT INFO ####
gset <- getGEO("GSE63310")
eset <- gset[[1]]
eset
names(pData(eset))

#### OBTAIN RAW DATASETS ####
gsetsup <- getGEOSuppFiles("GSE63310",makeDirectory=F)
untar("GSE63310_RAW.tar")
file.remove(c(row.names(gsetsup),"GSM1545537_mo906111-1_m09611-2.txt.gz","GSM1545543_JMS9-CDBG.txt.gz"))
gzfiles <- list.files()
for(f in gzfiles) gunzip(f, overwrite=TRUE)
files <- list.files()

read.delim(files[1], nrow=5)

#### CONVERT DATASETS INTO 'DGEList' CLASS
x <- readDGE(files, columns=c(1,3))
class(x)
dim(x)

#### PROVIDE SAMPLE INFORMATION ####
samplenames <- substring(colnames(x), 12, nchar(colnames(x)))
colnames(x) <- samplenames
group <- as.factor(c("LP", "ML", "Basal", "Basal", "ML", "LP", "Basal", "ML", "LP"))
x$samples$group <- group
lane <- as.factor(rep(c("L004","L006","L008"), c(3,4,2)))
x$samples$lane <- lane
x$samples

# #### PROVIDE GENE ANNOTATIONS
# geneid <- rownames(x)
# genes <- select(Mus.musculus, keys=geneid, columns=c("SYMBOL", "TXCHROM"),keytype="ENTREZID")
# head(genes)  #check output
# genes <- genes[!duplicated(genes$ENTREZID),] #remove duplications
# x$genes <- genes

#### TRANSFORM RAW COUNTS TO log-CPM
cpm <- cpm(x)
lcpm <- cpm(x, log=TRUE)

#### FILTER GENES WITH NO EXPRESSION
table(rowSums(x$counts==0)==9)

keep.exprs <- rowSums(cpm>1)>=3
x <- x[keep.exprs,, keep.lib.sizes=FALSE]
dim(x)

#### Plot log-CPM before and after gene filtering
nsamples <- ncol(x)
col <- brewer.pal(nsamples, "Paired")
par(mfrow=c(1,2))
plot(density(lcpm[,1]), col=col[1], lwd=2, ylim=c(0,0.21), las=2, main="", xlab="")
title(main="A. Raw data", xlab="Log-cpm")
abline(v=0, lty=3)
for (i in 2:nsamples){
	den <- density(lcpm[,i])
	lines(den$x, den$y, col=col[i], lwd=2)
}
legend("topright", samplenames, text.col=col, bty="n")
lcpm <- cpm(x, log=TRUE)
plot(density(lcpm[,1]), col=col[1], lwd=2, ylim=c(0,0.21), las=2, main="", xlab="")
title(main="B. Filtered data", xlab="Log-cpm")
abline(v=0, lty=3)
for (i in 2:nsamples){
   den <- density(lcpm[,i])
   lines(den$x, den$y, col=col[i], lwd=2)
}
legend("topright", samplenames, text.col=col, bty="n")


#### NORMALIZATION OF SAMPLE DISTRIBUTIONS
x <- calcNormFactors(x, method = "TMM")

# create non-normalized dataset for comparison
x2 <- x
x2$samples$norm.factors <- 1
x2$counts[,1] <- ceiling(x2$counts[,1]*0.05)
x2$counts[,2] <- x2$counts[,2]*5

# Plot counts before and after normalization
par(mfrow=c(1,2))
lcpm <- cpm(x2, log=TRUE)
boxplot(lcpm, las=2, col=col, main="")
title(main="A. Example: Unnormalised data",ylab="Log-cpm")
x2 <- calcNormFactors(x2)  
x2$samples$norm.factors
lcpm <- cpm(x2, log=TRUE)
boxplot(lcpm, las=2, col=col, main="")
title(main="B. Example: Normalised data",ylab="Log-cpm")

#### PLOT SAMPLES AND LANES IN MDS ####
lcpm <- cpm(x, log=TRUE)
par(mfrow=c(1,2))
col.group <- group
levels(col.group) <-  brewer.pal(nlevels(col.group), "Set1")
col.group <- as.character(col.group)
col.lane <- lane
levels(col.lane) <-  brewer.pal(nlevels(col.lane), "Set2")
col.lane <- as.character(col.lane)
plotMDS(lcpm, labels=group, col=col.group)
title(main="A. Sample groups")
plotMDS(lcpm, labels=lane, col=col.lane, dim=c(3,4))
title(main="B. Sequencing lanes")

#### DIFFERENTIAL EXPRESSION ANALYSIS ####

# Prepare study design matrix
design <- model.matrix(~0+group+lane)
colnames(design) <- gsub("group", "", colnames(design))
design

# Prepare contrasts for sample group comparisons
contr.matrix <- makeContrasts(
   BasalvsLP = Basal - LP, 
   BasalvsML = Basal - ML, 
   LPvsML = LP - ML, 
   levels = colnames(design))
contr.matrix

# Additional normalization and model fitting
par(mfrow=c(1,2))
v <- voom(x, design, plot=TRUE)
v
vfit <- lmFit(v, design)
vfit <- contrasts.fit(vfit, contrasts=contr.matrix)
efit <- eBayes(vfit)
plotSA(efit, main="Final model: Mean−variance trend")

# Obtain preliminary results
head(efit$p.value)
summary(decideTests(efit))

# Set threshold for log-fold-changes (log-FCs) and obtain the final results
tfit <- treat(vfit, lfc=1)
dt <- decideTests(tfit)
summary(dt)
de.common <- which(dt[,1]!=0 & dt[,2]!=0)
length(de.common)
vennDiagram(dt[,1:2], circle.col=c("turquoise", "salmon"))

# Get summary
basal.vs.lp <- topTreat(tfit, coef=1, n=Inf)
basal.vs.ml <- topTreat(tfit, coef=2, n=Inf)
head(basal.vs.lp)

# visualize results
plotMD(tfit, column=1, status=dt[,1], main=colnames(tfit)[1], xlim=c(-8,13))
abline(h=c(-1, 1), col="blue")

basal.vs.lp.topgenes <- rownames(basal.vs.lp[1:100,])
i <- which(rownames(v$E) %in% basal.vs.lp.topgenes)
mycol <- colorpanel(1000,"blue","white","red")
heatmap.2(v$E[i,], scale="row",labRow=rownames(v$E)[i], labCol=group,    col=mycol, trace="none", density.info="none",    margin=c(8,6), lhei=c(2,10), dendrogram="column")

