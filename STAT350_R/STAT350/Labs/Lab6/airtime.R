



setwd("~/Desktop/Purdue/STAT350_R/STAT350/Labs/Lab6")
airline_cleaned <- read.delim("~/Desktop/Purdue/STAT350_R/STAT350/Labs/Lab6/airline_cleaned.txt")

attach(airline_cleaned)
AirTime = log(airline_cleaned$AirTime)                               # log the data!!!!
airline_cleaned$AirTime = log(airline_cleaned$AirTime)
mean(AirTime) 
sd(AirTime)
mean(airline_cleaned$AirTime) 
sd(airline_cleaned$AirTime)


print(airline_cleaned$AirTime)
quartz()
hist(airline_cleaned$AirTime,freq = FALSE)          # frequency should be false to get density curve.....
means <- mean(airline_cleaned$AirTime)
print(means)
std <- sd(airline_cleaned$AirTime)
curve(dnorm(x, mean=means, sd=std), col="blue", lwd=2, add=TRUE)   # normal distribution line
lines(density(airline_cleaned$AirTime, adjust=2),col = "red", lwd=2)
mean(airline_cleaned$AirTime) 
sd(airline_cleaned$AirTime)


# boxplot
quartz()
boxplot(airline_cleaned$AirTime)
points(means, pch = 18)



#  b) Make a Normal quantile plot to confirm that there are no systematic departures from Normality.
quartz()
qqnorm(airline_cleaned$AirTime,main="Normal Quantile Plot for normal distribution") 
qqline(airline_cleaned$AirTime)

t.test(airline_cleaned$AirTime, conf.level=0.95, alternative = "two.sided")
library(TeachingDemos)
stdev = sd(airline_cleaned$AirTime)
stdev
z.test(airline_cleaned$AirTime, conf.level = 0.95, alternative="two.sided", sd=stdev)

