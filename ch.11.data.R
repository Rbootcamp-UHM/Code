### R code from vignette source 'data.Rnw'

###################################################
### code chunk number 1: data.Rnw:47-57
###################################################
datja <- read.fwf('Data/94morphja.dat', widths=c(13, 1, -1, 5, 5, 5, -1, 1, 5, 5, 5, 3, -5, -5, -1, 1), as.is=T, strip.white=T) 
datpr <- read.fwf('Data/94morphpr.dat', widths=c(13, 1, -1, 5, 5, 5, -1, 1, 5, 5, 5, 3, -5, -5, -1, 1), as.is=T, strip.white=T) 
names(datpr) <- names(datja) <- c('species', 'sex', 'svl', 'mass', 'tail', 'regen', 
'forel', 'hindl', 'headl', 'lamn', 'food')
head(datja)
tail(datja)
head(datpr)
tail(datja)


###################################################
### code chunk number 2: data.Rnw:62-64
###################################################
datpr$island <- "Puerto Rico"
datja$island <- "Jamaica"


###################################################
### code chunk number 3: data.Rnw:70-72
###################################################
names(datja)
names(datpr)


###################################################
### code chunk number 4: data.Rnw:76-77
###################################################
names(datja) == names(datpr)


###################################################
### code chunk number 5: data.Rnw:81-82
###################################################
sum(names(datja) != names(datpr))


###################################################
### code chunk number 6: data.Rnw:86-87
###################################################
dat <- rbind(datja, datpr)


###################################################
### code chunk number 7: data.Rnw:97-104
###################################################
spp <- unique(dat$species) 
spp                         # list of species in our sample
tgspp <- c("cristatellus", "gundlachi", "sagrei", "lineatopus")
tcspp <- c("stratulus", "evermanni", "grahami")
cgspp <- c("cuvieri", "garmani")
gbspp <- c("krugi", "pulchellus")
twspp <- c("occultus", "valencienni")


###################################################
### code chunk number 8: data.Rnw:108-112
###################################################
ecospp <- c(tgspp, tcspp, cgspp, gbspp, twspp)
length(ecospp)
length(spp)
ecospp == unique(ecospp)  # if any are duplicated or missing, will get some FALSE


###################################################
### code chunk number 9: data.Rnw:116-119
###################################################
"%w/o%" <- function(x, y) x[!x %in% y]
ecospp %w/o% spp
spp %w/o% ecospp


###################################################
### code chunk number 10: data.Rnw:126-131
###################################################
tgi <- dat$species %in% tgspp
tci <- dat$species %in% tcspp
cgi <- dat$species %in% cgspp
gbi <- dat$species %in% gbspp
twi <- dat$species %in% twspp


###################################################
### code chunk number 11: data.Rnw:136-137
###################################################
dat$ecomorph[twi] <- "twig"


###################################################
### code chunk number 12: data.Rnw:142-143 (eval = FALSE)
###################################################
## cbind(twi, dat[, c('species', 'ecomorph')])


###################################################
### code chunk number 13: data.Rnw:145-146
###################################################
cbind(twi, dat[, c('species', 'ecomorph')])[151:157,]


###################################################
### code chunk number 14: data.Rnw:151-155
###################################################
dat$ecomorph[tgi] <- "trunk-ground"
dat$ecomorph[tci] <- "trunk-crown"
dat$ecomorph[cgi] <- "crown-giant"
dat$ecomorph[gbi] <- "grass-bush"


###################################################
### code chunk number 15: data.Rnw:160-162
###################################################
head(dat)
head(dat$ecomorph)


###################################################
### code chunk number 16: data.Rnw:168-170
###################################################
o <- order(dat$species, dat$sex)
dat <- dat[o, ]


###################################################
### code chunk number 17: data.Rnw:175-176
###################################################
apply(dat, 2, mode)


###################################################
### code chunk number 18: data.Rnw:180-181
###################################################
dat[dat=='.'] <- NA


###################################################
### code chunk number 19: data.Rnw:185-186
###################################################
dat <- dat[dat$sex %in% c('m', 'f'), ]


