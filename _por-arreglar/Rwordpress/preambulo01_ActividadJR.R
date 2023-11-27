##R --vanilla
require(rAltmetric)
require(scholar)
require(rcrossref)
require(rfigshare)
require(xml2)
require(RColorBrewer)
require(WikipediR)
require(chron)
require(twitteR)
library(lattice)
require(RWordPress)

jrfp <- "A2Thq5UAAAAJ"
gs.jrfp <- get_publications(jrfp)

dcs <- data.frame()
dois <- c(ScienceOpenTI="10.14293/S2199-1006.1.SOR-LIFE.CLJUS9H.v1",
          ScienceOpenRLE="10.14293/S2199-1006.1.SOR-EARTH.CL5PTKB.v1",
          ScienceOpenReview="10.14293/S2199-1006.1.SOR-EARTH.A0RFBP.v1.RBZJHH",
    NM01="10.6084/m9.figshare.4729813",
          NM02="10.6084/m9.figshare.4729858",
          NM03="10.6084/m9.figshare.4729876",
          NM04="10.6084/m9.figshare.4733092",
          NM05="10.6084/m9.figshare.4733107",
          NM06="10.6084/m9.figshare.4733098",
          NM07="10.6084/m9.figshare.4733101",
          NM08="10.6084/m9.figshare.4736611",
          NM09="10.6084/m9.figshare.4745524",
          NM10="10.6084/m9.figshare.4745530",
          NM11="10.6084/m9.figshare.4745545",
          NM12="10.6084/m9.figshare.4745566",
          NM13="10.6084/m9.figshare.4745578",
          NM14="10.6084/m9.figshare.4745611",
          NM15="10.6084/m9.figshare.4745635",
          NM16="10.6084/m9.figshare.4745662",
          NM17="10.6084/m9.figshare.4745674",
          NM18="10.6084/m9.figshare.4745692",
          NM19="10.6084/m9.figshare.4745719",
          NM20="10.6084/m9.figshare.4745734",
          NM21="10.6084/m9.figshare.4745755",
          NM22="10.6084/m9.figshare.4745776",
          NM23="10.6084/m9.figshare.4745791",
          NM24="10.6084/m9.figshare.4745821",
          NM25="10.6084/m9.figshare.4745836",
          NM27="10.6084/m9.figshare.4729771",
          NM26="10.6084/m9.figshare.4729786",
          NM80="10.6084/m9.figshare.4757173",
          NM96="10.6084/m9.figshare.4757176",
          RLEamericas="10.1111/conl.12623",
          RLEimpacts="10.20944/preprints201812.0097.v1",
          Cardenalito="10.1002/ece3.3628",
          Pedosphere="10.1016/S1002-0160(18)60029-3",
          BurroNegro="10.12933/therya-18-616",
          Jaguar="10.1016/j.biocon.2016.09.027",
          Oxysternon="10.1007/s10841-016-9886-6",
          TwoInvasives="10.1016/j.jaridenv.2016.04.007",
          Tremarctos="10.1111/acv.12106",
          Amazona="10.1007/s10841-016-9886-6",
          Congruence="10.1371/journal.pone.0063570",
          "10.1016/j.biocon.2013.07.032",
          NeoMapasAves="10.1676/11-057.1",
          Optimizacion="10.15517/rbt.v61i1.10941",
          NeoMaps="10.1111/ddi.12012",
          Poaching="10.1017/S0030605308006996",
          Macrogroups="10.6084/m9.figshare.7488872",
          "10.6084/m9.figshare.1094280",
          "10.6084/m9.figshare.1094411",
          "10.6084/m9.figshare.1133764",
          "10.1594/PANGAEA.803430",
          ##globidataset  10.5281/zenodo.1436867
          bordoni="10.1098/rsbl.2003.0015",
          redonda="10.5281/zenodo.18332",
          bioclim="10.6084/m9.figshare.7891052.v1")

