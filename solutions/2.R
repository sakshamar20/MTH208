fact <- 1
factorial <- function(num){
  
  if(num>1){
    fact <- num * factorial(num - 1)
  }
  else {return(fact)}
}

n <- factorial(5)
seat_r <- read.csv("seating.csv")
seat_r
print(nrow(seat_r))

cricket <- read.csv("battingbowling.csv")
cricket
head(cricket)
summary(cricket)
cricksub <- subset(cricket, cricket$Bowling < 40 & cricket$Batting > 25)
cricksub
factor(cricksub$Team)
fr <- table(cricksub$Team)
table
fr
min(fr)
class(fr)


which.min(fr)
mincat <- names(fr)[which.min(fr)]
maxcaT <- names(fr)[which.max(fr)]


?plot
plot(1:10, type = "l", xlab = "X", ylab = "y", main = "Xy Plot")

val <- 1
mathfunc <- function(num){
  val <- (1+1/num)^(num)
  return (val)
}

y <- mathfunc(1:100)
plot(1:100, mathfunc(1:100), type = "l")
abline(a = exp(1), b = 0, col = "red")
grid()
