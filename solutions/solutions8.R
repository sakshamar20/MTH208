library(rvest)
library(dplyr)


# Problem 1
html <- read_html("https://www.icc-cricket.com/rankings/womens/player-rankings/odi/batting")

dat <- html %>% html_table()
# this is equivalent
dat <- html_table(html)

# dat is a list of tables. There is only one table
# so we extract the first one
batting <- dat[[1]]

# You can do the following to fix the first column
# this is what I did in class. 
# However, there are some same rankings, so this 
# is not completely accurate
# batting$Pos <- 1:100

# But let's do something else
temp <- batting$Pos
extract <- sapply(1:100, function(t) strsplit(temp[t], "\n")[[1]][1])

# There are some "=" in extract
# this means that two players have the same rank
# So we want to replace the "=" with the rank right before it
for(i in 1:100)
{
  if(extract[i] == "=")
  {
    extract[i] = extract[i-1]
  }
}

# Assign back to the column of the dataset
batting$Pos <- as.numeric(extract)

## Problem 2
class(batting)  # already a tibble


## Problem 3
# go through the link on your own

## Problem 4
# Let's load the dataset
data(mtcars)
head(mtcars)  # look at the data
?mtcars  # search for information on data


## Problem 5
# making a grouped tibble by cylinder
by_cyl <- mtcars %>% group_by(cyl)

# summarizing with table of average disp and horsepower
by_cyl %>% summarise(
  avg_disp = mean(disp),
  avg_hp = mean(hp)
)


## Problem 6
# (a) ranking of all players
india <- batting %>% filter(Team == "IND")
india %>% summarise(n = n())

# (b) number in each team
by_country <- batting %>% group_by(Team)
by_country %>% summarize(number = n())

# (c) average rank
by_country %>% summarise(average.rank = mean(Pos))

# (d) in order from lowest ranking to highest
by_country %>% 
  summarise(average.rank = mean(Pos)) %>%
  arrange(desc(average.rank))


## Problem 7
# Making a function that allocates
# "Asia" to Asian teams
# and "Not Asia" to other teams
asia <- function(team)
{
  k <- length(team)
  cont <- numeric(length = k)
  for(i in 1:k)
  {
    if( sum(team[i]  == c("SL", "IND", "PAK", "THA", "BAN") ) > 0)
    {
      cont[i] <- "Asia"
    } else{
      cont[i] <- "Not Asia"
    }
  }
  return(cont)
}

# using mutate to add a new column
# the new column will be called "continent"
# and will be made with function asia() applied on Team
asia_batting <- batting %>% mutate(continent = asia(Team))
by_continent <- asia_batting %>% group_by(continent) 

# (a) how many Asia/Non-Asia players
by_continent %>% summarise(n = n())

# (b) Average Rating
by_continent %>% summarise(Rating = mean(Rating)) %>% arrange(desc(Rating))
 

