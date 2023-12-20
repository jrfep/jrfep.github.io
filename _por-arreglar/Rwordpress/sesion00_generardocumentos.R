##R --vanilla
## hay que instalar pandoc-citeproc para las referencias...
require(RWordPress)
require(knitr)

setwd("~/Dropbox/ceba/www/Rwordpress/")
options(WordpressLogin = c(zuhe = "sierra nevada de M3rida"),
        WordpressURL = 'http://jrferrerparis.info/xmlrpc.php')



## post sobre contribuciones
##
source("preambulo01_ActividadJR.R")
setwd("~/Dropbox/ceba/www/Rwordpress/")
mi.arch <- 'blog_ActividadJRFeP_2.Rmd'
mi.arch <- 'blog_ActividadJRFeP_3.Rmd'
mi.cats <- c('homo faber','Publicaciones')
mi.kwds <- c('knitr', 'wordpress','publicaciones','actividad web','redes sociales','altmetric score')
mi.titulo <- 'Actualización sobre mi presencia en la red // marzo 2019'
mi.titulo <- 'Actualización sobre mi presencia en la red // abril 2019'

## preview
rmarkdown::render(mi.arch,"html_document")

## upload
knit2wp(mi.arch, categories = mi.cats, mt_keywords = mi.kwds, title = mi.titulo,publish = TRUE)




## post Barca-Atleti
mi.arch <- 'blog_LaLiga_FinalTemp2019.Rmd'
mi.cats <- c('R-scripts','homo ludens','Fútbol')
mi.kwds <- c('La Liga Española', 'Barca', 'Atleti','Senderos que se bifurcan','Deportes','probabilidades')
mi.titulo <- 'LaLiga 2019: Qué chance tiene A de ganarle a B...'

## preview
rmarkdown::render(mi.arch,"html_document")

## upload
knit2wp(mi.arch, categories = mi.cats, mt_keywords = mi.kwds, title = mi.titulo,publish = FALSE)


## post red coautores:
mi.arch <- 'blog_RLEimpact2.Rmd'
mi.cats <- c('R-scripts','homo faber','Lista Roja de Ecosistemas','Bibliometría')
mi.kwds <- c('Lista Roja de Ecosistemas', 'IUCN', 'Red List of Ecosystems')
mi.titulo <- 'Impacto de la Lista Roja de Ecosistemas de la IUCN'

## preview
rmarkdown::render(mi.arch,"html_document")

## upload
knit2wp(mi.arch, categories = mi.cats, mt_keywords = mi.kwds, title = mi.titulo,publish = FALSE)



##post sobre bibliometria IVIC
## problemas con la versión larga (la tengo en html)
mi.arch <- 'blog_Bibliometria_IVIC.Rmd'
## preview
rmarkdown::render(mi.arch,"html_document")

mi.arch <- 'blog_Bibliometria_IVIC_short.Rmd'
mi.cats <- c('R-scripts','homo faber','Bibliometría')
mi.kwds <- c('Ciencia en Venezuela','IVIC','Humanismo de la ciencia')
mi.titulo <- 'Produccion IVIC 60 años'

## preview
rmarkdown::render(mi.arch,"html_document")

## upload
knit2wp(mi.arch, categories = mi.cats, mt_keywords = mi.kwds, title = mi.titulo,publish = FALSE)




##post sobre nombres en Venezuela
mi.arch <- 'blog_CNE_nombres_Venezuela.Rmd'
mi.cats <- c('R-scripts','homo faber','SIG')
mi.kwds <- c('Geografía humana','Geografía de Venezuela','Humanismo de la ciencia')
mi.titulo <- 'Todos los nombres (I)'

## primer post
mi.arch <- 'blogposttest.Rmd'
mi.cats <- c('R-scripts','homo faber')
mi.kwds <- c('knitr', 'wordpress')
mi.titulo <- 'Ejemplo R + Markdown + WordPress en español'

## segundo post
mi.arch <- 'blog_RLEimpact.Rmd'
mi.cats <- c('R-scripts','homo faber')
mi.kwds <- c('Lista Roja de Ecosistemas', 'IUCN', 'Red List of Ecosystems')
mi.titulo <- 'Impacto de la Lista Roja de Ecosistemas de la IUCN'
options(altmetricKey=NULL)


## tercer post
source("preambulo03_RLEamericas.R")




