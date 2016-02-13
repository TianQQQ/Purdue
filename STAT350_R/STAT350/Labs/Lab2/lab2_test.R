
#In this data file, there are both spaces and tabs. The
# sep command tells R that you only want to use tabs (\t) as
# separators. This occurs in some of the data sets so if you
# notice that there are spaces in either the variable names or > # the data itself, you need to add this addition keyword in
# the command.
TimeStart <- read.table("eg01-23time24.txt", header = T, sep= "\t")
#View(TimeStart)

attach(TimeStart)
mean(TimeToStart) 
sd(TimeToStart)
mean(TimeStart[,2]) 
sd(TimeStart[,2])
mean(TimeStart$TimeToStart) 
sd(TimeStart$TimeToStart)

fivenum(TimeToStart)

hist(TimeToStart)
histogram(TimeToStart)
#install.packages("lattice") #Only needs to be run once

boxplot(TimeToStart)
means = mean(TimeToStart)
points(means, pch = 18)
bwplot(TimeToStart)
