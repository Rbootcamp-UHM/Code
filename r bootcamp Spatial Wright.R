library(dismo)

#let's get some locality data

#how many georeferenced records are there?
gbif(genus = 'Panthera', species = 'leo', geo = T, down = F)

#let's download the first 100 georeferenced records
lion <- gbif(genus = 'Panthera', species = 'leo', geo = T, down = T, end = 100)

#we get a dataframe of localities
head(lion)

#let's map it.

#load maptools
library(maptools)

#load a data set of rough country outlines
data(wrld_simpl)

#plot the world map
plot(wrld_simpl)

#plot our localities on top in red
points(lion[,c('lon','lat')], col = 'red', pch = 19)

click(wrld_simpl)

#we can plot a smaller area
head(wrld_simpl)

zoom(wrld_simpl)

points(lion[,c('lon','lat')], col = 'red', pch = 19)

plot(wrld_simpl[which(wrld_simpl$NAME %in% c('South Africa','Mozambique','Namibia','Botswana', 'Zimbabwe')),], axes = T)

#let's get a nicer map

# download a file with the states of the USA, select CA, plot that, and add points
sAfrica <- getData('GADM', country='South Africa', level=0)

plot(sAfrica)
plot(wrld_simpl[which(wrld_simpl$NAME == 'South Africa'),], border = 'red', add = T)

#add points
points(lion[,c('lon','lat')], col = 'red', pch = 19)

#how about even nicer?

library(RgoogleMaps)

kenya <- gmap('Kenya', type = 'satellite')
plot(kenya)

kenya2 <- gmap('Kenya', type = 'terrain')
plot(kenya2)

points(lion[,c('lon','lat')], col = 'red', pch = 19)

class(kenya2)

#There are different types of spatial objects. rasters are grids. our points data is not a spatial object at all. 

class(lion)

#we can make our normal data frame into a SpatialPointsDataFrame

lion.sp <- SpatialPointsDataFrame(lion[,c('lon','lat')], data = lion[,c('coordinateUncertaintyInMeters','datasetName','locality')], proj4string = CRS('+proj=longlat +datum=WGS84'))

lion.sp <- spTransform(lion.sp, CRS(proj4string(africa.map)))

points(lion.sp, pch = 21, bg = 'cyan')

click(lion.sp)

#let's get a range map from the IUCN, http://www.iucnredlist.org/technical-documents/spatial-data

mammals <- shapefile('~/Downloads/TERRESTRIAL_MAMMALS/TERRESTRIAL_MAMMALS.shp')

head(mammals)

lion.range <- mammals[which(mammals$binomial == 'Panthera leo'),]

plot(wrld_simpl)
zoom(wrld_simpl)
plot(lion.range, add = T, col = 'red')
points(lion[,c('lon','lat')], col = 'cyan', pch = 19)

#what about visualizing localities you already have?
#survey localities from Chelsie Counsell
surveys <- read.csv('~/Downloads/survey sites gps data.csv')

plot(wrld_simpl)

points(surveys[,c('longitude','latitude')], col = 'red')

zoom(wrld_simpl)

hawaii.gmap <- gmap('Hawaii', type = 'satellite')
plot(hawaii.gmap)

surveys.sp <- SpatialPointsDataFrame(surveys[,c('longitude','latitude')], data = surveys[,c('Island','SiteName')],  proj4string = CRS('+proj=longlat'))

surveys.sp <- spTransform(surveys.sp, CRS(proj4string(hawaii.gmap)))

points(surveys.sp, col = 'magenta', cex = 0.5)

library(geosphere)
survey.dist <- distm(surveys[,c('longitude','latitude')])

class(survey.dist)
dim(survey.dist)

survey.dist[,1]


##Afkhami et al. 2014
#read locality data
afk <- read.csv('~/Dropbox/Wright Lab/teaching/My Classes/Grad core/2014-2015/scripts and data/mutualism Archive/afkhamidata.csv')

#look at it
head(afk)

#how many sites are there?
nrow(afk)

#how many sites of each fungal type?
table(afk$fungi)

#get a california map
usa1 <- getData(name = 'GADM', country = 'USA', level = 1)
ca <- usa1[which(usa1$NAME_1 == 'California'),]

#plot it
plot(ca)
#add localities
points(afk$x, afk$y)


#plot it zoomed in on the region that the localities are from
plot(ca, ylim = range(afk$y), xlim = range(afk$x))
#add localities
points(afk$x, afk$y)

