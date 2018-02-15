### R code from vignette source 'ApplyFunctions.Rnw'

###################################################
### code chunk number 1: ApplyFunctions.Rnw:38-41
###################################################
square <- function( x ) {
  return (x*x)
  }


###################################################
### code chunk number 2: ApplyFunctions.Rnw:46-51
###################################################
xx <- vector(length=10)   ## create a container for output
for ( i in 1:10 ) {         ## step through i`s from 1 to 10
  xx[i] <- square( i )   ## run square function for each i
  }
xx  


###################################################
### code chunk number 3: ApplyFunctions.Rnw:58-59
###################################################
sapply( 1:10, square ) 


###################################################
### code chunk number 4: ApplyFunctions.Rnw:64-65 (eval = FALSE)
###################################################
## sapply( X, FUN, ...)


###################################################
### code chunk number 5: ApplyFunctions.Rnw:72-74
###################################################
sapply( 1:5, square ) 
lapply( 1:5, square )


###################################################
### code chunk number 6: ApplyFunctions.Rnw:83-84 (eval = FALSE)
###################################################
## sapply( X, FUN, arg1, arg2, ...)


###################################################
### code chunk number 7: ApplyFunctions.Rnw:89-90
###################################################
sample(5, replace=T)


###################################################
### code chunk number 8: ApplyFunctions.Rnw:95-96
###################################################
sapply( c(5, 5, 5, 5), sample, replace=T)


###################################################
### code chunk number 9: ApplyFunctions.Rnw:105-113 (eval = FALSE)
###################################################
## myfunction <- function (file, y=NULL, z=NULL) {
##   xx <- read.csv(file)
##   plot(xx, ...) 
##   zz <- some_other_function (x,y,z)
##   ... 
##   return (out)
##   }
## sapply(  list_of_filenames ,  myfunction, y=blah1, z=blah2) 


###################################################
### code chunk number 10: ApplyFunctions.Rnw:118-121 (eval = FALSE)
###################################################
## sapply( input, function(x) {
##   ...lines_of_code... 
##   })


###################################################
### code chunk number 11: ApplyFunctions.Rnw:127-128
###################################################
sapply ( 1:10, function(x)  x*x )


###################################################
### code chunk number 12: ApplyFunctions.Rnw:132-137
###################################################
xx <- vector(length=10)   ## create a container for output
for ( i in 1:10 ) {         ## step through i?s from 1 to 10
  xx[i] <- square( i )   ## run square function for each i
  }
xx  


###################################################
### code chunk number 13: ApplyFunctions.Rnw:142-143
###################################################
xx <- sapply ( 1:10, function(x)  x*x )


###################################################
### code chunk number 14: ApplyFunctions.Rnw:152-156
###################################################
mylist <- vector("list")   ## creates a null (empty) list
for (i in 1:4) {
   mylist[i] <- list(data.frame(x=rnorm(3), y=rnorm(3)))  ## why does this have to be a list object?
}


