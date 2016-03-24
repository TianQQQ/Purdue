



setwd("~/Desktop/Purdue/STAT350_R/STAT350/Labs/Lab6")
airline_cleaned <- read.delim("~/Desktop/Purdue/STAT350_R/STAT350/Labs/Lab6/airline_cleaned.txt")

attach(airline_cleaned)
mean(ActualElapsedTime) 
sd(ActualElapsedTime)
mean(airline_cleaned$ActualElapsedTime) 
sd(airline_cleaned$ActualElapsedTime)


print(airline_cleaned$ActualElapsedTime)
quartz()
hist(airline_cleaned$ActualElapsedTime,freq = FALSE)          # frequency should be false to get density curve.....
means <- mean(airline_cleaned$ActualElapsedTime)
print(means)
std <- sd(airline_cleaned$ActualElapsedTime)
curve(dnorm(x, mean=means, sd=std), col="blue", lwd=2, add=TRUE)   # normal distribution line
lines(density(airline_cleaned$ActualElapsedTime, adjust=2),col = "red", lwd=2)
mean(airline_cleaned$ActualElapsedTime) 
sd(airline_cleaned$ActualElapsedTime)

# boxplot
quartz()
boxplot(airline_cleaned$ActualElapsedTime)
points(means, pch = 18)



#  b) Make a Normal quantile plot to confirm that there are no systematic departures from Normality.
quartz()
qqnorm(airline_cleaned$ActualElapsedTime,main="Normal Quantile Plot for normal distribution") 
qqline(airline_cleaned$ActualElapsedTime)

t.test(airline_cleaned$ActualElapsedTime, conf.level=0.95, alternative = "two.sided")
library(TeachingDemos)
stdev = sd(airline_cleaned$ActualElapsedTime)
stdev
z.test(airline_cleaned$ActualElapsedTime, conf.level = 0.95, alternative="two.sided", sd=stdev)

