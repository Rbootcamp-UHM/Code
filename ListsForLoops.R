### R code from vignette source 'ListsForLoops.Rnw'

###################################################
### code chunk number 1: ListsForLoops.Rnw:39-40
###################################################
options(width=50)


###################################################
### code chunk number 2: ListsForLoops.Rnw:43-47
###################################################
applicant <- list(fullname="Mickey Mouse", address="123 Main St.",  state="CA")
applicant
names(applicant) <- c("fullname", "address", "state")
applicant


###################################################
### code chunk number 3: ListsForLoops.Rnw:52-54
###################################################
applicant <- c(applicant, list(scores=matrix(1:10, nrow=2)))
applicant


###################################################
### code chunk number 4: ListsForLoops.Rnw:70-73
###################################################
applicant$fullname
applicant[1]   ## returns a list of length one
applicant[[1]]  ## returns the object within applicant[1]


###################################################
### code chunk number 5: ListsForLoops.Rnw:78-80
###################################################
applicant[1:2]
applicant[c("fullname", "address")]  


###################################################
### code chunk number 6: ListsForLoops.Rnw:84-86
###################################################
applicant[[1]]
applicant[["fullname"]]


###################################################
### code chunk number 7: ListsForLoops.Rnw:88-89 (eval = FALSE)
###################################################
## applicant[[1:2]]  ## cannot subset [[]] with more than one index


###################################################
### code chunk number 8: ListsForLoops.Rnw:91-93
###################################################
try_out <- try(applicant[[1:2]]) 
cat(try_out)


###################################################
### code chunk number 9: ListsForLoops.Rnw:97-99
###################################################
applicant
applicant[-3]


###################################################
### code chunk number 10: ListsForLoops.Rnw:104-107
###################################################
applicant[4]
applicant[[4]][2,1]  # Take the scores matrix, and grab row 2, column 1.
applicant[[4]][,3]  # Take the scores matrix, and grab all of column 3.


###################################################
### code chunk number 11: ListsForLoops.Rnw:116-117 (eval = FALSE)
###################################################
## for (var in seq) expr


###################################################
### code chunk number 12: ListsForLoops.Rnw:121-124
###################################################
for (i in 1:3) { 
   print(paste("This is a for loop", i))
}   


###################################################
### code chunk number 13: ListsForLoops.Rnw:129-130 (eval = FALSE)
###################################################
## for (applicant in applicant_list) expr


###################################################
### code chunk number 14: ListsForLoops.Rnw:136-142
###################################################
mylist <- vector("list")   ## creates a null (empty) list
mylist
for (i in 1:4) {
   mylist[i] <- list(data.frame(x=rnorm(3), y=rnorm(3)))  ## why does this have to be a list object?
}
mylist


###################################################
### code chunk number 15: ListsForLoops.Rnw:147-152
###################################################
mylist <- vector("list")   ## creates a null (empty) list
for (i in 1:4) {
   mylist <- c(mylist, list(data.frame(x=rnorm(3), y=rnorm(3))))
}
mylist


###################################################
### code chunk number 16: ListsForLoops.Rnw:159-163
###################################################
lm.out <- lm( mylist[[1]]$x  ~ mylist[[1]]$y )  ## calculate a linear regression on dataframe 1 x as a function of y
aov.out <- anova(lm.out)   ## run anova, save to aov.out
aov.out
unlist(aov.out)


