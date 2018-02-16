dat <- read.csv("budget.csv")
names(dat) <- c("date", "description", "category", "amount")

###########################
#1  - Total expenditure and by weekday, weekend
#
bydate <- aggregate(dat$amount, by=list(dat$date), sum)
total_weekday <- sum(bydate[1:4, 2])  # spent $117 during the week
total_weekend <- sum(bydate[5:7, 2])  # spent $243 on weekend. Problem there.

#--------------------
# Alternatively, could have used:

total <- sum(dat$amount)	 # total for one week is $360.79
oowk <- as.numeric(dat$date) <= 4  # make an index for weekdays 1, 2, 3, 4
ooend <- as.numeric(dat$date) >= 5  # make an index for weekend 5,6,7
			# The above method uses the trick that the factor levels are saved
			# internally as integers. If they indexed individually for the dates, 
			# that is fine too.

total_weekday <- sum(dat$amount[oowk])  
total_weekend <- sum(dat$amount[ooend])  

###########################
# 2-3 - totals by date and by budget category
#
aggregate(dat$amount, by=list(dat$date), sum)   # spends more on the weekend
aggregate(dat$amount, by=list(dat$category), sum) 

###########################
# 4 - report by date
#
date.sum <- aggregate(dat$amount, by=list(dat$date), sum) # total by date
date.mean <- aggregate(dat$amount, by=list(dat$date), mean) # average by date
date.max <- aggregate(dat$amount, by=list(dat$date), max)  # max by date
names(date.sum) <- c("date", "total")
names(date.mean) <- c("date", "mean")
names(date.max) <- c("date", "max")

amount.by.date <- merge( date.sum, date.mean, by="date")
amount.by.date <- merge( amount.by.date, date.max, by="date") # report by date

###########################
# 5 - report by category
#
cat.sum <- aggregate(dat$amount, by=list(dat$category), sum) # total by category
cat.mean <- aggregate(dat$amount, by=list(dat$category), mean) # average by category
cat.max <- aggregate(dat$amount, by=list(dat$category), max) # max by category
names(cat.sum) <- c("category", "total")
names(cat.mean) <- c("category", "mean")
names(cat.max) <- c("category", "max")

amount.by.category <- merge( cat.sum, cat.mean, by="category")
amount.by.category <- merge( amount.by.category, cat.max, by="category") # report by category

###########################
# 6 - split data - only food
#
food <- dat[ dat$category=="coffee" | dat$category=="groceries" | dat$category=="lunch" | dat$category=="dinner", ]

###########################
# 7 - split data - only entertainment
#
entertainment <- dat[ dat$category=="entertainment" | dat$category=="beer", ]

###########################
# 8 - report by food subcategory
#
ssum <- aggregate(food$amount, by=list(food$category), sum) 
mmean <- aggregate(food$amount, by=list(food $category), mean) 
mmax <- aggregate(food$amount, by=list(food $category), max) 
names(ssum) <- c("category", "total")
names(mmean) <- c("category", "mean")
names(mmax) <- c("category", "max")

food.by.category <- merge( ssum, mmean, by="category")
food.by.category <- merge( food.by.category, mmax, by="category")

###########################
# 9 - report by entertainment subcategory
#
ssum <- aggregate(entertainment$amount, by=list(entertainment$category), sum) 
mmean <- aggregate(entertainment$amount, by=list(entertainment$category), mean) 
mmax <- aggregate(entertainment$amount, by=list(entertainment$category), max) 
names(ssum) <- c("category", "total")
names(mmean) <- c("category", "mean")
names(mmax) <- c("category", "max")

entertainment.by.category <- merge( ssum, mmean, by="category")
entertainment.by.category <- merge( entertainment.by.category, mmax, by="category")

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
