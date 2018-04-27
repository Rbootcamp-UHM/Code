#setwd("Location/of/data_files")

curve(x^2,0,1)
curve(x^2,0,1,xlab="Allele frequencies", ylab="Genotype frequencies", col="green", lwd=2)
text(0.6,0.2,"Homozygotes",col="green")

curve(2*x*(1-x),0,1,add=TRUE, xlab="Allele frequencies", ylab="Genotype frequencies", col="blue", lwd=2)
text(0.25,0.5, "Heterozygotes", col="blue")

p=2/3

p^2 == 2*p*(1-p)
p^2
2*p*(1-p)
all.equal(p^2,2*p*(1-p))

points(p, p^2, lwd=2, cex=2)

allele<-c("A", "A", "a", "a", "a", "a", "a", "a", "a", "a")
#or
allele<-c(rep("A",2),rep("a",8))

#Set 
popsize=100
pop=matrix(nrow=popsize, ncol=2)

sample(c(1,2),1)
sample(allele,1)

table(allele)
table(allele)[1]/sum(table(allele))
table(allele)[2]/sum(table(allele))

for(i in 1:popsize){
  pop[i,1]=sample(allele,1)
  pop[i,2]=sample(allele,1)
}

pop

Acount=0
for(i in 1:popsize){
  if(pop[i,1]=="A"){
    Acount=Acount+1
  }
  if(pop[i,2]=="A"){
    Acount=Acount+1
  }
}

Acount
(Afreq=Acount/(popsize*2))
table(allele)[2]/sum(table(allele))

Hcount=0
AAcount=0
for(i in 1:popsize){
  if(pop[i,1]=="A"){
    if(pop[i,2]=="a"){
      Hcount=Hcount+1
    }else{
      AAcount=AAcount+1
    }
  }
  if(pop[i,1]=="a"){
    if(pop[i,2]=="A"){
      Hcount=Hcount+1
    }
  }
}

#Calculate frequencies from counts
HetFreq=Hcount/popsize
AAFreq=AAcount/popsize
print(c(Afreq,HetFreq,AAFreq))

#Plot the sampled points onto a plot
plot(Afreq,HetFreq,xlab="Allele frequency",ylab="",ylim=c(0,1),xlim=c(0,1),col="blue")
par(new=T)
plot(Afreq,AAFreq,xlab="Allele frequency",ylab="",ylim=c(0,1),xlim=c(0,1),col="green")
par(new=T)

plot(Afreq, 1-AAFreq-HetFreq, xlab="Allele frequency", ylab="", ylim=c(0,1), xlim=c(0,1),col="red")
curve(x^2,0,1,add=TRUE,col="green", lwd=2)
text(0.9,0.7,"AA",col="green")
curve(2*x*(1-x),0,1,add=TRUE,col="blue", lwd=2)
text(0.5,0.7, "Aa", col="blue")
curve((1-x)^2,0,1,add=TRUE,lwd=2,col="red")
text(0.1,0.7, "aa",col="red")

#Code a replication of ths sampling
AFreq<-numeric()
HetFreq<-numeric()
AAFreq<-numeric()

replicates=10

for(j in 1:replicates){ ### Beginning of the replicate loop
  ## Randomly sample alleles
  for(i in 1:popsize){
    pop[i,1]=sample(allele,1)
    pop[i,2]=sample(allele,1)
  } # Close of the allele sampling loop
  ## Calculate population allele frequency
  Acount=0 # count A alleles
  for(i in 1:popsize){
    if(pop[i,1]=="A"){
      Acount=Acount+1
    }
    if(pop[i,2]=="A"){
      Acount=Acount+1
    }
  } # close of the allele frequency loop
  AFreq[j]=Acount/(popsize*2)
  ## Calculate genotype frequency
  Hcount=0 # count heterozygotes
  AAcount=0 # count AA homozygotes
  for(i in 1:popsize){
    if(pop[i,1]=="A"){
      if(pop[i,2]=="a"){
        Hcount=Hcount+1
      }else{
        AAcount=AAcount+1
      }
    }
    if(pop[i,1]=="a"){
      if(pop[i,2]=="A"){
        Hcount=Hcount+1
      }
    }
  } # Close of the genotype frequency loop
  HetFreq[j]<-Hcount/(popsize)
  AAFreq[j]<-AAcount/(popsize)
} ### Close of the replicate loop

