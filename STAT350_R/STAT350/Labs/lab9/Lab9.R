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




#e) calculate the residuals
local.resid = local.lm$res #Extract residuals obtained in job.lm operation

xyplot(job.resid ~ LOC,
       data = job,
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
#h)
confint(job.lm, level = 0.95)
#NOTE: This can also be done by hand from output of summary(job.lm) > # However, in this lab, you must use the code above.

