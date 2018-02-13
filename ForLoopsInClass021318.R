mylist <- vector("list")   # create an empty list
for (i in 1:4) {
   mylist[i] <- list(data.frame(x=rnorm(3), y=rnorm(3)))  
   }
   
for (i in 1:4) {
   max_x <- max(mylist[[i]]$x)
   max_y <- max(mylist[[i]]$y)

   out <- c(max_x, max_y)
   print( out )   
   }   
   
out_list <- vector("list")
for (i in 1:4) {
   max_x <- max(mylist[[i]]$x)
   max_y <- max(mylist[[i]]$y)

   out <- c(max_x, max_y)     ## as before
   out_list <- c(out_list, list(out))  ## adding on to out_list
   print( paste("This is iteration", i))
   print( out_list )   ## This is what out_list looks like
   }   
   
## Use print() to see values at each iteration of the loop   
   

## Code that works on list element 1   
lm.out <- lm( mylist[[1]]$x  ~ mylist[[1]]$y )  
aov.out <- anova(lm.out)   
out <- unlist(aov.out)

## Modify above to work in a for loop



   