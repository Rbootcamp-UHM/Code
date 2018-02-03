###################################################
### chunk number 1: 
###################################################
options(width=80)


###################################################
### chunk number 2: 
###################################################
xx <- c(1, 5, 2, 3, 5)
xx


###################################################
### chunk number 3: 
###################################################
xx[1]
xx[3]


###################################################
### chunk number 4: 
###################################################
xx[length(xx)]


###################################################
### chunk number 5: 
###################################################
xx[c(1, 3, 4)]
xx[1:3]
xx[c(1, length(xx))]  # first and last


###################################################
### chunk number 6: 
###################################################
xx
xx[-1]  # exclude first
xx[-2] # exclude second
xx[-(1:3)] # exclude first through third
xx[-c(2, 4)] # exclude second and fourth, etc. 


###################################################
### chunk number 7: 
###################################################
xx[ c( T, F, T, F, T) ]  # T is the same as TRUE


###################################################
### chunk number 8: 
###################################################
xx > 2
xx[ xx > 2 ]
xx > 2 & xx < 5
xx[ xx>2 & xx<5]


###################################################
### chunk number 9: 
###################################################
rm(list=ls())
require(geiger)
data(geospiza)   # load the dataset into the workspace
ls()               # list the objects in the workspace


###################################################
### chunk number 10: 
###################################################
class(geospiza)
attributes(geospiza)


###################################################
### chunk number 11: 
###################################################
geo <- geospiza$geospiza.data
dim(geo)


###################################################
### chunk number 12:  eval=FALSE
###################################################
## geo <- read.csv("Data/geospiza_raw.csv")
## dim(geo)


###################################################
### chunk number 13: 
###################################################
attributes(geo)


###################################################
### chunk number 14:  eval=FALSE
###################################################
## geo     # the entire object, same as geo[] or geo[,]
## geo[c(1, 3), ]   # select the first and third rows, all columns
## geo[, 3:5]   # all rows, third through fifth columns
## geo[1, 5]  # first row, fifth column (a single number)
## geo[1:2, c(3, 1)]  # first and second row, third and first column (2x2 matrix)
## geo[-c(1:3, 10:13), ]  # everything but the first three and last three rows
## geo[ 1:3, 5:1]  # first three species, but variables in reverse order


###################################################
### chunk number 15: 
###################################################
geom <- as.matrix( geo ) 
class(geom)
class(geo)
geo[1,5]  # try a few more from the choices above to test


###################################################
### chunk number 16: 
###################################################
geo["pauper", "wingL"]  # row pauper, column wingL
geo["pauper", ]  # row pauper, all columns 


###################################################
### chunk number 17: 
###################################################
sp <- rownames(geo)
sp                            # a vector of the species names
sp[c(7,8,10)]     # the ones we want are #7,8, and 10
geo[ sp[c(7,8,10)], ]  # rows 7,8 and 10, same as geo[c(7, 8, 10)]


###################################################
### chunk number 18:  eval=FALSE
###################################################
## geo[3]   # third column
## geo["culmenL"]  # same
## geo[c(3,5)]  # third and fifth column
## geo[c("culmenL", "gonysW")]  # same


###################################################
### chunk number 19: 
###################################################
geo$culmenL


###################################################
### chunk number 20: 
###################################################
mylist <- list( vec = 2*1:10, mat = matrix(1:10, nrow=2), cvec = c("frogs", "birds"))
mylist
mylist[[2]]
mylist[["vec"]]
# mylist[[1:3]]  # gives an error if you uncomment it
mylist$cvec


###################################################
### chunk number 21: 
###################################################
sp <- rownames(geo)
grep(pattern = "p", x = sp)  # returns indices   
grep("p", sp, value=T)  # returns the species names which match
grep("p", sp, ignore.case=T, value=T)   # case-sensitive by default
grep("^P", sp, value=T)  # only those which start with (^) capital P


###################################################
### chunk number 22: 
###################################################
sp <- rownames(geo)
sub(pattern = "^P", replacement = "p", sp)
rownames(geo) <- sub(pattern = "^P", replacement = "p", sp)   # to save changes


###################################################
### chunk number 23:  eval=FALSE
###################################################
## sort(rownames(geo))
## geo[ sort(rownames(geo)), ]


