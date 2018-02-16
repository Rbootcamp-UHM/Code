#####
#
# 	HW3 Extra Credit -- simplifying with functions
#   We are repeatedly aggregating by date or category, so turn this into a function
#   where we get total, mean, and max, by category and return back the merged summary
#   statistics 
####


## Define the function
##   Take the code from question #4 and make a function out of it
##   Notice too that "date" and "category" are character strings that 
##   can be passed to our function - use "category" as the default since
##   we use it more. Below there are two different function writing strategies
##

# Function - input objects are two vectors, the amount and the grouping variable
#              and a character string for the name of the grouping variable
#  call syntax: mysummary( dat$amount, dat$date, type="date")

mysummary <- function( amount, group, type="category") {  # amount and group are vectors
	                                                 
  dsum <- aggregate(amount, by=list(group), sum) # total by byvar
  dmean <- aggregate(amount, by=list(group), mean) # average by byvar
  dmax <- aggregate(amount, by=list(group), max)  # max by byvar
  names(dsum) <- c(type, "total")
  names(dmean) <- c(type, "mean")
  names(dmax) <- c(type, "max")

  sstat <- merge( dsum, dmean, by= type)
  sstat <- merge( sstat, dmax, by= type) # report by byvar

  return(sstat)  # returns dataframe with summary stats
}

######  Start Program   ######

dat <- read.csv("budget.csv")
names(dat) <- c("date", "description", "category", "amount")

###########################
#1  - Total expenditure and by weekday, weekend
#

bydate <- aggregate(dat$amount, by=list(dat$date), sum)
total_weekday <- sum(bydate[1:4, 2])  # spent $117 during the week
total_weekend <- sum(bydate[5:7, 2])  # spent $243 on weekend. Problem there.


###########################
# 2-9 - totals by date and by budget category, food, entertainment
#
aggregate(dat$amount, by=list(dat$date), sum)   # spends more on the weekend
aggregate(dat$amount, by=list(dat$category), sum) 

amount.by.date <- mysummary( dat$amount, dat$date, group="date") # 4 - report by date
amount.by.category <- mysummary( dat$amount, dat$category ) # 5 - report by category

## 6 Split data, grouping all "food" together
food <- dat[ dat$category=="coffee" | dat$category=="groceries" | dat$category=="lunch" | dat$category=="dinner", ]   

## 7 Group "entertainment" = beer and entertainment
entertainment <- dat[ dat$category=="entertainment" | dat$category=="beer", ]  

food.by.category <- mysummary(food$amount, food$category) # 8 - report by food subcategory
entertainment.by.category <- mysummary( entertainment$amount, entertainment$category )  # 9 

###########################
# 10 - plots illustrating problems
#
	# this plot shows that coffee and lunch each go over the $50/week budget!
pdf(file="foodsubcategories.pdf")
  barplot(food.by.category$total, names.arg=food.by.category$category)  
  abline(h=50, col="red", lty=2, lwd=3)  # budget is $50/week for food
dev.off()

	# this plot shows both beer and entertainment each go over the $25/week budget!
pdf(file="entertainmentsubcategories.pdf")
  barplot(entertainment.by.category$total, names.arg= entertainment.by.category $category)  
  abline(h=25, col="red", lty=2, lwd=3)  # budget is $25/week for entertainment
dev.off()

###########################
# 11 - save output
#

write.csv(amount.by.date, file="amount.by.date.csv")
write.csv(amount.by.category, file="amount.by.category.csv")
write.csv(food.by.category, file="food.by.date.csv")
write.csv(entertainment.by.category, file="entertainment.by.date.csv")
