library(rvest)
library(tidyverse)

html <- read_html('https://en.wikipedia.org/wiki/United_States_at_the_Olympics')
tbl <-html_table(html)
class(tbl)
tbl <- tbl[[18]]
tbl
tbl<- rename_all(tbl,~ gsub("United States", "New Name", .))
tbl
tbl <- rename(tbl, Gold = "United States")
names(tbl) <- make.unique(dput(names(tbl)))
nn <- c('1','2','3','4','5','6','7','8')
tbl<- tbl %>% rename_with(~nn)
tbl <-tbl[,-c(7,8)]
tbl
n <- tbl[1,]
n <- as.character(n)
n
tbl<- tbl %>% rename_with(~n)
tbl<- tbl %>% slice(2:23)
tbl
tbl <- filter(!is.na(Gold))

tbl <- tbl %>%
  filter(Gold != "Did not participate")
