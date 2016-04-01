setwd("~/Desktop/Purdue/STAT350_R/STAT350/Labs/Lab7")
mpg=read.table(file="AirlineTaxi_In_Out.txt",header=T) 
attach (mpg)
# For the diagnoistics plots, you will need to create the one sample # data which is the difference between the two sets. You will need to # create the histogram, boxplot and QQPlot on this data set
# (code not included)
normaltest = avgTaxiOut - avgTaxiIn
#t.test (x,y,conf.level=C, mu = mu0, paired=TRUE, alternative="value") # is used for confidence intervals and hypothesis tests
# conf.level = C = 1 - alpha
# for the hypothesis test. mu is mu_0
#  paired = TRUE (2-sample paired)
# The pairing will be x ??? y
# alternative = "greater" or "less" or "two.sided" (this is the
#  for two-sample independent ONLY appropriate alternative hypothesis)
t.test(avgTaxiOut,avgTaxiIn, mu=0,conf.level=0.95,paired = TRUE, alternative = "two.sided")
# Information required for f
std = sd(normaltest)
size = length(avgTaxiOut)
se = std/sqrt(size)

