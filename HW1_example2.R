#Homework 1

#Task: Make a dataframe (ID, sex, height, weight and city), perform a linear regression and ANOVA, print the dataframe and summaries for linear regression and ANOVA, and plot sex vs. height

# Create categorical vectors for sex, ID, city:
#ID:"boy" and "girl" dependent on sex plus a consequtive number, respectively
#sex: 50 males and females each
#city: 25 Honolulu ("Hon") and 25 Santa Barabara ("SB") for each sex

ID<-c(paste("boy", 1:50, sep=""), paste("girl", 1:50, sep=""))
sex <- factor(c(rep("male", 50), rep("female", 50)))
city<-factor(c(rep("Hon", 25), rep("SB", 25), rep("Hon", 25), rep("SB", 25)))

#generate random draw from normal distribution to create vectors for height and weight
#height with mean=55 and SD=5 for males; mean=45, SD=5 for females; 50 samples each
#weight with mean=80, SD=10 for males; mean=65, SD=8 for females; 50 samples each

height <-c(rnorm(50, 55, 5), rnorm(50,45,5))
weight <- c(rnorm(50, mean=80, sd=10), rnorm(50, 65, 8))

# Create the dataframe dat using the previous vectors

dat<-data.frame(ID,sex,height,weight,city)

#Run a linear model of weight as a function of height.
#Run a ANOVA on the linear model with sex as a factor

lm.mf<-with(dat, lm(weight~height))
anova.mf<-with(dat, anova(lm(weight~sex+height)))

# Print the data frame, the summary of the linear model, and the ANOVA 

print(dat)
print("Summary of Linear Regression")
print(summary(lm.mf))
print("ANOVA")
print(anova.mf)


#Plot the results

par(mfrow=c(2,3)) #combine different plots into one window
with(dat, plot(sex, height, main="plot (sex, height)", ylab="height")) #boxplot of height distribution among sexes
with(dat, plot(height, weight, main="plot (height by weight)")) #scatterplot for weight as a function of height
plot(lm.mf) #linear regression plots