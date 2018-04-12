### R code from vignette source 'IC_OUCHexamples.Rnw'

###################################################
### code chunk number 1: IC_OUCHexamples.Rnw:50-51
###################################################
options(width=75)


###################################################
### code chunk number 2: IC_OUCHexamples.Rnw:54-57
###################################################
require(ouch)
data(anolis.ssd)
anolis.ssd


###################################################
### code chunk number 3: IC_OUCHexamples.Rnw:60-62
###################################################
dat <- anolis.ssd[!is.na(anolis.ssd$species),]   # dropping the rows with NA (internal nodes)
dat


###################################################
### code chunk number 4: IC_OUCHexamples.Rnw:67-70 (eval = FALSE)
###################################################
## dat[ c("species", "log.SSD", "OU.7" ) ]   # by column name
## dat[ c(2, 3, 7) ]   # by column number
## dat[ - c(1, 4, 5, 6) ]   # by excluding some column numbers (-)


###################################################
### code chunk number 5: IC_OUCHexamples.Rnw:72-73
###################################################
dat <- dat[ c(2, 3, 7) ]   # resave just the columns we need


###################################################
### code chunk number 6: IC_OUCHexamples.Rnw:77-79
###################################################
names(dat) <- c( "species", "lssd", "ecomorph")   # rename all the columns
names(dat)[2:3]  <- c("lssd", "ecomorph")     # rename just the 2, 3 columns (first was OK)


###################################################
### code chunk number 7: IC_OUCHexamples.Rnw:83-86
###################################################
lssd <- dat$lssd
ecomorph <- dat$ecomorph
names(lssd) <- names(ecomorph) <-  dat$species


###################################################
### code chunk number 8: IC_OUCHexamples.Rnw:93-94
###################################################
plot( ecomorph, lssd)


###################################################
### code chunk number 9: IC_OUCHexamples.Rnw:99-100
###################################################
ecomorph <- factor(ecomorph)


###################################################
### code chunk number 10: IC_OUCHexamples.Rnw:105-109
###################################################
ssd.lm <- lm( lssd ~ ecomorph, data=dat)   # use data to specify dataframe, and then the objects are columns of dat
  # the ~ operator is read "model lssd as a function of ecomorph"
ssd.lm
anova( ssd.lm )


###################################################
### code chunk number 11: IC_OUCHexamples.Rnw:115-118
###################################################
require(ape)
atree <- read.nexus("Data/anolis.ssd.23tree.nex")  # read in as ape tree
plot(atree)   # check that it looks OK


###################################################
### code chunk number 12: IC_OUCHexamples.Rnw:124-127
###################################################
ssd.pgls <- gls( lssd ~ ecomorph, correlation=corBrownian(phy=atree), data=dat)
summary(ssd.pgls)
anova(ssd.pgls)   # produces the ANOVA F-ratio test for the overall effect of ecomorph


###################################################
### code chunk number 13: IC_OUCHexamples.Rnw:133-142
###################################################
data(anolis.ssd)
tree <- with(anolis.ssd,ouchtree(node,ancestor,time/max(time),species))
plot(tree,node.names=TRUE)
h1 <- brown(anolis.ssd['log.SSD'],tree)
plot(h1)
h2 <- hansen(anolis.ssd['log.SSD'],tree,anolis.ssd['OU.1'],sqrt.alpha=1,sigma=1)
plot(h2)
h3 <- hansen(anolis.ssd['log.SSD'],tree,anolis.ssd['OU.7'],sqrt.alpha=1,sigma=1)
plot(h3)


###################################################
### code chunk number 14: IC_OUCHexamples.Rnw:148-150
###################################################
coef(h3)    # the coefficients of the fitted model
logLik(h3)   # the log-likelihood value


###################################################
### code chunk number 15: IC_OUCHexamples.Rnw:152-153 (eval = FALSE)
###################################################
## summary(h3)   # everything in the print method except the tree+data


###################################################
### code chunk number 16: IC_OUCHexamples.Rnw:157-163
###################################################
unlist(summary(h3)[c('aic', 'aic.c', 'sic', 'dof')])  # just the model fit statistics
                                   # on a single line
h <- list(h1, h2, h3)   # store all our fitted models in a list
names(h) <- c("BM", "OU.1", "OU.7")
sapply( h, function(x) unlist(summary(x)[c('aic', 'aic.c', 'sic', 'dof')]) )  
                                   # table with all models


###################################################
### code chunk number 17: IC_OUCHexamples.Rnw:168-170
###################################################
h.ic <- sapply( h, function(x) unlist(summary(x)[c('aic', 'aic.c', 'sic', 'dof')]) )  
print( h.ic, digits = 3)


