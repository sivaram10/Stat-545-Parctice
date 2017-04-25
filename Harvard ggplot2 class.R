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

hp2001Q1 <- subset(housing, Date == 2001.25)
ggplot(hp2001Q1, aes(y=Structure.Cost,
                     x=Land.Value))+
  geom_point()

ggplot(hp2001Q1, aes(y=Structure.Cost,
                     x=log(Land.Value)))+
  geom_point()

hp2001Q1$pred.SC <- predict(lm(Structure.Cost ~ log(Land.Value), data = hp2001Q1))
p1 <- ggplot(hp2001Q1, aes(x = log(Land.Value), y = Structure.Cost))
p1 + geom_point(aes(color = Home.Value)) + 
  geom_line(aes(y = pred.SC))

p1 + geom_point(aes(color = Home.Value)) + 
  geom_smooth()

p1 + geom_text(aes(label = State), size=3)

install.packages("ggrepel") 
library("ggrepel")
p1 + 
  geom_point() + 
  geom_text_repel(aes(label=State), size = 3)

p1 + geom_point(aes(color = Home.Value,
                    shape = region))

ed <- read.csv("E:/GitHub Main/Harvard Rgraphics/dataSets/EconomistData.csv")
ggplot(ed, aes(x = CPI, y = HDI, size = HDI.Rank)) + geom_point()

ggplot(ed, aes(x = CPI, y = HDI)) +
  geom_point(aes(color = Region,
                 size = HDI.Rank)) +
  geom_smooth(method = "loess")

