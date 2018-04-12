### R code from vignette source 'OUCHintro.Rnw'

###################################################
### code chunk number 1: OUCHintro.Rnw:62-65 (eval = FALSE)
###################################################
## require(ouch)
## data(bimac)
## bimac


###################################################
### code chunk number 2: OUCHintro.Rnw:67-70
###################################################
require(ouch)
data(bimac)
head(bimac)


###################################################
### code chunk number 3: OUCHintro.Rnw:75-76
###################################################
rownames(bimac) <- bimac$node


###################################################
### code chunk number 4: OUCHintro.Rnw:83-85
###################################################
tree <- with(bimac, ouchtree(node,ancestor,time/max(time),species))
plot(tree)


###################################################
### code chunk number 5: OUCHintro.Rnw:95-96
###################################################
plot(tree, regimes=bimac[c("OU.1", "OU.3", "OU.4", "OU.LP")], lwd=6)


###################################################
### code chunk number 6: OUCHintro.Rnw:105-106
###################################################
brown(log(bimac['size']),tree)


###################################################
### code chunk number 7: OUCHintro.Rnw:112-113
###################################################
h1 <- brown(log(bimac['size']),tree)


###################################################
### code chunk number 8: OUCHintro.Rnw:118-122
###################################################
h2 <- hansen(log(bimac['size']),tree,bimac['OU.1'],sqrt.alpha=1,sigma=1)
h3 <- hansen(log(bimac['size']),tree,bimac['OU.3'], sqrt.alpha =1,sigma=1)
h4 <- hansen(log(bimac['size']),tree,bimac['OU.4'], sqrt.alpha =1,sigma=1)
h5 <- hansen(log(bimac['size']),tree,bimac['OU.LP'], sqrt.alpha =1,sigma=1,reltol=1e-5)


###################################################
### code chunk number 9: OUCHintro.Rnw:130-132
###################################################
coef(h5)    # the coefficients of the fitted model
logLik(h5)   # the log-likelihood value


###################################################
### code chunk number 10: OUCHintro.Rnw:134-135 (eval = FALSE)
###################################################
## summary(h5)   # everything in the print method except the tree+data


###################################################
### code chunk number 11: OUCHintro.Rnw:139-145
###################################################
unlist(summary(h5)[c('aic', 'aic.c', 'sic', 'dof')])  # just the model fit statistics
                                   # on a single line
h <- list(h1, h2, h3, h4, h5)   # store all our fitted models in a list
names(h) <- c("BM", "OU.1", "OU.3", "OU.4", "OU.LP")
sapply( h, function(x) unlist(summary(x)[c('aic', 'aic.c', 'sic', 'dof')]) )  
                                   # table with all models


###################################################
### code chunk number 12: OUCHintro.Rnw:150-152
###################################################
h.ic <- sapply( h, function(x) unlist(summary(x)[c('aic', 'aic.c', 'sic', 'dof')]) )  
print( h.ic, digits = 3)


###################################################
### code chunk number 13: OUCHintro.Rnw:157-159
###################################################
h5.sim <- simulate(object = h5, nsim=10)   # saves 10 sets of simulated data
                                  #  based on OU.LP


###################################################
### code chunk number 14: OUCHintro.Rnw:163-165
###################################################
summary( update( object = h5, data = h5.sim[[1]] ) )   # fit the first dataset
h5.sim.fit <- lapply( h5.sim, function(x) update(h5, x))  # fit all 10 simulations


###################################################
### code chunk number 15: OUCHintro.Rnw:169-170
###################################################
bootstrap( object = h5, nboot=10)


###################################################
### code chunk number 16: OUCHintro.Rnw:180-181
###################################################
plot(tree, node.names=T)


###################################################
### code chunk number 17: OUCHintro.Rnw:185-187
###################################################
ou.lp <- paint( tree, subtree=c("1"="medium","9"="large","2"="small") )
plot(tree, regimes=ou.lp, node.names=T)


###################################################
### code chunk number 18: OUCHintro.Rnw:191-193
###################################################
ou.lp <- paint( tree, subtree=c("1"="medium","9"="large","2"="small"),
branch=c("38"="large","2"="medium"))


###################################################
### code chunk number 19: OUCHintro.Rnw:197-198
###################################################
plot(tree, regimes=ou.lp, node.names=T)


###################################################
### code chunk number 20: OUCHintro.Rnw:202-205
###################################################
ou.clades <- paint( tree, subtree=c("1"="A","7"="B", "8"="C"), 
branch=c("8"="C", "7"="C", "1"="A"))
plot(tree, regimes=ou.clades, node.names=T)


###################################################
### code chunk number 21: OUCHintro.Rnw:209-210
###################################################
h6 <- hansen(log(bimac['size']),tree, regimes=ou.clades, sqrt.alpha =1,sigma=1)


###################################################
### code chunk number 22: OUCHintro.Rnw:214-219
###################################################
h <- append(h, h6)         # append (add on) new model results to our list h
names(h)[length(h)] <- "OU.clades"    # add the name of the new model
names(h)
h.ic <- sapply( h, function(x) unlist(summary(x)[c('aic', 'aic.c', 'sic', 'dof')]) )  
print( h.ic, digits = 3)


