library(tidyverse)
library(rvest)
html <- read_html("https://www.iitk.ac.in/math/visitors-post-doctoral-fellow")
name <- html_elements(html,'.head2')
name <- html_elements(name, 'a')
name <- html_text(name)
name


html <- read_html("https://www.imdb.com/chart/top/")
name_mov <- html_elements(html, '.ipc-title__text')
name <- html_text(name_mov)
name
name <- name[grep("^[0-9]", name)]
name
name <- gsub("^[0-9.]+ ","", name)

name
metadata <- html_elements(html, '.sc-b85248f1-5.kZGNjY.cli-title-metadata')
metadata <- html_text(metadata)
metadata

year <- substr( metadata , start = 1 , stop = 4 )
year

rating <-sapply(metadata, function(k) strsplit(k, split = 'm')[[1]][2] )
rating

data <- data.frame(name = name, year = year, rating = rating)
data


rates <- html %>% html_elements('.sc-e3e7b191-0.iKUUVe.sc-b85248f1-2.wTpct.cli-ratings-container') %>% html_text()
rates

rate <- substr(rates, start = 1, stop = 3)
rate

votes <- substr(rates , start = gregexpr("\\(", rates)[[1]][1]+1, stop = gregexpr("\\)", rates)[[1]][1]-1)

votes

vote <- sapply(rates, function(k) substr(k, start = gregexpr("\\(", k)[[1]][1]+1, stop = gregexpr("\\)", k)[[1]][1]-1))

data <- data.frame(name = name, year = year, Certification= rating, Rating = rate, Votes = vote)