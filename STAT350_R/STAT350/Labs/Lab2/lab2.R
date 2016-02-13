setwd("~/Desktop/STAT350/STAT350/Labs/Lab2")
airline_cleaned <- read.delim("~/Desktop/STAT350/STAT350/Labs/Lab2/airline_cleaned.txt")

#PART A
attach(airline_cleaned)
mean(ActualElapsedTime) 
sd(ActualElapsedTime)
mean(airline_cleaned$ActualElapsedTime) 
sd(airline_cleaned$ActualElapsedTime)

fivenum(ActualElapsedTime)

hist(ActualElapsedTime)
histogram(ActualElapsedTime)
#install.packages("lattice") #Only needs to be run once

boxplot(ActualElapsedTime)
means = mean(ActualElapsedTime)
points(means, pch = 18)
bwplot(ActualElapsedTime)

#PART B
attach(airline_cleaned)
mean(TaxiIn) 
sd(TaxiIn)
mean(airline_cleaned$TaxiIn) 
sd(airline_cleaned$TaxiIn)

fivenum(TaxiIn)

hist(TaxiIn)
histogram(TaxiIn)
#install.packages("lattice") #Only needs to be run once

boxplot(TaxiIn)
means = mean(TaxiIn)
points(means, pch = 18)
bwplot(TaxiIn)


