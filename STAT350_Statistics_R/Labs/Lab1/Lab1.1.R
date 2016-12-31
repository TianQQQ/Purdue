head(airline2008NovS)
tail(airline2008NovS)
airline2008NovS[20:30, ]
names(airline2008NovS)
dim(airline2008NovS)
attach(airline2008NovS)
length(airline2008NovS[ , 2])
tapply(airline2008NovS[ , 2], airline2008NovS[ , 1], summary) 
sd(airline2008NovS[ , 2])
sort(tapply(airline2008NovS[ , 2], airline2008NovS[ , 1], sd))
class(airline2008NovS)
class(airline2008NovS[1, ])
class(airline2008NovS[ , 2])
class(airline2008NovS[ , 1])
levels(airline2008NovS[ , 1])
sum(airline2008NovS[ , 2])
summary(airline2008NovS[ , 2])
subset(airline2008NovS, subset = airline2008NovS[ , 2] != "red")

cleaned <-airline2008NovS[complete.cases(airline2008NovS),]
dim(cleaned)
View(cleaned)
write.table(helicon_cleaned,file="airCleaned.txt",quote=F,
           row.names=F, sep="\t")  #save



airline2008NovS_new <- airline2008NovS_cleaned
airline2008NovS_new$Dest <- as.character(airline2008NovS_new$Dest) # type err
airline2008NovS_new$Dest[airline2008NovS_new$Dest=="ATL"]<-"Atlanta"
airline2008NovS_new$Dest[airline2008NovS_new$Dest=="CHS"]<-"CharlestonAFB"
airline2008NovS_new$Dest[airline2008NovS_new$Dest=="DFW"]<-"DallasFtWorth"
airline2008NovS_new$Dest[airline2008NovS_new$Dest=="MSP"]<-"MinneapolisStPaul"
View(airline2008NovS_new)


airline2008NovS_new$ActualElapsedTime = airline2008NovS_new$AirTime + airline2008NovS_new$TaxiIn +airline2008NovS_new$TaxiOut
head(airline2008NovS_new)


