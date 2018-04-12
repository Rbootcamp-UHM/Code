### R code from vignette source 'simpleCA.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: simpleCA.Rnw:59-60
###################################################
require(ape)


###################################################
### code chunk number 2: simpleCA.Rnw:62-63
###################################################
options(width=80)


###################################################
### code chunk number 3: simpleCA.Rnw:69-73
###################################################
tree.primates <- read.tree(text="((((Homo:0.21,Pongo:0.21):0.28,Macaca:0.49):
0.13,Ateles:0.62):0.38,Galago:1.00);")
tree.primates
summary(tree.primates)


###################################################
### code chunk number 4: simpleCA.Rnw:78-79
###################################################
plot(tree.primates)


###################################################
### code chunk number 5: a (eval = FALSE)
###################################################
## pdf(file="primatetree.pdf")      # turn on pdf device for output
## plot(tree.primates)            # plot the tree to the pdf file
## dev.off()               # turn off pdf device to return output to the default
## 
## save(tree.primates, file="tree.primates.rda")  # save tree in Rdata format


###################################################
### code chunk number 6: simpleCA.Rnw:94-96
###################################################
class(tree.primates)
str(tree.primates)


###################################################
### code chunk number 7: simpleCA.Rnw:101-104
###################################################
plot(tree.primates)
nodelabels()
tiplabels()


###################################################
### code chunk number 8: simpleCA.Rnw:109-110
###################################################
tree.primates$edge


###################################################
### code chunk number 9: simpleCA.Rnw:115-116
###################################################
tree.primates$tip.label


###################################################
### code chunk number 10: simpleCA.Rnw:121-122
###################################################
tree.primates$edge.length


###################################################
### code chunk number 11: simpleCA.Rnw:131-138
###################################################
X <- c(4.09434, 3.61092, 2.37024, 2.02815, -1.46968)
Y <- c(4.74493, 3.33220, 3.36730, 2.89037, 2.30259)
X
Y
names(X) <- names(Y) <- c("Homo", "Pongo", "Macaca", "Ateles", "Galago")
X
Y


###################################################
### code chunk number 12: simpleCA.Rnw:145-153
###################################################
pic.X <- pic(X, tree.primates)
pic.Y <- pic(Y, tree.primates)
pic.X
pic.Y
cor.test(pic.X, pic.Y)
lm.YX <- lm(pic.Y ~ pic.X - 1) # this is a regression of Y "as a function" of X, 
                           # with -1 meaning no intercept (through origin)
summary(lm.YX)    # this shows us the p-values and summary statistics


###################################################
### code chunk number 13: xy
###################################################
plot(X, Y)   # same as plot(Y ~ X)


###################################################
### code chunk number 14: simpleCA.Rnw:163-164
###################################################
plot(X, Y)   # same as plot(Y ~ X)


###################################################
### code chunk number 15: simpleCA.Rnw:169-170
###################################################
summary(lm(Y ~ X -1))


###################################################
### code chunk number 16: simpleCA.Rnw:175-178 (eval = FALSE)
###################################################
## quartz()
## plot(pic.X, pic.Y)
## title("Independent Contrast Plot of Primate Data")   


###################################################
### code chunk number 17: simpleCA.Rnw:182-184
###################################################
plot(pic.X, pic.Y)   
title("Independent Contrast Plot of Primate Data")   


###################################################
### code chunk number 18: simpleCA.Rnw:249-251
###################################################
tree <- tree.primates
bm.prim <- corBrownian(phy=tree)


###################################################
### code chunk number 19: simpleCA.Rnw:256-259
###################################################
require(nlme)
XY <- data.frame(Y, X)
summary(gls(Y ~ X, correlation=corBrownian(phy=tree), data=XY))


###################################################
### code chunk number 20: simpleCA.Rnw:268-270 (eval = FALSE)
###################################################
## corGrafen(value, tree, fixed=FALSE)
## corMartins(value, tree, fixed=FALSE)


###################################################
### code chunk number 21: simpleCA.Rnw:280-284
###################################################
ancstatesML <- ace(X, tree, type="continuous")
ancstatesPIC <- ace(X, tree, type="continuous", method="pic")
ancstatesML
ancstatesPIC


###################################################
### code chunk number 22: simpleCA.Rnw:300-303
###################################################
plot(tree, type="cladogram", label.offset=.05)
tiplabels(pch=21, cex= X, bg="yellow")
nodelabels(pch=21, cex= ancstatesML$ace, bg="yellow")


###################################################
### code chunk number 23: simpleCA.Rnw:308-309 (eval = FALSE)
###################################################
## plot(tree, type="cladogram", use.edge.length=FALSE, label.offset=.05)


###################################################
### code chunk number 24: simpleCA.Rnw:313-314
###################################################
save(tree.primates, X, Y, file="tree.primates.rda")


