### R code from vignette source 'dataIO.Rnw'

###################################################
### code chunk number 1: dataIO.Rnw:3-4
###################################################
options(width=80)


###################################################
### code chunk number 2: dataIO.Rnw:19-21 (eval = FALSE)
###################################################
## getwd()
## setwd("~/Rclass")  # my folder is at the top level of my user directory


###################################################
### code chunk number 3: dataIO.Rnw:28-29 (eval = FALSE)
###################################################
## read.csv("Data/anolis.csv")  # look for the file in the Data directory


###################################################
### code chunk number 4: dataIO.Rnw:36-37
###################################################
anolis <- read.csv("Data/anolis.csv")  


###################################################
### code chunk number 5: dataIO.Rnw:42-44
###################################################
head(anolis)
tail(anolis)


###################################################
### code chunk number 6: dataIO.Rnw:58-59
###################################################
aggregate(anolis$logSSD, by=list(anolis$ecomorph), mean)


###################################################
### code chunk number 7: dataIO.Rnw:67-70
###################################################
anolis.mean <- aggregate(anolis$logSSD, by=list(anolis$ecomorph), mean)
anolis.sd <- aggregate(anolis$logSSD, by=list(anolis$ecomorph), sd)
anolis.sd


###################################################
### code chunk number 8: dataIO.Rnw:75-78
###################################################
names(anolis.mean)   # check that this is what we want to modify
names(anolis.mean) <- c("ecomorph", "mean")
names(anolis.sd) <- c("ecomorph", "sd")


###################################################
### code chunk number 9: dataIO.Rnw:83-85
###################################################
anolis.N <- aggregate(anolis$logSSD, by=list(anolis$ecomorph), length)
names(anolis.N) <- c("ecomorph", "N")


###################################################
### code chunk number 10: dataIO.Rnw:93-94
###################################################
merge(anolis.mean, anolis.sd)


###################################################
### code chunk number 11: dataIO.Rnw:99-100
###################################################
out <- merge(anolis.mean, anolis.sd, by="ecomorph")


###################################################
### code chunk number 12: dataIO.Rnw:107-109
###################################################
out <- merge(out, anolis.N, by="ecomorph")
out


###################################################
### code chunk number 13: dataIO.Rnw:114-116
###################################################
out$se <- out$sd / sqrt(out$N)
out


###################################################
### code chunk number 14: dataIO.Rnw:123-124
###################################################
write.csv(out, "anolis.summary.csv", row.names=FALSE)


###################################################
### code chunk number 15: dataIO.Rnw:133-134
###################################################
save( anolis, anolis.mean, anolis.sd, anolis.N, file="anolis.out.Rdata")


###################################################
### code chunk number 16: dataIO.Rnw:138-139
###################################################
load("anolis.out.Rdata")


###################################################
### code chunk number 17: dataIO.Rnw:148-149
###################################################
barplot(out$mean, names.arg=out$ecomorph)


###################################################
### code chunk number 18: dataIO.Rnw:154-155
###################################################
barplot(out$mean, names.arg=out$ecomorph, col=rainbow(6), ylab="logSSD")


###################################################
### code chunk number 19: dataIO.Rnw:160-164
###################################################
bb <- barplot(out$mean, names.arg=out$ecomorph, col=c("red", "red", "red", "blue",
 "blue", "red"), ylab="logSSD", cex.lab=1.5, ylim=c(0, max(out$mean)+.1))
bb
arrows(bb, out$mean, bb, out$mean+out$se, angle=90)


###################################################
### code chunk number 20: dataIO.Rnw:172-176
###################################################
pdf(file="anolisMeanSSD.pdf")  # turns on the pdf device for plotting
barplot(out$mean, names.arg=out$ecomorph, col=c("red", "red", "red", "blue", 
"blue", "red"), ylab="logSSD", cex.lab=1.5)
dev.off()  # turns off pdf device for output


###################################################
### code chunk number 21: dataIO.Rnw:199-200 (eval = FALSE)
###################################################
## readLines("Data/20070725_01forirr.txt")


###################################################
### code chunk number 22: dataIO.Rnw:204-207
###################################################
temp <- readLines("Data/20070725_01forirr.txt")
head(temp)
tail(temp)


###################################################
### code chunk number 23: dataIO.Rnw:212-216
###################################################
dat <- read.table(file="Data/20070725_01forirr.txt", skip=17, comment.char=">")
names(dat) <- c("lambda", "intensity")
head(dat)
tail(dat)


###################################################
### code chunk number 24: dataIO.Rnw:221-223
###################################################
dat <- dat[dat$lambda >= 300, ]  # cut off rows below 300nm
dat <- dat[dat$lambda <= 750, ]  #cut off rows above 750nm


###################################################
### code chunk number 25: dataIO.Rnw:227-228
###################################################
dat <- dat[dat$lambda >= 300 & dat$lambda <= 750,]


###################################################
### code chunk number 26: dataIO.Rnw:233-235
###################################################
oo <- dat$lambda >= 300 & dat$lambda <= 750
dat <- dat[oo, ]   # same as longer version above


###################################################
### code chunk number 27: dataIO.Rnw:240-241
###################################################
write.csv(dat, "20070725_01forirr.csv")


