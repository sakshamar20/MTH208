#######################################
### Solutions to Worksheet 16
#######################################
library(profvis)
library(rbenchmark)
library(imager)


## Problem 1
profvis({
  attempts <- function(age)
  {
    count <- 0
    remain <- age # age no. of candles remain in the beginning
    while(remain > 0)
    {
      count <- count + 1
      # randomly choose any number between 1 and remain
      blow_out <- sample(1:remain, size = 1)
      remain <- remain - blow_out
    }
    return(count)
  }
  att_vec <- replicate(1e4, attempts(25))
})
# Replicate calls function sapply in the background.


## Problem 2
attempts <- function(age)
{
  count <- 0
  remain <- age # age no. of candles remain in the beginning
  while(remain > 0)
  {
    count <- count + 1
    # randomly choose any number between 1 and remain
    blow_out <- sample(1:remain, size = 1)
    remain <- remain - blow_out
  }
  return(count)
}

reps <- 1e3
benchmark(replicate(reps, attempts(25)),
  {  
    att_vec <- numeric(length = reps)
  for(i in 1:reps)
  {
    att_vec[i] <- attempts(25)
  }}, 
  replications  = 100)
# Almost the same looks like


#### Problem 3
reps <- 1e4
benchmark(replicate(reps, attempts(25)),
          {  
            att_vec <- numeric(length = reps)
            for(i in 1:reps)
            {
              att_vec[i] <- attempts(25)
            }}, 
          replications  = 20)
# Almost the same looks like

#### Problem 4
reps <- 1e4
benchmark({
  att_vec <- NULL
  for(i in 1:reps)
  {
    att_vec <- c(att_vec, attempts(25))
  }},
  {  att_vec <- numeric(length = reps)
  for(i in 1:reps)
  {
    att_vec[i] <- attempts(25)
  }}, 
  replicate(reps, attempts(25)), 
  replications  = 25)


## Problem 5
n <- 1e4
m <- 1e4
A <- matrix(runif(n*m), ncol = m, nrow = n)
benchmark(colMeans(A), apply(A, 2, mean), replications = 10)
# takes some time, colMeans is ~ 15 times faster!!



## Problem 6

benchmark({
  draw <- numeric(length = 1e4)
  for(i in 1:1e4)
  {
    draw[i] <- runif(1)
  }
}, runif(1e4), replications = 20)
# without loop is MUCH faster

# Problem 7

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




