library(rvest)
library(tidyverse)

html <- read_html("https://bwf.tournamentsoftware.com/ranking/category.aspx?id=36352&category=473&C473FOC=&p=1&ps=100")

foo <- html %>% html_table()
foo <- foo[[1]]
foo <- foo[-101, -c(2,3,4,6)]
foo$Rank <- as.numeric(foo$Rank)

by_conf <- foo %>% group_by(Confederation)
MY.confed_summary <- by_conf %>% 
  summarize(Avg_rank = mean(Rank), number = n()) %>%
  arrange(Avg_rank)