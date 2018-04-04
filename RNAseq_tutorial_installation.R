#### INSTALL R CRAN PACKAGES
install.packages("ggplot2")
install.packages("readr")
install.packages("RColorBrewer")
install.packages("pheatmap") 
install.packages("dplyr") 

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
biocLite("DESeq2", dependencies = TRUE)
biocLite("vsn")

#### IMPORT PACKAGES ####
library(Biobase)   # core package in Bioconductor
library(GEOquery)

#### OBTAIN EXAMPLE DATASET FROM THE NCBI GEO DATABASE
#### Expression data from type 2 diabetic and non-diabetic isolated human islets

gset <- getGEO("GSE25724", GSEMatrix =TRUE, getGPL=FALSE)
gset <- gset[[1]]

#### CHECK INITIAL DATA

dev.new(width=4+dim(gset)[[2]]/5, height=6)
par(mar=c(2+round(max(nchar(sampleNames(gset)))/2),4,2,1))
title <- paste ("GSE25724", '/', annotation(gset), " selected samples", sep ='')
boxplot(exprs(gset), boxwex=0.7, notch=T, main=title, outline=FALSE, las=2, col="steelblue")


