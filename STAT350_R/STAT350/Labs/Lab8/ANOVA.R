airline=read.table(file="airline_cleaned.txt",header=T)
attach(airline)
airline$trans.TaxiIn=log(TaxiIn)
studynew <- subset(airline, UniqueCarrier =="UA" | UniqueCarrier =="AA"| UniqueCarrier =="NW")
# select=c(FlightNum,UniqueCarrier))
ua <- subset(airline, UniqueCarrier =="UA")
aa <- subset(airline, UniqueCarrier =="AA")
nw <- subset(airline, UniqueCarrier =="NW")

detach(airline)
attach(studynew)

library(lattice)
studynew.new <- droplevels(studynew)
# studynew.new <- droplevels(studynew)
Comp = studynew.new$trans.TaxiIn
Group = studynew.new$UniqueCarrier
# boxplot(log(studynew.new$TaxiIn) ~studynew.new$UniqueCarrier, studynew.new)
quartz()
trace<-rep(1, length(Group))
interaction.plot(Group,trace,Comp,fun=mean,legend=F)
quartz()
trace<-rep(1, length(Group))
interaction.plot(Group,trace,studynew.new$TaxiIn,fun=mean,legend=F)

print(tapply(Comp, Group, length))
print(tapply(Comp, Group, mean))
print(tapply(Comp, Group, sd))

histogram(~studynew.new$trans.TaxiIn | studynew.new$UniqueCarrier, layout=c(1,3),type="density", 
          panel=function(x,...) 
          {panel.histogram(x,...) 
            panel.mathdensity(dmath=dnorm,col="blue",lwd=2,
                              args=list(mean=mean(x, na.rm=T), sd = sd(x,na.rm=T)),...)
            panel.densityplot(x,col="red",lwd=2,...)
          })
bwplot(~studynew.new$trans.TaxiIn | studynew.new$UniqueCarrier, layout = c(1, 3), pch = "|") #Boxplots side-by-side 
qqmath(~log(abs(studynew.new$TaxiIn)) | studynew.new$UniqueCarrier, data = studynew.new, panel = function(x){
  panel.qqmath(x)
  panel.qqmathline(x)
})

fit <- aov(Comp ~ Group, data=studynew.new)
summary(fit)
# tukey test
test.Tukey<-TukeyHSD(fit,conf.level=0.95)
test.Tukey

