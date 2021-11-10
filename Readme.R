## Fájlnevek beolvasása
filenames <- dir(patt = "csv")
ttraw <- read.csv(filenames[1])
## Csapadék
csap <- ttraw[ttraw$parameter == "Csapadék",]
## Hőmérséklet
hom <- ttraw[ttraw$parameter == "Levegőhőmérséklet",]
## Az összes fájlra
for(tti in 2:length(filenames)) {
ttraw <- read.csv(filenames[tti])
csap <- rbind(csap, ttraw[ttraw$parameter == "Csapadék",])
hom <- rbind(hom, ttraw[ttraw$parameter == "Levegőhőmérséklet",])
}
library(xts)
csap.xts <- xts(csap$value, as.POSIXct(csap$date))
hom.xts <- xts(hom$value, as.POSIXct(hom$date))
## Duplák, amelyből az első adathiány
dupla <- duplicated(index(hom.xts))
dupla <- c(dupla[-1],FALSE)
dupla.nr <- which(dupla)
homdup.xts <- hom.xts[dupla.nr]
homdup.xts[is.na(homdup.xts)]
nadupla.nr <- dupla.nr[is.na(homdup.xts)]
hom.xts <- hom.xts[-nadupla.nr]
## Sima duplák
dupla <- duplicated(index(hom.xts))
hom.xts <- hom.xts[!dupla]