for (midoi in dois) {
    if (!midoi %in% dcs$doi) {
        citas <- cr_citation_count(doi = midoi)
        referencia <- cr_cn(dois = midoi, format = "text",style="apa")
        qry <- try(altmetrics(doi = midoi))
        g.slc <- gs.jrfp[grep(gsub("[()]","",substr(strsplit(referencia,"). ")[[1]][2],1,50)),
                              gsub("[()]","",gs.jrfp$title),ignore.case=T),]
        
      
        dcs <- rbind(dcs,data.frame(doi=midoi,score=ifelse(any(class(qry) %in% "try-error"),0,qry$score),
                                    ref=referencia,
                                    gid=g.slc$cid[1],
                                    g.cites=sum(g.slc$cites),
                                    cr.cites=citas$count))
    }
}

dcs$total <- ifelse(is.na(dcs$g.cites),0,dcs$g.cites*2) +
    ifelse(is.na(dcs$cr.cites),0,dcs$cr.cites*5) +
        ifelse(is.na(dcs$score),0,dcs$score) 
dcs <- dcs[rev(order(dcs$total)),]

par(mar=c(18,4,1,1),las=2,cex.axis=0.75)
barplot(t(dcs[,c("score","g.cites","cr.cites")]),
        names.arg=substr(sapply(as.character(dcs$ref),function(x) strsplit(x,"). ")[[1]][2]),1,50),col=brewer.pal(3,"Set3"),cex.axis=1)
legend("topright",c("Altmetric score","GS cites","CR cites"),fill=brewer.pal(3,"Set3"))


options(WordpressLogin = c(zuhe = "sierra nevada de M3rida"),
        WordpressURL = 'http://jrferrerparis.info/xmlrpc.php')
setwd("~/mi.git/CEBA.LEE/R/")

##download.file("http://blog.revolutionanalytics.com/downloads/calendarHeat.R","calendarHeat.R")
source("calendarHeat.R")

##~/Dropbox/ceba/bin/gitLogs.sh
read.csv("~/mi.git/project-logs.csv")


contribs.en <- user_contributions("en", "wikipedia", username = "jrfep",limit=1000)
contribs.es <- user_contributions("es", "wikipedia", username = "jrfep",limit=1000)
##contribs.eva <- user_contributions(domain="wikieva.org.ve/index.php", username = "jrfep",properties = "ids", limit = 1)
fecha1 <- unlist(lapply(contribs.es$query[[1]],function(x) x$timestamp))
fecha2 <- unlist(lapply(contribs.en$query[[1]],function(x) x$timestamp))



cK <- "fmEceE7yi6ROw9JuNHq2Ug" ## consumer key
cS <- "xTLUGCxUBwttxsnHAQE2OFGJNopeLNpMtDp85xfPE" ## consumer secret
At <- "1951857650-YBM9SB1mIqy5uTjVXhaJuz5zxJGxwUQM933saQf"
As <- "keQl9kHLt8FCNKddusGBaRFf5viI0byNfF47SjetEc8"
setup_twitter_oauth(cK,cS,At,As)
tuser <- getUser('RSaurio')

ut <- userTimeline('NeoMapas', n=1000)
u2 <- userTimeline('Rsaurio', n=1000)
u3 <- userTimeline('jrfep', n=1000)


fecha3 <- c(unlist(lapply(ut,function(x) substr(as.character(x$created),1,10))),
            unlist(lapply(u2,function(x) substr(as.character(x$created),1,10))),
            unlist(lapply(u3,function(x) substr(as.character(x$created),1,10))))

prb <- RWordPress::getPosts()

fecha4 <- substr(prb$date_created_gmt,1,10)
## Dropbox/ceba/bin/gitLogs.sh
fecha5 <- substr(read.csv("~/mi.git/project-logs.csv")$timestamp,1,10)

fechas <- chron(dates.=substr(c(fecha1,fecha2,fecha3,fecha4,fecha5),1,10),format="y-m-d")
fechas <- subset(fechas,years(fechas) %in% 2014:2019)

