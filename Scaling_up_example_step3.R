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

## Step 3  Scaling up using a function and for loop - 6 datasets

make_data <- function( n=30, slope=2) {
	x <- rnorm( 30 )
	y <- 2*x + rnorm(30)
	return( data.frame(x,y)	)
}

dat_list <- list()    ## create an empty list to hold datasets
for(i in 1:6) {       ## for loop creates 6 dataframes, 30 samples each
	dat_list[[i]] <- make_data(30)
}

correlations <- vector()  ## create empty vector to hold corr
par(mfrow=c(2,3))  ## set plot window to make 2 rows, 3 columns
for(i in 1:6) {
	
	plot( dat_list[[i]]$x, dat_list[[i]]$y )   # plot x,y 
	correlations[i] <- cor( dat_list[[i]]$x, dat_list[[i]]$y )  
}

print(correlations, digits=4)
mean(correlations)    # mean correlation about 0.85 - 0.90 