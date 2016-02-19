# E
SRS <- 1000
set <- c(1, 5, 10, 20, 30, 40 ,50)
for(i in set) {
  attach(mtcars)                  # two plots in line
  par(mfrow=c(1,2))
  n <- i
  data.vec <- rexp(SRS*n,2) #creates the random data  # lambda
  data.mat <- matrix(data.vec, ncol = n)
  avg <- apply(data.mat, 1, mean)
  
  m = mean(avg)
  std = sd(avg)
  # print(n, m, std)
  str = sprintf("n = %d, mean = %f, std = %f, sample std = %f", n,m, std, std*sqrt(n))
  print(str)
  
  # windows()#this is optional
  hist(avg, xlab="Data from exponential Distribution", freq = FALSE, main=sprintf("Histogram for exponential, n = %d",n))
  
  curve(dnorm(x, mean=m, sd=std), col="blue", lwd=2, add=TRUE)
  lines(density(avg, adjust=1),col = "red", lwd=2)
  # windows()
  # quartz()
  qqnorm(avg,main=sprintf("Normal Quantile Plot for Normal, n = %d",n))
  qqline(avg)
  quartz()
}

