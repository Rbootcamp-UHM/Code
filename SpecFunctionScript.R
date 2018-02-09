### Script to analyze spectrophotometer files

## Function read.spec reads in data, 
## removes header and footer, 
## and subsets to wavelength range 300 - 750 

read.spec <- function ( myfile )  {  
	dat <- read.table(file=myfile, skip=17, comment.char=">")
	names(dat) <- c("lambda", "intensity")
	
	dat <- dat[ dat$lambda >= 300 & dat$lambda <= 750,   ]
	return (dat)
}

dat1 <- read.spec( "Data/20070725_01forirr.txt"  )
dat2 <- read.spec( "Data/20070725_01upirr.txt"  )
dat3 <- read.spec( "Data/20070725_01rightirr.txt"  )
dat4 <- read.spec( "Data/20070725_01leftirr.txt"  )

plot(dat1, type="l")
	## max(dat1$intensity)   # use indexing to find the lambda @max intensity
	## find max_lambda, max_intensity 
points(max_lambda, max_intensity, col="red", cex=3, pch=19)  

	## What should we return for our final dataframe of max intensity, lambda?


plot(dat2, type="l")   ## ... 
plot(dat3, type="l")
plot(dat4, type="l")

### use list.files()  to get all the files in "Data" and save as myfiles
### use grep() to get all the files that contain "irr.txt"
### use myfiles to read in data without typing in filenames!



  