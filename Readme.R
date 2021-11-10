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

## Duplák ellenőrzése
dupla <- duplicated(index(csap.xts))
csapdup1.xts <- csap.xts[dupla]
dupla <- c(dupla[-1],FALSE)
csapdup2.xts <- csap.xts[dupla]
csapdup1.xts == csapdup2.xts
## Sima duplák
dupla <- duplicated(index(csap.xts))
csap.xts <- csap.xts[!dupla]
csap.xts[is.na(csap.xts)] <- 0

## Elemzés
sum(csap.xts["2019-11-01/2020-10-31"])
sum(csap.xts["2020-11-01/2021-10-31"])

mean(hom.xts["2019-11-01/2020-10-31"], na.rm = TRUE)
mean(hom.xts["2020-11-01/2021-10-31"], na.rm = TRUE)

sum(csap.xts["2020-01-01/2020-12-31"])
mean(hom.xts["2020-01-01/2020-12-31"], na.rm = TRUE)

plot(apply.monthly(csap.xts["2019-11-01/2021-10-31"], sum), type = "h")
