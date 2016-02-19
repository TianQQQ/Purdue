# A
SRS <- 1000
set <- c(1, 2, 6, 10)
for(i in set) {
  attach(mtcars)    
  par(mfrow=c(1,2))   # two plots together
  n <- i
  data.vec <- rnorm(SRS*n,mean=0,sd=1)
  data.mat <- matrix(data.vec, ncol = n)
  avg <- apply(data.mat, 1, mean)
  
  m = mean(avg)
  std = sd(avg)
  # print(n, m, std)
  str = sprintf("n = %d, mean = %f, std = %f, sample std = %f", n,m, std, std*sqrt(n))
  print(str)
  
  # windows()#this is optional
  hist(avg, xlab="Data from Normal Distribution", freq = FALSE, main=sprintf("Histogram for Normal, n = %d",n))
  curve(dnorm(x, mean=m, sd=std), col="blue", lwd=2, add=TRUE)
  lines(density(avg, adjust=1),col = "red", lwd=2)
  # windows()
  # quartz()
  qqnorm(avg,main=sprintf("Normal Quantile Plot for Normal, n = %d",n))
  qqline(avg)
  quartz()
}




