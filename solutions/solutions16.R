#######################################
### Solutions to Worksheet 16
#######################################

library(rbenchmark)


# Problem 1

num1 <- numeric(length = 1e3) # 8000
object.size(num1)
num2 <- numeric(length = 1e6) # 8000000
object.size(num2)

mat1 <- matrix(runif(100*1000), nrow = 100, ncol = 1000) #8x10^5
object.size(mat1)
mat2 <- matrix(0, nrow = 100, ncol = 1000) #8x10^5
object.size(mat2)

arr <- array(0, dim = c(100,100,100)) #8x10^6
object.size(arr)


## Problem 2
n <- 1e5
p <- 1e2
# generating arbitrary data
dat <- matrix(runif(n*p), nrow = n, ncol = p)
# making csv file from data
write.csv(dat, file = "bigData.csv", row.names = FALSE)


# read the csv file just made
temp <- read.csv("bigData.csv")

# save dat
save(dat, file = "largeData.Rdata")

# load the data
load("largeData.Rdata")


## Problem 3
x <- 1:1000
benchmark(sqrt(sum(x^2)), norm(x, "2"))
# norm is slower because it is made for matrices, not vectors




## Problem 4
rho_mat_1 <- function(n, rho = .50)
{
  mat <- matrix(0, nrow = n, ncol = n)
  for(i in 1:n)
  {
    for(j in 1:n)
    {
      mat[i,j] <- rho^(abs(i-j))
    }
  }
} 

rho_mat_2 <- function(n, rho = .50)
{
  mat <- matrix(rho, nrow = n, ncol = n)
  mat <- mat^(abs(col(mat) - row(mat)))
  return(mat)
} 

benchmark(rho_mat_1(n = 10), rho_mat_2(n = 10))
benchmark(rho_mat_1(n = 100), rho_mat_2(n = 100))
benchmark(rho_mat_1(n = 1000), rho_mat_2(n = 1000), replications = 20)

## Problem 5
# log transformation is useful

stirling <- function(n)
{
  #lfactorial is log of factorial
  rtn <- lfactorial(n) - n*log(n) + n - log(2*pi*n)/2
  return(exp(rtn))
}

x <- seq(10, 1e6, length = 1e3)
y <- sapply(x, stirling)
plot(x, y, type = "l", xlab = "n", ylab = "Stirling Function")



## Problem 6
my.func2 <- function(vec)
{
  temp <- log(vec)
  return(temp/sum(temp))
}



## Problem 7
func <- function(n = 1e3)
{
  nums <- 1:(n^2)
  mat <- matrix(nums, nrow = n, ncol = n)
  means <- apply(mat, 2, mean)
  norm.means <- sqrt(sum(means^2))
  return(norm.means)
}

fast_func <- function(n = 1e3)
{
  mat <- matrix(1:(n^2), nrow = n, ncol = n)
  means <- colMeans(mat)
  norm.means <- sqrt(sum(means^2))
  return(norm.means)
}

benchmark(func(), fast_func())
