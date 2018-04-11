library(IPMpack)
#load data
#https://datadryad.org//resource/doi:10.5061/dryad.6575f
dat <- read.csv("Appendix_A_Simple_data.csv")
#View Data
View(dat)
#exploratory plot
range(dat$size,na.rm=T)
range(dat$sizeNext,na.rm=T)
plot(dat$size,dat$sizeNext, xlab= "size at t", ylab="size at t+1")
#Function to compare basic growth models using AIC
growthModelComp(dat, makePlot = T)
#make a growth object using the selected function
gr1 <- makeGrowthObj(dataf = dat, Formula = sizeNext~size,regType="constantVar",Family="gaussian")
#compare models of survival
survModelComp(dat,makePlot = T)
#make survivorship object using the selected function
sv1 <- makeSurvObj(dataf = dat, Formula = surv~size)
#plot growth and survival objects
par(mfrow = c(1, 2), bty = "l", pty = "m")
picGrow(dat,gr1)
picSurv(dat,sv1)
#combine growth and survival functions to make Pmatrix
Pmatrix <- makeIPMPmatrix(nBigMatrix = 100,minSize=0.45,maxSize=9.735,growObj = gr1, survObj = sv1,correction = "constant")
#plot pmatrix
image(Pmatrix@meshpoints,Pmatrix@meshpoints,t(Pmatrix), xlab="Size (t)",ylab="Size (t+1)", main="Pmatrix")
contour(Pmatrix@meshpoints,Pmatrix@meshpoints,t(Pmatrix),add=T)
#make a fecundity object
fv1 <- makeFecObj(dat,fecConstants=data.frame(sum(is.na(dat$size))/sum(dat$fec.seed,na.rm=TRUE)), Formula = fec.seed~size,Family = "poisson", meanOffspringSize = mean(dat$sizeNext[is.na(dat$size)]))
#create Fmatrix
Fmatrix <- makeIPMFmatrix(nBigMatrix = 100, minSize = 0.45,maxSize = 9.735,fecObj = fv1,correction = "constant")
#plot Fmatrix
image(Pmatrix@meshpoints,Pmatrix@meshpoints,t(Fmatrix), xlab="Size (t)",ylab="Size (t+1)", main="Fmatrix")
contour(Fmatrix@meshpoints,Fmatrix@meshpoints,t(Fmatrix),add=T)
#combine growth, survival and fecundity to make full IPM
IPM <- Pmatrix + Fmatrix
#Plot IPM
image(Pmatrix@meshpoints,Pmatrix@meshpoints,t(IPM), xlab="Size (t)",ylab="Size (t+1)", main="IPM matrix")
contour(Pmatrix@meshpoints,Pmatrix@meshpoints,t(IPM),add=T)
#lambda and elemental elasticity for full IPM
Re(eigen(IPM)$value[1])
sensitivity <- sens(IPM)
elasticity <- elas(IPM)
image(Pmatrix@meshpoints,Pmatrix@meshpoints,t(elasticity), xlab="Size (t)",ylab="Size (t+1)", main="Elasticity")
contour(Pmatrix@meshpoints,Pmatrix@meshpoints,t(elasticity),add=T)

