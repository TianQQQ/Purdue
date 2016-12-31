setwd("~/Desktop/Purdue/STAT350_R/STAT350/Labs/Lab7")
CHICAGO=read.table(file="airline_cleaned.txt",header=T)
studynew <- subset(CHICAGO, Origin=="ORD" | Origin == "MDW")
ord <- subset(CHICAGO, Origin=="ORD")
mdw <- subset(CHICAGO, Origin=="MDW")

attach(studynew)
# Note: it is required that you have two curves (red and blue) on the
# histogram and the line on the normal quantile plot as done by the
#   code below.
library(lattice)
histogram(log(abs(ord$DepDelay)))
means <- mean(ord$DepDelay)
print(means)
std <- sd(ord$DepDelay)
curve(dnorm(x, mean=means, sd=std), col="blue", lwd=2, add=TRUE)   # normal distribution line
lines(density(log(abs(ord$DepDelay)), adjust=2),col = "red", lwd=2)



histogram(log(abs(mdw$DepDelay)))



histogram(~log(abs(DepDelay)) | Origin, layout=c(1,2),type="density", panel=function(x)
{panel.histogram(x) 
  panel.mathdensity(dmath=dnorm,col="blue",lwd=2,args=list(mean=mean(x, na.rm=T), sd = sd(x,na.rm=T))) 
  panel.densityplot(x,col="red",lwd=2)
  })
bwplot(~log(abs(DepDelay)) | Origin, layout = c(1, 2), pch = "|") #Boxplots side-by-side 
qqmath(~log(abs(DepDelay))| Origin, data = studynew, panel = function(x){
  panel.qqmath(x)
  panel.qqmathline(x)
})

# t test:
#t.test (qual ~ categories,conf.level=C, mu = mu0, paired=FALSE,
#alternative="value", var.equal = FALSE)
#is used for confidence intervals and hypothesis tests
#the qualitative variable is first, the variable with the groups in it is second.
#The difference is in first alphabetically ??? second alphabetically
#  conf.level = C = 1 - alpha
#  for the hypothesis test. mu is mu_0
#  paired = FALSE (2 - sample independent)
#alternative = "greater" or "less" or "two.sided" (this is the appropriate alternative hypothesis)
#var.equal = FALSE (the variances are not equal, R calls
#                   the Satterthwaite approximation the Welch approximation)

t.test(DepDelay ~ Origin, studynew, mu=0, conf.level=0.95,paired=FALSE, alternative = "two.sided",var.equal=F)
# Information required for f
stdmen = sd(subset(studynew,Origin == "ORD")$DepDelay)
sizemen = length(subset(studynew,Origin == "ORD")$DepDelay) 
stdwomen = sd(subset(studynew,Origin == "MDW")$DepDelay) 
sizewomen = length(subset(studynew,Origin == "MDW")$DepDelay) 
se = sqrt(stdmen^2/sizemen + stdwomen^2/sizewomen)