###################################################
### chunk number 24: 
###################################################
order(rownames(geo))   # the order that the species should take to be
                 #  sorted from a-z
rbind(rownames(geo), order(rownames(geo)))  # to illustrate
oo <- order(rownames(geo))
geo[oo,]   # sorted in alpha order


###################################################
### chunk number 25: 
###################################################
sp <- substring(rownames(geo), first=1, last=1)
oo <- order(sp , geo$tarsusL) # order by first letter species, then tarsusL
geot <- geo[oo,]["tarsusL"]   # ordered geo dataframe, take only the wingL column
geo <- geo[oo,]


###################################################
### chunk number 26: 
###################################################
geot > 3    # a logical index 
geot == 3  # must match exactly 3, none do
geot[ geot > 3 ]   # use to get observations which have tarsus > 3
#  ii <- geot > 3    # these two lines of code accomplish the same
#  geot[ii]
cbind(geo["tarsusL"], geot > 3)  # check
geo[geot>3, ]["tarsusL"]  # what does this do?


###################################################
### chunk number 27: 
###################################################
geo [ geo<2 ] <- NA


###################################################
### chunk number 28: 
###################################################
!is.na(geo$gonysW) 
geo[!is.na(geo$gonysW) & geo$wingL > 4, ]  # element by element "and"
geo[!is.na(geo$gonysW) | geo$wingL > 4, ]   # element by element "or"
!is.na(geo$gonysW) && geo$wingL > 4   # vectorwise "and"


###################################################
### chunk number 29:  eval=FALSE
###################################################
## geo[rownames(geo) == "pauper",]   # same as   geo["pauper", ]
## geo[rownames(geo) < "pauper",]


###################################################
### chunk number 30:  eval=FALSE
###################################################
## newsp <- c("clarkii", "pauper", "garmani")
## newsp[newsp  %in% rownames(geo)]     # which new species are in geo?


###################################################
### chunk number 31:  eval=FALSE
###################################################
## "%w/o%" <- function(x, y) x[!x %in% y]
## newsp  %w/o% rownames(geo)   # which new species are not in geo?


###################################################
### chunk number 32: 
###################################################
geot$ecology <- LETTERS[1:nrow(geot)]   # A:M


###################################################
### chunk number 33: 
###################################################
                    # only maches to both datasets are included
merge(x=geo["tarsusL"], y=geot[1:5, ], by= "row.names")    
                    # all species in both datasets are included
merge(x=geo["tarsusL"], y=geot[1:5,], by= "row.names", all=T)    


###################################################
### chunk number 34: 
###################################################
geo <- geo[rev(rownames(geo)), ]   # reverse the species order of geo
                     # merge on geo first, then geot
merge(x=geo["tarsusL"], y=geot[1:5, ], by= "row.names", sort=F)   
                     # geot first, then geo
merge(x=geot[1:5,], y=geo["tarsusL"], by= "row.names", sort=F)   


###################################################
### chunk number 35: 
###################################################
vv <- 1:10  # a vector
mm <- matrix( vv, nrow=2)  # a matrix
mm
dim(mm) <- NULL
mm <- matrix( vv, nrow=2, byrow=T)  # a matrix, but cells are now filled by row
mm
dim(mm) <- NULL
mm  # vector is now n a different order because the collapse occurred by column


###################################################
### chunk number 36:  eval=FALSE
###################################################
## unlist(geo)   # produces a vector from the dataframe
##             # the atomic type of a dataframe is a list
## unclass(geo)  # removes the class attribute, turning the dataframe into a 
##             # series of vectors  plus any names attributes, same as setting 
##             # class(geo) <- NULL
## c(geo)  # similar to unclass but without the attributes            


###################################################
### chunk number 37: 
###################################################
species <- LETTERS[1:7]
x <- c(2, 4, 8)
y <- c(rnorm(7, mean=-2, sd=0.5), rnorm(7), rnorm(7, mean=5, sd=3))
y1 <- c(rnorm(7, mean=-2, sd=0.5), rnorm(7), rnorm(7, mean=5, sd=3))
y
y1
dat <- data.frame(species, x, treatment=factor(rep(c("low", "med",
 "high"), each=7), levels=c("low", "med", "high")), y, y1) 
dat


