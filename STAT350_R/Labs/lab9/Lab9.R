airline <- read.table(file = "airline_cleaned.txt", header = TRUE) 
attach(airline)

localAirline <- subset(airline, ArrDelay < 60 & (TaxiIn + TaxiOut) < 60 & Distance <= 2704 )
detach(airline)
detach(studynew)
attach(ArrDelay)
#1)
library(lattice)
xyplot(localAirline$ActualElapsedTime ~ Distance,
       data = localAirline,
       panel = function(x, y){
         panel.xyplot(x, y)
         panel.lmline(x, y)
       })

#2) correlation
cor(Distance, ActualElapsedTime)
#c), d), i) calculate linear regression and get results
local.lm = lm(localAirline$ActualElapsedTime ~ Distance)
summary(local.lm)

#7)
x <- subset(airline, Month == 11 &	DayofMonth == 7 & Origin == "MSP" &	Dest == "MKE" & DepTime	== 1529)
x$Distance
x$ActualElapsedTime


#8) calculate the residuals

local.resid = local.lm$res #Extract residuals obtained in job.lm operation

xyplot(local.resid ~ Distance,
       data = local.lm,
       main="Residual plot",
       ylab = "Residual",
       panel = function(x, y){
         panel.xyplot(x, y)
         panel.abline(h = 0)
       })
# f)
# Calculate the histogram and qqplot on the residuals please see previous labs for this
# Note: this is a single sample
# Generate the 2-sided Confidence Interval (CI) for the parameters
histogram(local.resid, type="density", 
          panel=function(x,...) 
          {panel.histogram(x,...) 
            panel.mathdensity(dmath=dnorm,col="blue",lwd=2,
                              args=list(mean=mean(x, na.rm=T), sd = sd(x,na.rm=T)),...)
            panel.densityplot(x,col="red",lwd=2,...)
          })
qqmath(local.resid, panel = function(x){
  panel.qqmath(x)
  panel.qqmathline(x)
})
#h)
confint(local.lm, level = 0.99)
#NOTE: This can also be done by hand from output of summary(job.lm) > # However, in this lab, you must use the code above.

