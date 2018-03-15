############################################
#
#  An example of scaling up
#  The sample is simulated data - we begin by simulating the x
#  coordinate from a standard normal distribution (mean zero 
#  and variance 1), and then simulating the y which is a 
#  a linear function of x with slope of 2 plus some more random
#  error.     y = 2*x + error 
#
#  Weʻll also plot the data and calculate the correlation 
#  between x and y.
#
############################################

## Step 1  Workflow for one run through of the tasks

x <- rnorm( 30 )
y <- 2*x + rnorm(30)

plot( x, y )
cor( x, y )