###################################################
### code chunk number 20: data.Rnw:189-190
###################################################
dat$tail[ dat$regen == "r" ] <- NA


###################################################
### code chunk number 21: data.Rnw:194-195 (eval = FALSE)
###################################################
## dat[c("regen", "tail")] 


###################################################
### code chunk number 22: data.Rnw:197-198
###################################################
head( dat[c("regen", "tail")] )


###################################################
### code chunk number 23: data.Rnw:202-205
###################################################
dat.num <- dat[c('svl', 'mass', 'tail', 'forel', 'hindl', 'headl', 'lamn')]  
dat.num <- as.data.frame( apply(dat.num, 2, as.numeric) )
apply(dat.num, 2, mode)


###################################################
### code chunk number 24: data.Rnw:211-216
###################################################
op <- par(no.readonly = TRUE)
par(mfrow=c(1,2))
with(dat.num, plot(svl, mass, xlab="SVL", ylab="Mass"))
with(dat.num, plot(log(svl), log(mass), xlab="logSVL", ylab="logMass"))
par(op)


###################################################
### code chunk number 25: data.Rnw:220-224
###################################################
dat.mean <- aggregate( log(dat.num), list(species=dat$species, sex=dat$sex), 
mean, na.rm=T)
dat.sd <- aggregate( log(dat.num), list(species=dat$species, sex=dat$sex), 
function(x) {if (all(is.na(x))) return(NA) else return(sd(x, na.rm=T))})


###################################################
### code chunk number 26: data.Rnw:228-232
###################################################
dd <- split(dat.mean, dat.mean$sex) 
fems <- dd[[1]]
mals <- dd[[2]]
sexes_sf <- merge(fems, mals, by="species", suffixes=c(".f", ".m"))


###################################################
### code chunk number 27: data.Rnw:237-238
###################################################
sexdim <- mals[-(1:2)] - fems[-(1:2)]   # computes male larger dimorphism value


###################################################
### code chunk number 28: data.Rnw:253-254 (eval = FALSE)
###################################################
## dat.sd <- aggregate(dat.num, list(species=dat$species, sex=dat$sex), sd, na.rm=T)


###################################################
### code chunk number 29: data.Rnw:257-259
###################################################
dat.sd <- aggregate(dat.num, list(species=dat$species, sex=dat$sex), 
function(x) {if (all(is.na(x))) return(NA) else return(sd(x, na.rm=T))})


###################################################
### code chunk number 30: data.Rnw:264-265 (eval = FALSE)
###################################################
## fix(sd)


###################################################
### code chunk number 31: data.Rnw:269-273 (eval = FALSE)
###################################################
## #function (x, na.rm = FALSE) 
## #{
## #	if (all(is.na(x))) return(NA)   ## Put this above the first line of the function
## #    else if (is.matrix(x))      ## and change the if to else if here


###################################################
### code chunk number 32: data.Rnw:277-278 (eval = FALSE)
###################################################
## dat.sd <- aggregate(dat.num, list(species=dat$species, sex=dat$sex), sd, na.rm=T)


###################################################
### code chunk number 33: data.Rnw:282-286 (eval = FALSE)
###################################################
## sd <- function (x, na.rm=FALSE)  sqrt(var(x,na.rm=na.rm,
## use='pairwise.complete.obs'))
## dat.sd <- aggregate(dat.num, list(species=dat$species, sex=dat$sex),
##  sd, na.rm=T)


###################################################
### code chunk number 34: data.Rnw:292-294
###################################################
dat.N <- aggregate(dat.num, list(species=dat$species, sex=dat$sex), 
function(x) { x<- x[!is.na(x)]; length(x)})


###################################################
### code chunk number 35: data.Rnw:298-300
###################################################
dat.N <- aggregate(dat.num, list(species=dat$species, sex=dat$sex),
 function(x) { length(x[!is.na(x)])})


###################################################
### code chunk number 36: data.Rnw:306-307
###################################################
save(dat, dat.mean, dat.sd, dat.N, file="Rdata/anolis_dat.rda")


