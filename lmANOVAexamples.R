###########################
## Linear regression -  lm() creates the linear regression model
###########################

lm ( Y ~ X, data = dat )  # regression model of Y as a function of X
summary ( lm (Y ~ X))  # shows us the usual regression output


# Say we have a factor, like island that we think might have an effect:

lm ( Y ~ X + island )  
		# A regression of of Y on X with different intercepts for each island
		# These would be additive effects, the island effect adds a constant increment to 
		# the relationship between Y and X
		#          	The X term fits a single overall slope 
		#			the island term fits different intercepts by island
	
lm ( Y ~ X*island ) 
		# A full regression model with interactions and additive effects
		# Same as Y ~ X + island + X:island,  
		#          	The X term fits a single overall slope 
		#			the island term fits different intercepts by island
		#			and X:island is the interaction effect (offset for different slopes)
		# This model would fit separate slopes and intercepts for each island on the regression   

lm ( Y ~ X:island ) 
		# A regression model with interactions only  (rarely used)
		#          	The X term fits a single overall slope 
		#			and X:island is the interaction effect (offset for different slopes)
 
## Typically, you start with a full model and if the interaction term is not significant
## you drop it and reduce it to an additive model only. 


summary ( lm (Y ~ X))  # shows us the usual regression output

# or you can save the output, even in the lm call:
summary ( lm.simple <- lm (Y ~ X))  # shows us the usual regression output

###########################
## ANOVA
###########################

# you can compute the lm first and then the anova table:

lm.island <- lm( Y ~ island, data=dat )
aov.island <- aov(lm.island)    # computes anova table
aov.island <- anova(lm.island)  # a different implementation of anova

# or  etc.
aov.island <- aov(  Y ~ island, data=dat )
		## you will get a test of the overall effect of groups - if at least one group 
		## mean is different from the rest, it will be significant
# If you want to know which groups are siginificantly different, use 
# Tukey's Honest Signficant Differences test to control for multiple comparisons
TukeyHSD(aov.island)

## A good online tutorial: https://www.statmethods.net/stats/anova.html

###########################
##  Multiple Regression 
###########################

## When you have multiple independent variables, you have multiple regression

# For example: Mass is a function of body length, hind limb length, and for limb length
 
lm.multi <- lm ( mass ~ svl + hindl + forel, data=dat)
summary( lm.multi )
 

###########################
##  MANOVA: Multivariate NANOVA
###########################

## When you have multiple dependent variables, you have multivariate regression

# For example: after size correcting the data we want to know if there are multivariate
# shape differences among sexes of different species and ecomorphs 
 
Y <- with(morph, cbind( hindl, forel, svl) )  # data matrix containing 3 continuous characters 
manova.fit <- manova ( Y ~ sex + ecomorph, data=morph)
summary( manova.fit )
