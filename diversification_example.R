#simple models of diversification
library(geiger)

#STEP ONE - generate a simple pure birth tree
layout(matrix(1:2,2));
tree <- sim.bdtree(0.5,0,stop="time",t=2)
plot(tree, show.tip.label=FALSE)
title(main=Ntip(tree))
ltt.plot(tree)

#STEP TWO - add a lineage through time plot for a longer time period
layout(matrix(1:2,2));
tree10 <- sim.bdtree(0.5,0,stop="time",t=10)
plot(tree10, show.tip.label=FALSE)
title(main=Ntip(tree10))
ltt.plot(tree10)

#STEP THREE add extinction
layout(matrix(1:2,2));
stree10 <- sim.bdtree(0.5,0.1,stop="time",t=10)
plot(stree10, show.tip.label=FALSE)
title(main=Ntip(stree10))
ltt.plot(stree10)

#STEP FOUR prune extinct
layout(matrix(1:2,2));
stree10 <- sim.bdtree(0.5,0.1,stop="time",t=10)
stree10.ne <- drop.extinct(stree10)
plot(stree10.ne, show.tip.label=FALSE)
title(main=Ntip(stree10.ne))
ltt.plot(stree10.ne)

#estimate speciation rate, assuming no extinction
bd.ms(phy=tree10, missing=1, epsilon=0)




#####################################################
#Trait dependent models of speciation and extinction
library(diversitree)

#The simulator for diversitree takes a list of parameters that correspond to
#speciation in each state (lambda), extinction in each state (mu), and transition rates
#the order is lambda1 lamda2 mu1 mu2 q01 q10
#each example below sets up a different scenario under the model
#you can use these to simulate with the tree.bisse() function below

#demonstrate trait evolution special case, diversification rates are equal
pars <- c(0.1, 0.1, 0.001, 0.001, 0.1, 0.1) 

#demonstrate birth death special case, transition rates are equal
pars <- c(0.1, 0.1, 0.01, 0.01, 0, 0) 

#demonstrate joint model
#blue speciates faster, equal switching, no extinction
pars <- c(0.1, 0.4, 0, 0, 0.01, 0.01) 

#blue speciates but switches to red, no extinction
pars <- c(0.1, 0.4, 0, 0, 0.01, 0.5) 

#speciation and switching equal, blue goes extinct a lot
pars <- c(0.4, 0.4, 0, 0.3, 0.1, 0.1) 

#blue speciates no extinction, lots of switching between the two
pars <- c(0.1, 0.4, 0, 0, 0.9, 0.9) 

#use this piece of code to simulate and plot using parameter settings above
phy <- tree.bisse(pars, max.taxa=100, x0=0)
states <- phy$tip.state
col <- c("red", "blue")
plot(history.from.sim.discrete(phy, 0:1), phy, col=col, show.tip.label=FALSE)


###################################################
#We can also do inference using this model
#let's start by simulating a tree
pars <- c(0.1, 0.3, 0.03, 0.03, 0.01, 0.01)
set.seed(4)
phy <- tree.bisse(pars, max.t=30, x0=0)
states <- phy$tip.state
plot(history.from.sim.discrete(phy, 0:1), phy, col=col, show.tip.label=FALSE)

#now we can set up the model for inference. We will try to estimate parameter values based on our tree ('phy') and tip states ('states').
lik <- make.bisse(phy, states)
lik(pars)
p <- starting.point.bisse(phy) #guess some reasonable starting values for the ML search
fit <- find.mle(lik, p) #do the maximum likelihood model fit

#print the likelihood and the estimates of coefficients for this model
fit$lnLik
round(coef(fit), 3) #do your parameter estimates match your similation conditions?

#now let's compare to a constrained model where speciation rates are equal
lik.l <- constrain(lik, lambda1 ~ lambda0) #set up the constrained model
fit.l <- find.mle(lik.l, p[argnames(lik.l)]) #do the model fitting
fit.l$lnLik

#look at the parameter estimates under the two models
round(rbind(full=coef(fit), equal.l=coef(fit.l, TRUE)), 3)

#does one model fit the data better than another?
anova(fit, equal.l=fit.l)




