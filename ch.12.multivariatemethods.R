### R code from vignette source 'multivariatemethods.Rnw'

###################################################
### code chunk number 1: multivariatemethods.Rnw:3-4
###################################################
options(width=80)


###################################################
### code chunk number 2: multivariatemethods.Rnw:38-39
###################################################
head(iris)


###################################################
### code chunk number 3: multivariatemethods.Rnw:46-47
###################################################
pc.iris <- princomp (~ .-Species, data=iris, scores=T)


###################################################
### code chunk number 4: multivariatemethods.Rnw:52-53
###################################################
summary(pc.iris)


###################################################
### code chunk number 5: multivariatemethods.Rnw:58-59
###################################################
loadings(pc.iris)


###################################################
### code chunk number 6: multivariatemethods.Rnw:66-67
###################################################
head(pc.iris$scores)


###################################################
### code chunk number 7: multivariatemethods.Rnw:72-76
###################################################
pc1 <- pc.iris$scores[,1]
pc2 <- pc.iris$scores[,2]
pc3 <- pc.iris$scores[,3]
plot(pc2 ~ pc1, col=iris$Species, cex=2, pch=16)


###################################################
### code chunk number 8: multivariatemethods.Rnw:83-84
###################################################
plot(pc2 ~ pc1, col=iris$Species, cex=2, pch=16, ylim=c(-3, 4))


###################################################
### code chunk number 9: multivariatemethods.Rnw:90-91
###################################################
plot(pc3 ~ pc1, col=iris$Species, cex=2, pch=16, ylim=c(-3, 4))


###################################################
### code chunk number 10: multivariatemethods.Rnw:94-95
###################################################
plot(pc3 ~ pc2, col=iris$Species, cex=2, pch=16, ylim=c(-3, 4), xlim=c(-3, 4))


###################################################
### code chunk number 11: multivariatemethods.Rnw:100-101
###################################################
manova.iris <- manova( cbind(pc1, pc2, pc3) ~ Species, data=iris)


###################################################
### code chunk number 12: multivariatemethods.Rnw:105-106
###################################################
summary(manova.iris)


###################################################
### code chunk number 13: multivariatemethods.Rnw:110-111
###################################################
summary(manova.iris, test="Wilks")


###################################################
### code chunk number 14: multivariatemethods.Rnw:115-116
###################################################
summary.aov(manova.iris)


###################################################
### code chunk number 15: multivariatemethods.Rnw:123-126
###################################################
pc.iris.cor <- princomp (~ .-Species, data=iris, scores=T, cor=T)
summary(pc.iris.cor)
loadings(pc.iris.cor)


###################################################
### code chunk number 16: multivariatemethods.Rnw:138-144
###################################################
require(candisc)

iris.multiv <- lm( cbind(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) ~ Species, data=iris )
iris.can <- candisc( iris.multiv, term="Species")
iris.can
plot(iris.can, col=iris$Species)


###################################################
### code chunk number 17: multivariatemethods.Rnw:151-154
###################################################
iris.can$structure
iris.can$eigenvalues
iris.can$pct


