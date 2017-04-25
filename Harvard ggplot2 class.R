#Rules for making graphs
#1. Use data.frames
#2. Use factors
#3. Be the boss of your factors
#4. Keep your data tidy
#5. reshape your data

housing <- read.csv("E:/GitHub Main/Harvard Rgraphics/dataSets/landdata-states.csv")
head(housing[1:5])
hist(housing$Home.Value)

library(ggplot2)
ggplot(housing, aes(x = Home.Value)) +
  geom_histogram()

plot(Home.Value ~ Date, data = subset(housing, State == "MA"))
points(Home.Value ~ Date, col = "red",
       data = subset(housing, State == "TX"))
legend(1975, 400000,
       c("MA", "TX"), title="State",
       col=c("black", "red"),
       pch=c(1, 1))

ggplot(subset(housing, State %in% c("MA", "TX")),
       aes(x=Date,
           y=Home.Value,
           color=State))+
  geom_point()

