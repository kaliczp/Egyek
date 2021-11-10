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
