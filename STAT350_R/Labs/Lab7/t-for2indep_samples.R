study=read.table(file="studyhabits.txt",header=T)
studynew <- subset(study, Sex=="Men" | Sex == "Women")

attach(studynew)
# Note: it is required that you have two curves (red and blue) on the
# histogram and the line on the normal quantile plot as done by the
#   code below.
library(lattice)
histogram(~SSHA | Sex, layout=c(1,2),type="density", panel=function(x)
{
  panel.histogram(x) 
  panel.mathdensity(dmath=dnorm,col="blue",lwd=2,args=list(mean=mean(x, na.rm=T), sd = sd(x,na.rm=T))) 
  panel.densityplot(x,col="red",lwd=2)
})
bwplot(~SSHA | Sex, layout = c(1, 2), pch = "|") #Boxplots side-by-side 
qqmath(~SSHA| Sex, data = study, panel = function(x){
panel.qqmath(x)
panel.qqmathline(x)
})


t.test(SSHA ~ Sex, study, mu=0, conf.level=0.99,paired=FALSE, alternative = "less",var.equal=F)
# Information required for f
stdmen = sd(subset(study,Sex == "Men")$SSHA)
sizemen = length(subset(study,Sex == "Men")$SSHA) 
stdwomen = sd(subset(study,Sex == "Women")$SSHA) 
sizewomen = length(subset(study,Sex == "Women")$SSHA) 
se = sqrt(stdmen^2/sizemen + stdwomen^2/sizewomen)

