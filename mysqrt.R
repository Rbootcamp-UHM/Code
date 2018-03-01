mysqrt <- function ( x, guess=1, tol=0.001, debug=F) {
	error <- tol+1
	while( tol < error) {
	  newguess <- x/guess
	  if (debug) print(newguess)	  
	  guess <- (guess+newguess)/2
	  error <- abs( newguess^2-x )
	}
	return(newguess)
}