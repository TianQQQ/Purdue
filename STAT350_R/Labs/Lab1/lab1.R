helicon<-ex01.88helicon_m
head(helicon)
tail(helicon)
helicon[20:30, ]
names(helicon)
dim(helicon)
attach(helicon)
length(helicon[ , 2])
tapply(helicon[ , 2], helicon[ , 1], summary) 
sd(helicon[ , 2])
sort(tapply(helicon[ , 2], helicon[ , 1], sd))
subset(helicon, subset = helicon[ , 1] != "red")

cleaned <-helicon[complete.cases(helicon),]
class(helicon)
class(helicon[1, ])
class(helicon[ , 2])
class(helicon[ , 1])
levels(helicon[ , 1])
sum(helicon[ , 2])
summary(helicon[ , 2])
helicon_cleaned <-helicon[complete.cases(helicon),]
View(helicon)

write.table(helicon_cleaned,file="helico_cleaned.txt",quote=F,
            row.names=F, sep="\t") # save data


helico_new <- helicon_cleaned
helico_new$Variety <- as.character(helico_new$Variety)
helico_new$Variety[helico_new$Variety=="red"]<-"Caribaea_Red"
helico_new$Variety[helico_new$Variety=="yellow"]<-"Caribaea_yellow"
View(helicon_new)


helicon_new$length_inches = helicon_new$Length/25.4 
head(helicon_new)

