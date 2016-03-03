# for DMS

#a) Make a boxplot and histogram to verify that the distribution is roughly symmetric with no outliers.
DMS=read.table(file="DMS.txt",header=T)


# histogram
# View(DMS)
# attach(DMS$DMS)
# library(lattice) # histogram ??????lattice
hist(DMS$DMS???breaks = "Sturges")
means <- mean(DMS$DMS)
std <- sd(DMS$DMS)
curve(dnorm(x, mean=means, sd=std), col="blue", lwd=2, add=TRUE)   # normal distribution line
lines(density(DMS$DMS, adjust=2),col = "red", lwd=2)
mean(DMS$DMS) 
sd(DMS$DMS)
# boxplot
boxplot(DMS$DMS)
points(means, pch = 18)









# Parameters for t.test
# You always indicate confidence level, alpha = 1 ??? C
# possibilities for alternative are "two.sided" (confidence interval),
# "less" (upper confidence bound for one-sided test), "greater" (lower confidence bound for one-sided test)
t.test(DMS$DMS, conf.level=0.95, alternative = "two.sided")