#Save all the plotting commands as a function
PlotAll<-function(){
plot(AFreq,HetFreq,xlab="Allele frequency",ylab="",ylim=c(0,1),xlim=c(0,1),col="blue")
par(new=T)
plot(AFreq,AAFreq,xlab="Allele frequency",ylab="",ylim=c(0,1),xlim=c(0,1),col="green")
par(new=T)
plot(AFreq, 1-AAFreq-HetFreq, xlab="Allele frequency", ylab="", ylim=c(0,1), xlim=c(0,1),col="red")
curve(x^2,0,1,add=TRUE,col="green", lwd=2)
text(0.9,0.7,"AA",col="green")
curve(2*x*(1-x),0,1,add=TRUE,col="blue", lwd=2)
text(0.5,0.7, "Aa", col="blue")
curve((1-x)^2,0,1,add=TRUE,lwd=2,col="red")
text(0.1,0.7, "aa",col="red")
}


p=runif(1)
?runif

for(i in 1:popsize){
  if(runif(1)<p){
    pop[i,1]="A"
  }else{
    pop[i,1]="a"
  }
  if(runif(1)<p){
    pop[i,2]="A"
  }else{
    pop[i,2]="a"
  }
}

pop
replicates=1000

for(j in 1:replicates){ ### Beginning of the replicate loop
  p=runif(1)
  ## Randomly sample alleles
  for(i in 1:popsize){
    if(runif(1)<p){
      pop[i,1]="A"
    }else{
      pop[i,1]="a"
    }
    if(runif(1)<p){
      pop[i,2]="A"
    }else{
      pop[i,2]="a"
    }
  } # Close of the allele sampling loop
  ## Calculate population allele frequency
  Acount=0 # count A alleles
  for(i in 1:popsize){
    if(pop[i,1]=="A"){
      Acount=Acount+1
    }
    if(pop[i,2]=="A"){
      Acount=Acount+1
    }
  } # close of the allele frequency loop
  AFreq[j]=Acount/(popsize*2)
  ## Calculate genotype frequency
  Hcount=0 # count heterozygotes
  AAcount=0 # count AA homozygotes
  for(i in 1:popsize){
    if(pop[i,1]=="A"){
      if(pop[i,2]=="a"){
        Hcount=Hcount+1
      }else{
        AAcount=AAcount+1
      }
    }
    if(pop[i,1]=="a"){
      if(pop[i,2]=="A"){
        Hcount=Hcount+1
      }
    }
  } # Close of the genotype frequency loop
  HetFreq[j]<-Hcount/(popsize)
  AAFreq[j]<-AAcount/(popsize)
} ### Close of the replicate loop

PlotAll()

#Extend to more than 2 alleles
p1<-0.2
p2<-0.3
p3<-0.5

#Expected homozygosity is summation of all squared p's
sapply(c(p1,p2,p3),function(x) x^2)
sum(sapply(c(p1,p2,p3),function(x) x^2))

#Expected heterozygosity is 1-homozygosity

genotypes <- read.csv(file="pinus.csv", header=TRUE, sep=",")

str(genotypes)
rownames(genotypes)<-genotypes$ID
genotypes<-genotypes[,-c(1,2)]

(num.loci=(length(genotypes))/2)

Hom_exp=NULL
Het_exp=NULL
Hom_obs=NULL
Het_obs=NULL

for(n in 1:(num.loci)){
  current=n*2-1
  locus<-c(genotypes[,current],genotypes[,current+1])
  alleles<-unique(locus)
  alleles<-alleles[alleles!=-1]
  p_allele=NULL
  for(a in 1:length(alleles)){
    p_allele=c(p_allele,sum(alleles[a]==locus)/sum(locus!=-1))
  }
  Hom_exp=c(Hom_exp, sum(sapply(p_allele,function(x) x^2)))
  obs=0
  for(i in 1:length(genotypes[,current])){
    if(genotypes[i, current]!=-1){
      if(genotypes[i, current]==genotypes[i,current+1]){
        obs=obs+1
      }
    }
  }
  Hom_obs=c(Hom_obs,obs/(sum(locus!=-1)/2))
}

(Het_exp=1-Hom_exp)
(Het_obs=1-Hom_obs)

