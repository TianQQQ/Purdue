airline <- read.table(file = "airline_cleaned.txt", header = TRUE) 
attach(airline)

ArrDelay <- subset(airline, ArrDelay < 60 & (TaxiIn + TaxiOut) < 60 )
