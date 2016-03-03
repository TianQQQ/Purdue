# for DMS

#a)  Make a boxplot and histogram to verify that the distribution is roughly symmetric with no outliers.
DMS=read.table(file="DMS.txt",header=T)


# histogram
# View(DMS)
# attach(DMS$DMS)
# library(lattice) # histogram ??????lattice
quartz()
hist(DMS$DMS,freq = FALSE)          # frequency should be false to get density curve.....
means <- mean(DMS$DMS)
std <- sd(DMS$DMS)
curve(dnorm(x, mean=means, sd=std), col="blue", lwd=2, add=TRUE)   # normal distribution line
lines(density(DMS$DMS, adjust=2),col = "red", lwd=2)
mean(DMS$DMS) 
sd(DMS$DMS)



# boxplot
quartz()
boxplot(DMS$DMS)
points(means, pch = 18)



#  b) Make a Normal quantile plot to confirm that there are no systematic departures from Normality.
quartz()
qqnorm(DMS$DMS,main="Normal Quantile Plot for normal distribution") 
qqline(DMS$DMS)

# c) From your observations in parts a) and b), is it appropriate to use the t- procedure?

# Assuming that the sample is SRS,
# the only other assumption that is necessary is to be sure that the distribution is normal.
# Since the sample size is 10, we can not use CLT.
# However, from the normal quantile plot and the histogram, 
# we can see that the distribution is approximately normal. 
# Therefore, this assumption is met.

# d) Generate a 95% confidence interval for the mean DMS odor threshold among all beginning oenology students (t test).

# Parameters for t.test
# You always indicate confidence level, alpha = 1 ??? C
# possibilities for alternative are "two.sided" (confidence interval),
# "less" (upper confidence bound for one-sided test), "greater" (lower confidence bound for one-sided test)
t.test(DMS$DMS, conf.level=0.95, alternative = "two.sided")

#e) Generate a 95% confidence interval for the mean DMS odor threshold among all beginning oenology students (z test).

# the z test is not default in R, so we will be loading an additional library to run this test
# You only need to run the following lines once. 
# install.packages('TeachingDemos')
# library(TeachingDemos)
#the parameters are the same for the z.test as the t.test except # that now, you need to specify the population standard
# deviation.
# x contains the data, stdev is the known standard deviation, alternative = "two.sided" indicates that this is a
# confidence interval vs. a bound
# we are going to use the same standard deviation for both tests.
stdev = sd(DMS$DMS)
stdev
z.test(DMS$DMS, conf.level = 0.95, alternative="two.sided", sd=stdev)













