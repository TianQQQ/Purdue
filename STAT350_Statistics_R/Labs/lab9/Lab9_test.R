job <- read.table(file = "loc.txt", header = TRUE) 
attach(job)
#a)
library(lattice)
xyplot(STRESS ~ LOC,
         data = job,
         panel = function(x, y){
           panel.xyplot(x, y)
           panel.lmline(x, y)
         })
 #b) correlation
cor(LOC, STRESS)
 #c), d), i) calculate linear regression and get results
job.lm = lm(STRESS ~ LOC)
summary(job.lm)

#e) calculate the residuals
job.resid = job.lm$res #Extract residuals obtained in job.lm operation

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

