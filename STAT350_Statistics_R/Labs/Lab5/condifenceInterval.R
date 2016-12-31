# A
i=0
while(i < 30) {
  data.vec <- rnorm(40,mean=10,sd=2)
  data.mat <- matrix(data.vec, ncol = n)
  avg <- apply(data.mat, 1, mean)
  
  m = mean(avg)
  std = sd(avg)
  print(z.test(data.vec, conf.level = 0.80, alternative="two.sided", sd=std))
  i<- i+1
}

# B
hogs=read.table(file="hogs.txt",header=T)

print(hogs$Weight.lb.)
quartz()
hist(hogs$Weight.lb.,freq = FALSE)          # frequency should be false to get density curve.....
means <- mean(hogs$Weight.lb.)
print(means)
std <- sd(hogs$Weight.lb.)
curve(dnorm(x, mean=means, sd=std), col="blue", lwd=2, add=TRUE)   # normal distribution line
lines(density(hogs$Weight.lb., adjust=2),col = "red", lwd=2)
mean(hogs$Weight.lb.) 
sd(hogs$Weight.lb.)

# boxplot
quartz()
boxplot(hogs$Weight.lb.)
points(means, pch = 18)



#  b) Make a Normal quantile plot to confirm that there are no systematic departures from Normality.
quartz()
qqnorm(hogs$Weight.lb.,main="Normal Quantile Plot for normal distribution") 
qqline(hogs$Weight.lb.)

t.test(hogs$Weight.lb., conf.level=0.95, alternative = "two.sided")
library(TeachingDemos)
stdev = sd(hogs$Weight.lb.)
stdev
z.test(hogs$Weight.lb., conf.level = 0.95, alternative="two.sided", sd=stdev)













