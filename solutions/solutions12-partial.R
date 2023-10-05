####################################
## Partial Solutions for Worksheet 12
####################################

## Problem 1

# set your working repository correctly
movies <- read.csv("movie_unweighted.csv")
head(movies)  # data is called dat

## Problem 2a
hist(movies$ratings, main = "Histrogram of Ratings",
     xlab = "Ratings")

## 2b
hist(movies$ratings, main = "Histrogram of Ratings",
     xlab = "Ratings", col = "white")


## 2c
par(mfrow = c(1,2))
hist(movies$ratings, main = "Ratings",
     xlab = "Ratings", xlim = c(7.5, 10))
hist(movies$unweighted, main = "Unweighted Ratings",
     xlab = "Unweighted Ratings", xlim = c(7.5, 10))

# Both are positively skewed


## 2c (vi)
par(mfrow = c(1,2))
hist(movies$ratings, main = "Ratings",
     xlab = "Ratings", xlim = c(7.5, 10))
abline(v = mean(movies$ratings), col = "blue", lty = 2,
       lwd = 2)
abline(v = median(movies$ratings), col = "red", lty = 3,
       lwd = 2)
legend("topright", legend = c("sample mean", "sample median"),
       col = c("blue", "red"), lty = c(2,3), lwd = 2)


hist(movies$unweighted, main = "Unweighted Ratings",
     xlab = "Unweighted Ratings", xlim = c(7.5, 10))
abline(v = mean(movies$unweighted), col = "blue", lty = 2,
       lwd = 2)
abline(v = median(movies$unweighted), col = "red", lty = 3,
       lwd = 2)
legend("topright", legend = c("sample mean", "sample median"),
       col = c("blue", "red"), lty = c(2,3), lwd = 2)

## modal class for Ratings is 8-8.2
## modal class for Unweighted is also 8-8.2


# Question 2e
var(movies$ratings)
var(movies$unweighted)
