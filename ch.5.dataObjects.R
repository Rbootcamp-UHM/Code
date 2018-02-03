### R code from vignette source 'dataObjects.Rnw'


###################################################
### code chunk number 2: dataObjects.Rnw:38-52
###################################################
x <- c( 1, 5, 7, 14)
x
x <- rep( x, times=2)
x
y <- rnorm(8)
y
species <- letters[1:4]    # special stored data object: lower case letters a - d
species
LETTERS[1:3]   # A B C
treatment <- c("high", "med", "low")
treat <- factor(treatment)   # create a factor
treat
as.numeric(treat)   # coerce to numeric
x <- factor(x)   # factor


###################################################
### code chunk number 3: dataObjects.Rnw:57-61
###################################################
xy <- cbind(x,y)  # column bind
xy
z <- matrix(1:25, nrow=5)  #create a matrix with 5 rows
z


###################################################
### code chunk number 4: dataObjects.Rnw:65-66
###################################################
dat <- data.frame(species, x, y)


###################################################
### code chunk number 5: dataObjects.Rnw:74-75
###################################################
plot(y,x)   # continuous variable first - plots as a scatterplot


###################################################
### code chunk number 6: dataObjects.Rnw:78-79
###################################################
plot(x, y)   # categorical variable first - plots as a boxplot 


###################################################
### code chunk number 7: dataObjects.Rnw:86-87
###################################################
hist(y)


###################################################
### code chunk number 8: dataObjects.Rnw:91-92
###################################################
barplot(y)


###################################################
### code chunk number 9: dataObjects.Rnw:101-105
###################################################
y <- rnorm(21)
y1 <- rnorm(21)
y
y1


###################################################
### code chunk number 10: dataObjects.Rnw:108-110
###################################################
treatment <- factor( c("low", "med", "high") )
treatment


