### R code from vignette source 'OUvariations.Rnw'

###################################################
### code chunk number 1: OUvariations.Rnw:68-76
###################################################
require(ouch)

regimes <- read.csv('Data/regimes.csv',row.names=1)    # regimes
ssd <- read.csv('Data/ssd.data.csv',row.names=1)    # tree + body size data
otree <- with(ssd,ouchtree(nodes,ancestors,times,labels))
xdata <- log(ssd[c('fSVL','mSVL')])
names(xdata) <- paste('log',names(xdata),sep='.')
nreg <- length(regimes)


###################################################
### code chunk number 2: OUvariations.Rnw:81-83
###################################################
alpha.guess <- c(1, 0, 1)
sigma.guess <- c(1, 1, 1)


###################################################
### code chunk number 3: OUvariations.Rnw:87-100
###################################################
tic <- Sys.time()
hansen(
       data=xdata,
       tree=otree,
       regimes=regimes[5],
       sqrt.alpha =alpha.guess,
       sigma=sigma.guess,
       method="Nelder-Mead",
       maxit=3000,
       reltol=1e-12
       )
toc <- Sys.time()
print(toc-tic)


###################################################
### code chunk number 4: OUvariations.Rnw:107-121
###################################################
tic <- Sys.time()
h.subplex <- hansen(
       data=xdata,
       tree=otree,
       regimes=regimes[1],
       sqrt.alpha =alpha.guess,
       sigma=sigma.guess,
       method="subplex",
       maxit=20000,
       reltol=1e-12
       )
toc <- Sys.time()
print(toc-tic)
summary(h.subplex)


###################################################
### code chunk number 5: OUvariations.Rnw:126-131
###################################################
brown.fit <- brown(
               data=xdata,
               tree=otree
             )
summary(brown.fit)             


