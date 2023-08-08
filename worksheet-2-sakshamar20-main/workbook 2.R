cricket <- read.csv("battingbowling.csv")
head(cricket)
summary(cricket)
str(cricket)
cricket

cricket$Batting>25
cricket(cricket$Batting.25)


players <- subset(cricket, cricket$Bowling <=40 & cricket$Batting >=25)
# batter <- subset(cricket, cricket$Batting > 25)


indices <-  cricket$Bowling <=40 & cricket$Batting >=25
cricket[indices, ]

