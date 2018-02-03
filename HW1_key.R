##########   Homework 1   Sample Answer

## This script analyzes weight and height by sex 
## Data are randomly generated for 50 males and 50 females
## assuming different means for males and females

## Create vectors for sex, height, weight, ID, city:
	sex <- c(rep("male", 50), rep("female", 50))
	sex <- factor(sex)
	height <- c( rnorm(50, mean=55, sd=5), rnorm(50, mean=45, sd=5) )
	weight <- c( rnorm(50, mean=80, sd=10), rnorm(50, mean=65, sd=8) )
	boys <- paste("boy", 1:50, sep="")
	girls <- paste("girl", 1:50, sep="")
	ID <- c(boys, girls)
	city <- c( rep("Miami", 25), rep("Austin", 25),rep("Miami", 25), rep("Austin", 25))

## Create the dataframe dat 
	dat <- data.frame(ID, sex, height, weight, city)

## Run the linear model of weight as a function of height. 
	lm.mf <- with(dat, lm( weight ~ height ))

## print the output to console: the data frame, 
## the summary of the linear model, and the anova 
	print(dat)
	print(summary(lm.mf))
	print(anova(lm.mf))

## make a plot of this analysis
	with(dat, plot(sex, height))
