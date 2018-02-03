### R code from vignette source 'firstRsession.Rnw'

###################################################
### code chunk number 1: firstRsession.Rnw:20-21 (eval = FALSE)
###################################################
## setwd("~/Rclass")


###################################################
### code chunk number 2: firstRsession.Rnw:24-25 (eval = FALSE)
###################################################
## setwd("C:/Rclass")


###################################################
### code chunk number 3: firstRsession.Rnw:29-30 (eval = FALSE)
###################################################
## help.start()


###################################################
### code chunk number 4: firstRsession.Rnw:41-42
###################################################
height <- 10


###################################################
### code chunk number 5: firstRsession.Rnw:46-47
###################################################
height 


###################################################
### code chunk number 6: firstRsession.Rnw:51-53
###################################################
height  <- c(10, 12, 51, 24, 32)
height


###################################################
### code chunk number 7: firstRsession.Rnw:57-59
###################################################
weight <- c(40, 41, 50, 43, 64)
weight


###################################################
### code chunk number 8: firstRsession.Rnw:65-66
###################################################
plot(height, weight)


###################################################
### code chunk number 9: firstRsession.Rnw:71-75
###################################################
sex <- "male"
sex
sex <- c("male", "male")
sex


###################################################
### code chunk number 10: firstRsession.Rnw:81-87
###################################################
sex <- rep("male", 3)
sex
sex <- c(sex, "female", "female")
sex
sex <- c( rep("male", 3), rep("female", 2) )
sex


###################################################
### code chunk number 11: firstRsession.Rnw:93-95
###################################################
sex <- c(c("male", "male", "male"), c("female", "female"))
sex


###################################################
### code chunk number 12: firstRsession.Rnw:99-101
###################################################
sex <- c(rep("male", 50), rep("female", 50))
sex


###################################################
### code chunk number 13: firstRsession.Rnw:107-109
###################################################
height_m <- rnorm(50, mean=55, sd=5)
height_f <- rnorm(50, mean=45, sd=5)


###################################################
### code chunk number 14: firstRsession.Rnw:113-114
###################################################
height <- c(height_m, height_f)


###################################################
### code chunk number 15: firstRsession.Rnw:118-120
###################################################
height <- c( rnorm(50, mean=55, sd=5), rnorm(50, mean=45, sd=5) )
weight <- c( rnorm(50, mean=80, sd=10), rnorm(50, mean=65, sd=8) )


###################################################
### code chunk number 16: firstRsession.Rnw:126-128
###################################################
sex <- factor(sex)
sex


###################################################
### code chunk number 17: firstRsession.Rnw:133-135 (eval = FALSE)
###################################################
## plot(sex, height, main="plot(sex, height)")
## plot(height, sex, main="plot(height, sex)")


###################################################
### code chunk number 18: firstRsession.Rnw:140-143
###################################################
par(mfrow=c(1,2))
plot(sex, height, main="plot(sex, height)")
plot(height, sex, main="plot(height, sex)")


###################################################
### code chunk number 19: firstRsession.Rnw:147-148
###################################################
lm.mf <- lm( weight ~ height )


###################################################
### code chunk number 20: firstRsession.Rnw:153-155
###################################################
summary(lm.mf)
anova(lm.mf)


###################################################
### code chunk number 21: firstRsession.Rnw:159-161
###################################################
lm.mf <- lm(weight ~ sex + height)
anova(lm.mf)


###################################################
### code chunk number 22: firstRsession.Rnw:167-168 (eval = FALSE)
###################################################
## ?formula


###################################################
### code chunk number 23: firstRsession.Rnw:176-177
###################################################
seq(1,50)


###################################################
### code chunk number 24: firstRsession.Rnw:181-182
###################################################
 1:50


###################################################
### code chunk number 25: firstRsession.Rnw:186-189
###################################################
 boys <- paste("boy", 1:50, sep="")
 girls <- paste("girl", 1:50, sep="")
 ID <- c(boys, girls)


###################################################
### code chunk number 26: firstRsession.Rnw:195-196
###################################################
city <- c( rep("Hon", 25), rep("SB", 25), rep("Hon", 25), rep("SB",25))


###################################################
### code chunk number 27: firstRsession.Rnw:200-201
###################################################
city <- rep( c(rep("Hon", 25), rep("SB", 25)), times = 2)


###################################################
### code chunk number 28: firstRsession.Rnw:205-207
###################################################
rep(1:5, times=3)
rep(1:5, each=3)


###################################################
### code chunk number 29: firstRsession.Rnw:211-212
###################################################
dat <- data.frame(ID, sex, height, weight, city)


###################################################
### code chunk number 30: firstRsession.Rnw:214-215 (eval = FALSE)
###################################################
## dat


###################################################
### code chunk number 31: firstRsession.Rnw:219-221
###################################################
head(dat)
tail(dat)


###################################################
### code chunk number 32: firstRsession.Rnw:227-228 (eval = FALSE)
###################################################
## ?savehistory


###################################################
### code chunk number 33: firstRsession.Rnw:232-233 (eval = FALSE)
###################################################
## savehistory(file="VecPractice.history")


