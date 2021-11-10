rawjunaug <- read.csv("Egyekjun1aug1.csv")
rawaugokt <- read.csv("Egyekaug1okt10.csv")

## Csapadék
csap <- rawjunaug[rawjunaug$parameter == "Csapadék",]
ttcsap <- rawaugokt[rawaugokt$parameter == "Csapadék",]
csap <- rbind(csap, ttcsap[49:nrow(ttcsap),])
library(xts)
csap.xts <- xts(csap$value, as.POSIXct(csap$date))

## Hőmérséklet
hom <- rawjunaug[rawjunaug$parameter == "Levegőhőmérséklet",]
tthom <- rawaugokt[rawaugokt$parameter == "Levegőhőmérséklet",]
hom <- rbind(hom, tthom[49:nrow(tthom),])
hom.xts <- xts(hom$value, as.POSIXct(hom$date))
plot(hom.xts)
raw2020novdec <- read.csv("Egyek2020nov1dec31.csv")
