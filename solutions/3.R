n <-rbinom( n = 1000, size = 1, prob = 0.5)
fr <- table(n)    # categorize the data
fr
fr['1']  # prints value for '1' in the table
fact <- factor(n)
fact
levels(fact)
n_0.3 <- rbinom( n = 1000, size = 1, prob = 0.3)  # creates a event with prob = 0.3
n_0.3


sample( x = 1:6, size = 1)   # prints a random value between 1 to 6 with equal prob
sample( x = 1:6, size = 3, prob = c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6)) # produces 3 outcomes from 1 to 6 with varying prob according to vectot

set.seed(2) # ensures you generate same sequence of random numbers everytime
runif(2, min = 2, max = 9) # generates n = 2, numbers between max and min randomly with equal probability

# problem 2
# a
colors = c('red','green', 'blue')
color_counts = c(3,2,2)
bag = rep(colors, times = color_counts)  # creates a bag with 3 red, 2 green , 2 blue

sample( bag, size = 1) 

# b
prob_func <- function(A) {
  s <- 0
  pi_vals <- c()  # Renamed 'pi' to 'pi_vals' to avoid conflicts
  
  for (j in 1:(dim(A)[2])) {
    s <- s + norm(as.matrix(A[, j]))   # always convert the column to matrix, because norm takes a matrix in
  }
  
  for (i in 1:(dim(A)[2])) {
    pi_vals <- c(pi_vals, norm(as.matrix(A[, i])) / s)  
  }
  
  return(pi_vals)
}

p <- prob_func(A)
print(p)

print(sample(x = 1:dim(A)[1], prob = p, size = 1))
#print(rbinom(n = 100, size = 2, prob = p))


# Problem 3
store <- numeric(length = 100000)   # to define a empty vector with all zeroes

exceed <- function()
{
  count<-0
  sums <- 0
  while( sums < 1){
    sums <- sums + runif(1, min = 0, max = 1)
    count <- count+1
  }
  
  return(count)
  
}

for( r in 1:100000)
{
  store [r] <- exceed()
}

mean(store)   # average which is close to exp(1)


#Problem 4
# a

age <- 30


attempts <- function(age)
{
  count<-0
  sums <-0
  remaining <- age
  while( sums < age){
    remaining <- age-sums
    sums <- sums + sample( x = 1:remaining, size = 1)
    count <- count+1
  }
  
  return(count)
  
}

attempts(age)

vtr <- numeric(length = 1000)

for ( i in 1:1000){
  vtr [i] <- attempts(25)
}

mean(vtr)
