yoga=read.table(file="yoga.txt",header=T,sep="\t") 
attach(yoga)

# The code for parts a) and c) are omitted. Please see # Labs 2 (boxplot) and 3 (histogram) for details.
# Transformation
logMin = log(Time..min.)


#t.test(logMin, conf.level=0.95, mu = 1.4, alternative = "greater")
#You always indicate confidence level, alpha = 1 ??? C
#possibilities for alternative are "two.sided" (confidence interval),
#"less" (upper confidence bound for one-sided test), "greater" (lower confidence bound for one-sided test)
t.test(logMin, conf.level=0.95, mu = 1.4, alternative = "greater")
