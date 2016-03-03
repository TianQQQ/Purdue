# for DMS

#a) Make a boxplot and histogram to verify that the distribution is roughly symmetric with no outliers.
DMS=read.table(file="DMS.txt",header=T)

# Parameters for t.test
# You always indicate confidence level, alpha = 1 ??? C
# possibilities for alternative are "two.sided" (confidence interval),
# "less" (upper confidence bound for one-sided test), "greater" (lower confidence bound for one-sided test)
t.test(DMS$DMS, conf.level=0.95, alternative = "two.sided")


# boxplot
View(DMS)
attach(DMS)
hist(DMS)