plot(Het_obs, Het_exp)
abline(lm(Het_exp~Het_obs))

linearreg <- summary(lm(Het_exp~Het_obs))
print(linearreg)
rr<-linearreg$r.squared
rrlabel=paste("r-squared =",round(rr, digits = 3))
pv<-linearreg$coefficients[2,4]
pvlabel=paste("P-value =",pv)
text(0.6, 0.2, rrlabel)
text(0.6, 0.15, pvlabel)

#EM algorithm
pA=0.25
pa=1-pA

(pA+pa)

(pA+pa)^2
pA^2 + 2*(pA*pa) + pa^2

rm(list=ls())

#Blood type count data
AB <- 131
A <- 862
B <- 365
O <- 702

#O blood type ii, A bloodtype AA or Ai
(N=AB+A+B+O)

AB/N

Pi=sqrt(O/N)
#(Pa + Pi)^2 = (A+O)/N
#Pa + Pi = sqrt((A+O)/N)
Pa = sqrt((A+O)/N)-Pi

Pb = sqrt((B+O)/N)-Pi

Pa+Pb+Pi
signif(Pa+Pb+Pi,2)

#ObsCounts*(ExpHom/ExpTot)
Paa <- A*(Pa^2/((Pa^2)+2*(Pa*Pi)))
Pai <- A*(2*(Pa*Pi))/((Pa^2)+(2*(Pa*Pi)))
Pbb <- B*(Pb^2/((Pb^2)+(2*(Pb*Pi))))
Pbi <- B*(2*(Pb*Pi))/((Pb^2)+(2*(Pb*Pi)))
Pii <- O
Pab <- AB

Pa <- ((2*Paa)+Pai+Pab)/(2*N)
Pb <- ((2*Pbb)+Pbi+Pab)/(2*N)
Pi <- ((2*Pii)+Pai+Pbi)/(2*N)

Paa <- A*(Pa^2/((Pa^2)+(2*(Pa*Pi))))
Pai <- A*(2*(Pa*Pi))/((Pa^2)+(2*(Pa*Pi)))
Pbb <- B*(Pb^2/((Pb^2)+(2*(Pb*Pi))))
Pbi <- B*(2*(Pb*Pi))/((Pb^2)+(2*(Pb*Pi)))

Pi0 <- 1
Pa0 <- 1
Pb0 <- 1
counter <- 0

#EM function. Set condition to be that loops stops when new estimate is within 12 decimal place agreement of old estimation
EM <- function(Pi, Pa, Pb){
  while((round(Pi0,12) == round(Pi,12))==FALSE && (round(Pa0,12) ==round(Pa,12))==FALSE && (round(Pb0,12) == round(Pb,12))==FALSE){
    Pi0 <- Pi
    Pa0 <- Pa
    Pb0 <- Pb
    Paa <- A*(Pa0^2/((Pa0^2)+(2*(Pa0*Pi0))))
    Pai <- A*(2*(Pa0*Pi0))/((Pa0^2)+(2*(Pa0*Pi0)))
    Pbb <- B*(Pb0^2/((Pb0^2)+(2*(Pb0*Pi0))))
    Pbi <- B*(2*(Pb0*Pi0))/((Pb0^2)+(2*(Pb0*Pi0)))
    Pii <- O
    Pab <- AB
    (Pa <- ((2*Paa)+Pai+Pab)/(2*N))
    (Pb <- ((2*Pbb)+Pbi+Pab)/(2*N))
    (Pi <- ((2*Pii)+Pai+Pbi)/(2*N))
    counter<-counter+1
  }
  return(c(paste("Pi =",Pi, ", Pa =", Pa, ", Pb =", Pb, ", Number of loops =", counter)))
}

AB <- 131
A <- 862
B <- 365
O <- 702
(N=AB+A+B+O)

Pa = sqrt((A+O)/N)-Pi
Pb = sqrt((B+O)/N)-Pi
Pi=sqrt(O/N)

EM(Pi,Pa,Pb)

#Try with different starting counts
AB <- 12
A <- 96
B <- 50
O <- 123
(N=AB+A+B+O)

(Pa = sqrt((A+O)/N)-Pi)
(Pb = sqrt((B+O)/N)-Pi)
(Pi=sqrt(O/N))

EM(Pi,Pa,Pb)
