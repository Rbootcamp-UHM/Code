############################################
#
#  An example of scaling up
#  The sample is simulated data - we begin by simulating the x
#  coordinate from a standard normal distribution (mean zero 
#  and variance 1), and then simulating the y which is a 
#  a linear function of x with slope of 2 plus some more random
#  error.     y = 2*x + error 
#
#  Plot each dataset and calculate the correlation between x and y
#
############################################

## Step 4  Scaling up using function and apply - 6 datasets

make_data <- function( n=30, slope=2) {
	x <- rnorm( 30 )
	y <- 2*x + rnorm(30)
	return( data.frame(x,y)	)
}

dat_list <- lapply( rep(30, 6), make_data)   # create list of dataframes

par(mfrow=c(2,3))
lapply( dat_list, plot)   # plot each dataset

correlations <- sapply( dat_list, function(X)  cor(X$x, X$y) )
print(correlations, digits=4)
mean(correlations)    # mean correlation about 0.85 - 0.90 



