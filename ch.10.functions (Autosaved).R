### R code from vignette source 'functions.Rnw'

###################################################
### code chunk number 1: functions.Rnw:3-4
###################################################
options(width=80)


###################################################
### code chunk number 2: functions.Rnw:24-25
###################################################
# my_function_name <- function( argument )  statement


###################################################
### code chunk number 3: functions.Rnw:31-34
###################################################
mysq <- function( x ) {   # function name is mysq
	x*x      # the function will return the square of x
}


###################################################
### code chunk number 4: functions.Rnw:38-39
###################################################
mysq(2)


###################################################
### code chunk number 5: functions.Rnw:44-50
###################################################
mysq <- function( x ) {
	plot( x, x*x, ylab="Square of x")	  # plot x and x*x on the y axis
	return (x*x)   	# return the square of x
	}
	
mysq(1:10)	


###################################################
### code chunk number 6: functions.Rnw:57-65
###################################################
mysq <- function( x, yylab="Square of x" ) {   # default argument for the y-label

	plot( x, x*x, ylab=yylab)	
	return (x*x)   	

	}
	
mysq(1:10, yylab="X times X")	


###################################################
### code chunk number 7: functions.Rnw:69-70
###################################################
mysq(1:10)


###################################################
### code chunk number 8: functions.Rnw:76-84
###################################################
mysq <- function( x, yylab=NULL) {   # default arg is no value for the y-label, 

	plot( x, x*x, ylab=yylab)	# but you can specify it if you want to.
	return (x*x)   	

	}
	
mysq(1:10, yylab="X times X")	


###################################################
### code chunk number 9: functions.Rnw:90-92
###################################################
mysq(2)
mysq(x=2)


###################################################
### code chunk number 10: functions.Rnw:97-99
###################################################
mysq( c(1, 3, 5, 7), "Squares of prime numbers")
mysq( yylab = "Squares of prime numbers", x=c(1, 3, 5, 7))


###################################################
### code chunk number 11: functions.Rnw:107-112
###################################################
myfun <- function(x, y,  ...) {
	plot(x, y, ...)
	}

myfun( 1:10, sqrt(1:10), col="red", type="l")   # optional args color and line plot are passed to plot()


###################################################
### code chunk number 12: functions.Rnw:114-115
###################################################
myfun( 1:10, sqrt(1:10), cex=3)   # optional arg for point size passed to plot()


###################################################
### code chunk number 13: functions.Rnw:119-124
###################################################
query <- function( ... ) {
	paste( ... )
	}

query( "cat", "dog", "rabbit")	


###################################################
### code chunk number 14: functions.Rnw:128-136
###################################################
addlist <- function( ... ) {
	list( ... )
	}

metadat <- addlist ( dataset = "myeco", date="Jan 20, 2014")
metadat
dat <- addlist (ind=1:10, names=letters[1:10], eco=rnorm(10) )	
dat


###################################################
### code chunk number 15: functions.Rnw:145-152
###################################################
mysq <- function( x, yylab="Square of x" ) {   # default argument for the y-label

	plot( x, x*x, ylab=yylab)
	output <- list( input=x, output=x*x ) 	
	return (output)   	

	}


###################################################
### code chunk number 16: functions.Rnw:160-161
###################################################
summary


###################################################
### code chunk number 17: functions.Rnw:168-169
###################################################
methods('summary')


###################################################
### code chunk number 18: functions.Rnw:173-174
###################################################
summary.factor


###################################################
### code chunk number 19: functions.Rnw:184-191
###################################################
myfunc <- function( fattony, littlejimmy) {

	cannolis <- fattony*2 + littlejimmy
	return(cannolis)
}

myfunc( 5, 4 )


###################################################
### code chunk number 20: functions.Rnw:194-195 (eval = FALSE)
###################################################
## cannolis


###################################################
### code chunk number 21: functions.Rnw:202-210
###################################################
myfunc <- function( fattony, littlejimmy) {

	cannolis <- fattony*pi + littlejimmy+littlebit
	return( round(cannolis) )
}

littlebit <- 1
myfunc( 5, 4 )


###################################################
### code chunk number 22: functions.Rnw:220-221
###################################################
ls()


###################################################
### code chunk number 23: functions.Rnw:225-230
###################################################
mean <- function(...) {
	return ("dirty harry")
	}
	
mean( 1:10 )


###################################################
### code chunk number 24: functions.Rnw:235-236
###################################################
search()


###################################################
### code chunk number 25: functions.Rnw:242-244
###################################################
rm(mean)
mean(1:10)


