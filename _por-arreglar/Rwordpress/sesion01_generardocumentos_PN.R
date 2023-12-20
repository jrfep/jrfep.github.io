##R --vanilla
## hay que instalar pandoc-citeproc para las referencias...
require(RWordPress)
require(knitr)
require(chron)
require(ROpenOffice)
require(gdata)

setwd("~/Dropbox/ceba/www/Rwordpress/")
options(WordpressLogin = c(zuhe = {{{}}}),
        WordpressURL = 'http://jrferrerparis.info/xmlrpc.php')
mi.cats <- c('SIG','biodiversity informatics','sensores remotos','homo faber')
mi.kwds <- c('Parques Nacionales', 'Áreas Protegidas', 'Caracterización ambiental')

meses <- c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre")


listaPN <- read.ods("~/Dropbox/Mapoteca/data/350_ParquesNacionales/ListaParques.ods")

fchs <- chron(dates.=as.character(listaPN[,"fecha creacion"]),format=c(dates="Ymd"),out.format="Y-m-d")
hoy <- chron(format(Sys.time(),"%Y-%m-%d"),format="Y-m-d")
hoy <- hoy+2
slc <- listaPN[months(fchs) %in% months(hoy) & days(fchs)>days(hoy),]

if (nrow(slc) == 1) {
    ## posts sobre parques nacionales
    mi.parque <- trim(gsub("[“”]","",slc$Parque))
    mi.cdg <- slc$"id ecosig"
    mi.fecha <- fchs[months(fchs) %in% months(hoy) & days(fchs)>days(hoy)]
    fecha.crea <- sprintf("%s de %s de %s",days(mi.fecha),meses[months(mi.fecha)],years(mi.fecha))
    mi.titulo <- sprintf("Una breve caracterización ambiental del Parque Nacional %s en Venezuela",mi.parque)
    fecha.pub <- sprintf("%s %s, %s",meses[months(mi.fecha)],days(mi.fecha),years(hoy))

    require(raster)
    Vzla <- shapefile("/opt/gisdata/vectorial/ecoSIG/division_pol.shp")

    system(sprintf("unzip %s",dir(sprintf("/opt/gisdata/vectorial/ecoSIG/parques/%s/",mi.cdg),"limite.zip",full.names=T)))
    PN.shp <- shapefile(dir(pattern=sprintf("pn%s_limite.shp",mi.cdg)))
    system(sprintf("rm pn%s*.*",mi.cdg))
    PN.xy <- spTransform(PN.shp,Vzla@proj4string)
    qry <- over(PN.xy,Vzla,returnList=T)[[1]]$ID
    if (slc[,"id ecosig"] %in% "038") {
        e1 <- extent(subset(Vzla,ESTADO %in% "Lara"))
        e0 <- extent(PN.xy)
    
        e1 <- extent( min(e0@xmin,e1@xmin),
                     max(e0@xmax,e1@xmax),
                     min(e0@ymin,e1@ymin),
                     max(e0@ymax,e1@ymax))
        
    } else {
        e0 <- extent(t(data.frame(lapply(Vzla[Vzla@data$ID %in% qry,]@polygons,function(x) x@labpt))))
    e1 <- extent(PN.xy)
    
    e2 <- extent( min(e0@xmin,e1@xmin),
                 max(e0@xmax,e1@xmax),
                 min(e0@ymin,e1@ymin),
                 max(e0@ymax,e1@ymax))

    }



    Vzla.xy <- crop(Vzla,e1)
    mi.ubicacion <- paste( over(PN.xy,Vzla,returnList=T)[[1]]$ESTADO,collapse=", ")

    if (!exists("PN.SRTM")) {
        relev <-   raster("~/SIG/mapas/Venezuela/SRTM/SRTM.Venezuela.tif")
        PN.SRTM <- crop(relev,PN.xy)
    }
    
    if (!exists("PN.chirps")) {
        rchirps <-   stack(dir("~/SIG/mapas/Venezuela/chirps","tif$",full.names=T))

        PN.chirps <- crop(rchirps,PN.xy)
    }

    
    system(sprintf("echo 's/AQUIVAELTITULO/%s/g' > ParquesNacionales.sed",mi.titulo))
    system(sprintf("echo 's/AQUIVALAFECHAPUBLICACION/%s/g' >> ParquesNacionales.sed",fecha.pub))
    system(sprintf("echo 's/AQUIVAELPARQUE/%s/g' >> ParquesNacionales.sed",mi.parque))
    system(sprintf("echo 's/AQUIVALAFECHA/%s/g' >> ParquesNacionales.sed",fecha.crea))
    system(sprintf("echo 's/AQUIVALAUBICACION/%s/g' >> ParquesNacionales.sed",mi.ubicacion))
    system(sprintf("echo 's/AQUIVANLOSAÑOS/%s/g' >> ParquesNacionales.sed",floor((hoy-mi.fecha)/365)))
    system(sprintf("sed -f ParquesNacionales.sed blog_PNvzla.Rmd > blog_PNvzla_%s.Rmd",mi.cdg))
    
    mi.arch <- sprintf("blog_PNvzla_%s.Rmd",mi.cdg)
    ## preview
rmarkdown::render(mi.arch,"html_document")

## upload
knit2wp(mi.arch, categories = mi.cats, mt_keywords = mi.kwds, title = mi.titulo,publish = FALSE)


}





##########
## Para agregar a próximas versiones
############

##Utilicé datos del (VII Censo Agrícola Nacional)[https://www.cepal.org/es/notas/venezuela-vii-censo-agricola-nacional-disponible-procesamiento-linea-redatam-mat] de 2011 para analizar áreas de conflicto de uso dentro de los linderos del Parque Nacional.
## Conflictos de uso según senso agrícola de 2011

##y datos de temperatura del *MODIS Land Surface Temperature and Emissivity* (MOD11 V5)[https://modis.gsfc.nasa.gov/data/dataprod/mod11.php] basados en variables de sensores remotos (Wan & Li 2008).

#Z. Wan, and Z.-L. Li (2008) (*Radiance-based validation of the V5 MODIS land-surface temperature product*)[https://doi.org/10.1080/01431160802036565], **International Journal of Remote Sensing** 29: 5373-5393.
