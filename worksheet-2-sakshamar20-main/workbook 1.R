## workplace


# problem 1
seat <- read.csv("https://dvats.github.io/assets/course/mth208/seating.csv")
head(seat,9)
tail(seat,2)
summary(seat)
str(seat)

# sum(data$Roll.no >2000000)

n_rows <- dim(seat)[1]

cmsc <- 0

for( i in 1:n_rows){
    
  if(seat$Roll.No[i]>1000000)
    {
    cmsc <- cmsc+1
  }

}

print(cmsc)
print(n_rows - cmsc)

sum(seat$Roll.No < 1000000)


