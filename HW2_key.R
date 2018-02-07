##########   Homework 2   Sample Answers

# 1a

	x <- matrix( 1:20, nrow=4)
	
# 1b x is a numeric matrix with 4 rows and 5 columns. 
	
	attributes(x)	
	
## or 
	
	dim(x)
	class(x)
	mode(x)	
	
# 1c 
   dim(x) <- c(2, 10)	

# > x
#      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
# [1,]    1    3    5    7    9   11   13   15   17    19
# [2,]    2    4    6    8   10   12   14   16   18    20

# 1d   
   x <- as.vector(x)
   # or dim(x) <- NULL
   
# 1e
  x <- matrix(x, nrow=2, byrow=TRUE)

# > x
#      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
# [1,]    1    2    3    4    5    6    7    8    9    10
# [2,]   11   12   13   14   15   16   17   18   19    20

  
# 1f It is not in the same order. It is 1, 11, 2, 12, 3, 13, etc. 
# It shows that the default behavior of R is to fill matrices column by column. 
  x <- as.vector(x)  
  
# 1g 
	x <- matrix( 1:20, nrow=4)
    x[3,4]   # this is 15
    
# 1h   
	print(x[3:4,4:5])

#      [,1] [,2]
# [1,]   15   19
# [2,]   16   20
	
	
# 1i
	print(x[c(1,4),c(1,5)])

#      [,1] [,2]
# [1,]    1   17
# [2,]    4   20
	
##########   Problem 2

## 2d
ccol = c(rep("red", each=50), rep("blue", each=50), rep("black",  each=50))

pdf(file="qqplot.pdf")
par(mfrow=c(2,2))

qqnorm( iris$Petal.Width, main="Petal Width", col=ccol)
qqnorm( iris$Petal.Length, main="Petal Length", col=ccol)
qqnorm( iris$Sepal.Width, main="Sepal Width", col=ccol)
qqnorm( iris$Sepal.Length, main="Sepal Length", col=ccol)
dev.off()

pdf(file="iris.pdf")
plot(iris[-5], col=ccol)	
dev.off()

## 2b The QQ plots show that there is a gap in the distribution for Petal Width and Petal Length where there is a clump of values with low numeric values for Petal Width and Length, and another clump of higher values

## 2c The color coding of the QQ and scatter plots show that the deviation from normality is a species effect. The scatter plots confirm that Setosa is the most different. It clearly separates from Versicolor and Virginica, especially in having smaller petal width and petal length. Versicolor and Virginica are more similar to each other and broadly overlap in all variables, although Virginica is larger in petal width and length. Setosa is smallest in all variables except for Sepal width where it is largest. 

	
    	
 