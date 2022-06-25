data(iris)
View(iris)

l <- list(a = 1:10, b = 11:20)
l

lapply(l, mean)

l <- list(a = iris$Sepal.Length, b = iris$Sepal.Width)
l

lapply(l, mean)

s <- c("SPIDERMAN","BATMAN","GODFATHER")

lapply(s, tolower)

n <- list(a = 1:5, b = seq(4,36,8), c=c(1,3,5,7))
n
lapply(n, sum)
sapply(n, sum)
x<-matrix(1:9, nrow = 3, ncol = 3)
apply(x, 1, prod)

apply(x, 2, function(y){y^2})
z<-data.frame(name= c("Akash", "Kamal", "Pradeep", "Kunal", "Aamir"), 
              age = c(21,22,23,24,25), 
              gender= c("M", "M", "M", "F", "F"))
attach(z)
tapply(age, gender, min)
tapply(age, gender, max)

              