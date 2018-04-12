### R code from vignette source 'handPGLS.Rnw'

###################################################
### code chunk number 1: handPGLS.Rnw:25-32
###################################################
X <- c(4.09434, 3.61092, 2.37024, 2.02815, -1.46968)
Y <- c(4.74493, 3.33220, 3.36730, 2.89037, 2.30259)
X
Y
names(X) <- names(Y) <- c("Homo", "Pongo", "Macaca", "Ateles", "Galago")
X
Y


###################################################
### code chunk number 2: handPGLS.Rnw:38-41
###################################################
require(ape)
require(nlme)
require(MASS)


###################################################
### code chunk number 3: handPGLS.Rnw:46-50
###################################################
tree <- read.tree(text="((((Homo:0.21,Pongo:0.21):0.28,Macaca:0.49):
0.13,Ateles:0.62):0.38,Galago:1.00);")
tree
summary(tree)


###################################################
### code chunk number 4: handPGLS.Rnw:55-56
###################################################
plot(tree)


###################################################
### code chunk number 5: handPGLS.Rnw:61-63
###################################################
names(tree)
tree$edge


###################################################
### code chunk number 6: handPGLS.Rnw:68-69
###################################################
tree$tip.label


###################################################
### code chunk number 7: handPGLS.Rnw:74-76
###################################################
tree$node.label <- c(6:9)
plot(tree, show.node.label=TRUE)


###################################################
### code chunk number 8: handPGLS.Rnw:83-85
###################################################
with( tree, cbind(tree$edge, edge.length, 
labels=c(node.label[-1], tip.label)))


###################################################
### code chunk number 9: handPGLS.Rnw:92-95
###################################################
times <- c(0, .38, .38+.13, .38+.13+.28, 1, 1, 1, 1, 1)
with( tree, cbind(tree$edge, edge.length, 
labels= c(node.label[-1], tip.label), times=times[-1]))


###################################################
### code chunk number 10: handPGLS.Rnw:100-102
###################################################
tree$node.label <- as.character(times[1:4])
plot(tree, show.node.label=TRUE)


###################################################
### code chunk number 11: handPGLS.Rnw:107-111
###################################################
tbm <- matrix(nrow = 5, ncol = 5)   # could also use length(tree$tip.label)
                          # instead of 5
rownames(tbm) <- colnames(tbm) <- tree$tip.label
tbm


###################################################
### code chunk number 12: handPGLS.Rnw:116-122
###################################################
tbm[1, ] <- c(1, .79, .51, .38, 0)
tbm[2, ] <- c(.79, 1, .51, .38, 0)
tbm[3, ] <- c(.51, .51, 1, .38, 0)
tbm[4, ] <- c(.38, .38, .38, 1, 0)
tbm[5, ] <- c(rep(0, 4), 1)
tbm


###################################################
### code chunk number 13: handPGLS.Rnw:127-129
###################################################
tbmi <- ginv(tbm)
roottbmi <- chol(tbmi)


###################################################
### code chunk number 14: handPGLS.Rnw:136-138
###################################################
Z <- roottbmi %*% Y 
U <- roottbmi %*% cbind(1, X)


###################################################
### code chunk number 15: handPGLS.Rnw:143-146
###################################################
summary(lm(Z ~ U -1))
XY <- data.frame(Y, X)
summary(gls(Y ~ X, correlation=corBrownian(phy=tree), data=XY))


###################################################
### code chunk number 16: handPGLS.Rnw:150-153
###################################################
pic.X <- pic(X, tree)
pic.Y <- pic(Y, tree)
summary(lm( pic.Y ~ pic.X -1))


