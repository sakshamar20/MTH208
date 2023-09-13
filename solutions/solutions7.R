#####################################
## Solutions to Worksheet 7
# Solution partly courtesy Aditya Venkat
#####################################
library(rvest)
library(tidyverse)

# Find all top 250 movies
html <- read_html("https://www.imdb.com/chart/top/")

## First getting the advertised rating
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
# ratings information
rate.info <- html %>%
  html_elements(".ipc-rating-star.ipc-rating-star--base.ipc-rating-star--imdb.ratingGroup--imdb-rating") %>%
  html_text()
ratings <- substring(rate.info, 1, 3)
ratings <- as.numeric(ratings)


# Now the unweighted mean

links <- html %>%
  html_elements(".ipc-lockup-overlay.ipc-focusable")%>%
  html_attr("href")

# Find all codes
foo <- strsplit(links, "/")
titles <- sapply(foo, function(dum) dum[3])
# titles <- substring(links, 8, 16)
# titles[c(39, 133)] <- substring(links[c(39, 133)], 8, 17)
rate.links <- paste0("https://www.imdb.com/title/",titles, "/ratings/")

rating.vec <- NULL
unweighted <- rep(NA, 250)

# this will take time
for (i in 1:250)
{
  print(i)
  html <- read_html(rate.links[i])
  rating.link <- html %>% html_elements(".sc-32706d9c-1.dRWuAv")
  rating.link <- html_text(rating.link)
  unweighted[i] <- as.numeric(substring(rating.link, 1, 3))
}

# making a dataframe
movie.data <- data.frame(name, ratings, unweighted)
write.csv(movie.data, file = "movie_unweighted.csv", row.names = FALSE)

##### Problem 2  ####

# URL of the images
nmov <- 250
urls_img <- paste("https://www.imdb.com/title/", titles, sep = "")
# images <- character(length = nmov) # will store the vector of image locations
# for(i in 1:nmov)
# {
#   print(paste("Starting movie", i))
#   movie_html <- read_html(urls_img[i])
#   images[i] <- movie_html %>% html_element(".ipc-lockup-overlay.ipc-focusable") %>% html_attr("href")
# }

images <- character(length = nmov) # will store the vector of image locations
for(i in 1:nmov)
{
  print(paste("Starting movie", i))
  movie_html <- read_html(urls_img[i])
  images[i] <- movie_html %>% html_element(".ipc-image") %>% html_attr("src")
}



##### Problem 3  ####

# creating a function that calculates the distance from
# a given color. Code was in Worksheet 4 solutions
diff.col <- function(img, col)
{
  col.mat <- as.array(img[, , 1, ])
  dims <- dim(col.mat)
  
  # Calculate distance to given color
  dist <- matrix(0, nrow = dims[1], ncol = dims[2])
  for(i in 1:dims[1])
  {
    for(j in 1:dims[2])
    {
      # distance from the col give by user
      dist[i,j] <- norm(col.mat[i,j, ] - col, "2")
    }
  }
  # return the mean distance from color
  return(mean(dist))
}


## Now calculating distance average distance black
library(imager)
black <- numeric(length = nmov)
for(i in 1:nmov)
{
  img <- load.image(images[i])
  black[i] <- diff.col(img, col = c(0,0,0))
}

# Which movies are within .2 distance to black on average
index <- which(black < .2)
movie.data[index, ]


