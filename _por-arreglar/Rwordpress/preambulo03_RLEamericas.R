mi.arch <- 'blog_RLEamericas.Rmd'
mi.cats <- c('SIG','RLE','homo faber')
mi.kwds <- c('Lista Roja de Ecosistemas', 'IUCN', 'Red List of Ecosystems', 'Bosques','Suramérica')
mi.titulo <- 'El bosque seco de la Caatinga: En Peligro Crítico'

require(raster)
require(RColorBrewer)

TMWB <- shapefile("/opt/gisdata/vectorial/TMworldborders/TM_WORLD_BORDERS-0.3.shp")
robin <- "+proj=robin +lon_0=-80 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0"

Americas <- spTransform(subset(TMWB,REGION %in% 19),
                        robin)


##NSmap <- raster("/opt/gisdata/Natureserve/IUCN/SAM/commondata/raster_data/SouthAmerica_IVC_MacroGroups_potential_NatureServe_v7_270m.tif")
##e <- extent(1606376, 2781325, 1571124, 3429572)
##r0 <- crop(NSmap,e)
##CaatingaTSDF <- projectRaster(r0==572,crs=robin)
CaatingaTSDF <- raster("~/tmp/CEBA/Caatinga.robin.tif")==572
BSQ2000 <- raster("~/tmp/CEBA/Caatinga.GFC2000.robin.tif")
Modis2001 <- raster("~/tmp/CEBA/Caatinga.Modis2001.robin.tif")
bsq <- stack(dir("~/tmp/CEBA/","Caatinga.bsq[0-9]+.robin",full.names=T))

plot(Modis2001)
plot(CaatingaTSDF,col=c(rgb(.1,.1,.1,.5),NA),add=T,legend=F)


plot(BSQ2000,col=brewer.pal(9,"Greens"),main="Caatinga Tropical Seasonal Dry Forest")
title(main="% Tree cover in 2000 according to Hansen et al. 2013",line=.5,cex.main=1)
title(sub=robin,line=2.5,cex.sub=.65)
plot(CaatingaTSDF,col=c(rgb(.1,.1,.1,.35),NA),add=T,legend=F)


e.xy <- extent(CaatingaTSDF)

plot(Americas,col="grey67",border="grey87")
plot(e.xy,add=T,col=rgb(.5,.1,.2,.5),lwd=2)
text(c(2423214,  2629340, -2641611),
     c(-1133168.0,  2743588.1,   188453.4),
     c("Brasil","Oceano Atlántico","Oceano Pacífico"))
plot(CaatingaTSDF,add=T)


hist(values(BSQ2000)[values(CaatingaTSDF)==1],freq=T)
barplot(values(Modis2001)[values(CaatingaTSDF)==1],freq=T)
plot(ecdf(values(BSQ2000)[values(CaatingaTSDF)==1]))

slc <- values(Modis2001)[values(CaatingaTSDF)==1]
slc[slc %in% 1:5] <- "bosque"
slc[slc %in% 6:7] <- "arbustales"
slc[slc %in% 8] <- "sabana arbolada"
slc[slc %in% 9] <- "sabana"
slc[slc %in% 10] <- "pastizales"
slc[slc %in% c(0,11)] <- "humedales"
slc[slc %in% c(12,13,14,16)] <- "cultivos e intervenido"

tt <- data.frame(table(slc))
colnames(tt) <- c("Clase","Freq")
tt$Area.km2 <- tt$Freq*prod(res(Modis2001))/1e6
tt$Porcentaje <- round(tt$Freq*100/sum(tt$Freq),1)

plot(Modis2001,main="Caatinga Tropical Seasonal Dry Forest")
title(main="Cobertura de la tierra según la clasificación de Modis GLC",line=.5,cex.main=1)
title(sub=robin,line=2.5,cex.sub=.56)
plot(CaatingaTSDF,col=c(rgb(.1,.1,.1,.5),NA),add=T,legend=F)

dts <- values(bsq)[values(CaatingaTSDF) %in% 1,]

bosque <- colSums(dts)*prod(res(bsq))/1e6
fecha <- 2001:2012
lm1 <- glm(bosque~fecha,family=quasipoisson)
yys <- 2001:2051
prd1 <- predict(lm1,data.frame(fecha=yys),se.fit=T)

plot(bosque~fecha,ylim=c(0,1e4),xlim=c(2001,2051),pch=19,col="springgreen3",cex=1.8,ylab="Estimado de cobertura boscosa en km²",xlab="Año")
matlines(yys,data.frame(exp(prd1$fit),exp(prd1$fit+(1.645*prd1$se.fit)),exp(prd1$fit-(1.645*prd1$se.fit))),lty=c(1,3,3),col="maroon",lwd=2)