#color localities by fungal association
points(afk$x, afk$y, col = c('purple','blue','red')[unclass(afk$fungi)])

legend('bottomleft', bty = 'n', col = c('purple','blue','red'), legend = levels(afk$fungi), pch = 1)

#get some climate data from world clim http://worldclim.org

wc <- getData('worldclim', var='bio', res=5)

#variables (see wordlclim.org)
# BIO1 = Annual Mean Temperature
# BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp))
# BIO3 = Isothermality (BIO2/BIO7) (* 100)
# BIO4 = Temperature Seasonality (standard deviation *100)
# BIO5 = Max Temperature of Warmest Month
# BIO6 = Min Temperature of Coldest Month
# BIO7 = Temperature Annual Range (BIO5-BIO6)
# BIO8 = Mean Temperature of Wettest Quarter
# BIO9 = Mean Temperature of Driest Quarter
# BIO10 = Mean Temperature of Warmest Quarter
# BIO11 = Mean Temperature of Coldest Quarter
# BIO12 = Annual Precipitation
# BIO13 = Precipitation of Wettest Month
# BIO14 = Precipitation of Driest Month
# BIO15 = Precipitation Seasonality (Coefficient of Variation)
# BIO16 = Precipitation of Wettest Quarter
# BIO17 = Precipitation of Driest Quarter
# BIO18 = Precipitation of Warmest Quarter
# BIO19 = Precipitation of Coldest Quarter

plot(wc$bio1/10, col = rev(heat.colors(100)), main = 'Annual Mean Temp C')

plot(wc$bio5/10, col = rev(heat.colors(100)), main = 'Max Temp Warmest Month C')

#load california climate climate layers, 1950-2000, source http://www.worldclim.org/bioclim
climate <- stack('~/Dropbox/Wright Lab/teaching/My Classes/Grad core/2014-2015/scripts and data/mutualism Archive/ca.current.climate.grd')

#plot the first variable
par(mar = c(0,0,0,0))
plot(climate$bio1/10, axes = F, box = F, col = rev(heat.colors(100)))
#add points
points(afk$x, afk$y)

#extract climate data at localities
afk <- data.frame(afk, extract(climate, afk[,c('x','y')]))

#look at it
head(afk)


#plot localities and color by temp
plot(ca, ylim = range(afk$y), xlim = range(afk$x), col = 'gray95')
points(afk$x, afk$y, col = rev(heat.colors(10))[unclass(as.factor(cut(afk$bio1, 10)))], pch = c(1, 2, 3)[unclass(afk$fungi)])

library(SDMTools)
legend.gradient(cbind(x = c(-124.2, -124, -124, -124.2), y = c(38, 38, 37, 37)), rev(heat.colors(10)), limits = range(afk$bio1)/10, title = 'Mean Annual\nTemp C')
legend('bottomleft', pch = c(1,2,3), legend = levels(afk$fungi), bty = 'n')


#look at localities in temp and precip space
par(mar = c(5,4,2,1))
plot(x= afk$bio12, y = afk$bio1, ylab = 'Mean Ann. Temp', xlab = 'Ann Precip')
plot(x= afk$bio12, y = afk$bio1/10, ylab = 'Mean Ann. Temp', xlab = 'Ann Precip', col = c('purple','blue','red')[unclass(afk$fungi)])
legend('bottomleft', bty = 'n', col = c('purple','blue','red'), legend = levels(afk$fungi), pch = 1)


#run a niche model. see dismo vignette for how to set up R to run maxent
library(dismo)
library(rJava)

par(mfrow = c(1,2), mar = c(0,0,2,1))
plot(predict(maxent(climate[[c(14,4,5,8,12,13,18,10)]], p = afk[which(afk$fungi == 'E+'| afk$fungi == 'Both'), c('x','y')], a = randomPoints(climate$bio1, 10000)), climate[[c(14,4,5,8,12,13,18,10)]]), box = F, axes = F, col = topo.colors(100))
title(main = 'E+')
plot(ca, add = T)
plot(predict(maxent(climate[[c(14,4,5,8,12,13,18,10)]], p = afk[which(afk$fungi == 'E-'| afk$fungi == 'Both'), c('x','y')], a = randomPoints(climate$bio1, 10000)),climate[[c(14,4,5,8,12,13,18,10)]] ), box = F, axes = F, col = topo.colors(100))
title(main = 'E-')
plot(ca, add = T)
