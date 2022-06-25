d <- read.table(file="C:/Users/Akash pratap singh/OneDrive/Desktop/grass (1).csv", header = T, sep=",")
View(d)
names(d)
levels(d$rich)


table(d$rich)

boxplot(d$rich~d$graze, las=1, ylab= "rich", xlab="graze", main="graze")

mean(d$rich[d$rich=="mow"])
mean(d$weight[d$feed=="unmow"])

#OR other way

with(d,tapply(rich, graze, mean))

test.stat1 <- abs(mean(d$rich[d$graze=="mow"])- mean(d$rich[d$graze=="unmow"]))
test.stat1

#OR ANOTHER WAY
abs(diff(with(d,tapply(rich, graze, mean))))

median(d$rich[d$graze=="mow"])
median(d$rich[d$graze=="unmow"])

#OR ANOTHER WAY
with(d,tapply(rich, graze, median))

#lets calculate the absolute diff in medians
test.stat2 <- abs(median(d$rich[d$graze=="mow"]) - median(d$rich[d$graze=="unmow"]))
test.stat2
#OR
abs(diff(with(d, tapply(rich, graze, median))))

## Let's take a look at the 3 "Classic" hyp tests we could consider
## each of which comes with their own limitations

#let's look at independent 2-sample t-test
t.test(d$rich~d$graze, paired=F, var.eq=F)

#look at wilcoxon aka mann-Whitney U
wilcox.test(d$rich~d$graze,paired=F) #tests Ho:medians are equal

#look at kolmogorov-smirnov 2-sample test
ks.test(d$rich[d$graze=="mow"],d$rich[d$graze=="unmow"], paired = F)

#############################################################
########### BOOT sTRAP#######################################
##############################################################
set.seed(112358) # for reproducibility
n <-length(d$graze)
n
B <- 10000   # number of bootstrap samples
variable <- d$rich   #variable we will reample from

# now get bootstrap samples ( without loops!)
BootstrapSamples <- matrix(sample(variable,size=n*B, replace=TRUE), nrow=n,ncol=B)
dim(BootstrapSamples)

# now calculate the means (Yc and Ym) for each of the bootstrap samples
#( the ineffficient but transparent way... best to start simple and once working
#well then make code efficient)
#initialize the vector to store the TEST-STATS
Boot.test.stat1 <- rep(0,B)
Boot.test.stat2 <- rep(0,B)
#run through a loop, each time calculating the bootstrap test.stat
# NOTE: could make this faster by writing a "function" and then
# using apply to apply it to columns of "BootSamples"

for (i in 1:B) {
  #calculate the boot-test-stat1 and save it
  Boot.test.stat1[i] <- abs(mean(BootstrapSamples[1:3,i]) - 
                              mean(BootstrapSamples[4:9,i]))
  #calculate the boot-test-stat2 and save it
  Boot.test.stat2[i] <- abs(median(BootstrapSamples[1:3,i]) - 
                              median(BootstrapSamples[4:9,i]))
}

#OBSERVED TEST STATS
test.stat1;test.stat2

#take a look at first 20 bootstrap -TEST Stats for 1 and 2
round(Boot.test.stat1[1:20],1)
round(Boot.test.stat2[1:20],1)

# let's calculate the bootstrap p-value
#Notice how we can ask R for a try/false question ( for first 20)
(Boot.test.stat1 >=test.stat1)[1:20]
(Boot.test.stat2 >=test.stat2)[1:20]
# if we ask for the mean of all those, it treats 0=FALSE, 1=TRUE
#..calculate p-value
mean(Boot.test.stat1 >=test.stat1)
# let's calculate the p-value for test statistic 2 (abs diff in medians)
mean(Boot.test.stat2 >= test.stat2)
table(d$feed)

plot(density(Boot.test.stat1),
     xlab=expression(group("|", bar(Yc)-bar(Ym),"|")))
plot
