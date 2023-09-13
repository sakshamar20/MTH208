################################
## Solutions to Worksheet 6
################################
library(rvest)

###### Question 1
# loading html
html <- read_html("https://www.iitk.ac.in/math/visitors-post-doctoral-fellow")
# names are in head2 class
name <- html %>% html_elements(".head2") %>% html_text()
name

###### Question 2
html <- read_html("https://www.imdb.com/chart/top/")

# getting a tag in titlecolumn class and the text in there
name <- html %>%  
  html_elements(".ipc-title__text") %>% 
  html_text()
name <- name[-c(1, 2)]
name <- name[1:250]

name <- sapply(1:250, function(k) strsplit(name[k], as.character(k))[[1]][2] )
name <- substring(name, 3)


###### Question 3
# Movie name is already done.

info <- html %>%
  html_elements(".sc-b85248f1-6.bnDqKN.cli-title-metadata-item") %>%
  html_text()

# Das Boot is a film that doesn't have
# a rating certificate, it is missing
# we want to replace it with an NA
clean.info <- info[1:(76*3 + 2)]
clean.info <- c(clean.info, NA)
clean.info <- c(clean.info, info[(77*3):749])

year <- clean.info[seq(1, 750, by = 3)]
year <- as.numeric(year)

# ratings information
rate.info <- html %>%
  html_elements(".ipc-rating-star.ipc-rating-star--base.ipc-rating-star--imdb.ratingGroup--imdb-rating") %>%
  html_text()
ratings <- substring(rate.info, 1, 3)
ratings <- as.numeric(ratings)

# voting information
# removing until the first bracket
votes.data <- substring(rate.info, 6)
votes.data <- gsub(")", "",  votes.data)

#len <- nchar(votes.data)

# finding if votes is in K or M
KorM <- substring(votes.data, len, len)

# Getting numbers
numbers <- substring(votes.data, 1, len-1)
numbers <- as.numeric(numbers)

# Making the vector of votes
votes <- (numbers*1000)*(KorM == "K") + (numbers*1e6)*(KorM == "M")

# Making a data.frame
movie.data <- data.frame(name, year, ratings, votes)


