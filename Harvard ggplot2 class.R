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

args(geom_histogram)
args(stat_bin)

p2 <- ggplot(housing, aes(x = Home.Value))
p2 + geom_histogram()
p2 + geom_histogram(stat = "bin", binwidth = 4000)

housing.sum <- aggregate(housing["Home.Value"],
                         housing["State"], FUN = mean)
rbind(head(housing.sum),tail(housing.sum))
ggplot(housing.sum, aes(x = State, y = Home.Value)) +
  geom_bar()

ggplot(housing.sum, aes(x = State, y = Home.Value)) +
  geom_bar(stat="identity")

#Exercise II

p1 <- ggplot(ed, aes(x = CPI, y = HDI)) 
p1 + geom_point()
p1 + geom_point() + geom_smooth(method = "lm")
#p1 + geom_point() + geom_line(stat = "lne")
p1 + geom_point() + geom_smooth(method = "loess")

p3 <- ggplot(housing, aes(x = State,
                          y = Home.Price.Index)) +
  theme(legend.position = "top",
        axis.text = element_text(size = 6))
(p4 <- p3 + geom_point(aes(color = Date),
                       alpha = 0.5,
                       size = 1.5,
                       position = position_jitter(width = 0.25, height = 0)))

p4 + scale_x_discrete(name = "State Abbreviation") + 
  scale_color_continuous(name = "",
                         breaks = c(1976, 1994, 2013),
                         labels = c("'76","'94","'13"))

p4 + scale_x_discrete(name = "State Abbreviation") + 
  scale_color_continuous(name = "",
                         breaks = c(1976, 1994, 2013),
                         labels = c("'76","'94","'13"),
                         low = "blue", high = "red")

p4 +
  scale_color_gradient2(name="State Abbreviation",
                        breaks = c(1976, 1994, 2013),
                        labels = c("'76", "'94", "'13"),
                        low = "blue",
                        high = "red",
                        mid = "gray60",
                        midpoint = 1994)
p1 <- ggplot(ed, aes(x = CPI,
                     y = HDI))
p1 + geom_point(aes(color = Region), alpha = 0.5) +
  scale_x_continuous(name = "Consumer Price Index") +
  scale_y_continuous(name = "Human Development Index") +
  scale_color_discrete(name = "Continent")+
  scale_color_manual(values = c("red","orange","blue","green","pink","black"))

p5 <- ggplot(housing, aes(x = Date,
                          y = Home.Value))
p5 + geom_line(aes(color = State))

p5 + geom_line() + 
  facet_wrap(~State, ncol = 10) +
  theme_linedraw()

p5 + geom_line() + 
  facet_wrap(~State, ncol = 10) +
  theme_light()

p5 + geom_line() + 
  facet_wrap(~State, ncol = 10) +
  theme_minimal() +
  theme(text = element_text(color = "turquoise"))

theme_new <- theme_bw() +
  theme(plot.background = element_rect(size = 1, color = "blue", fill = "black"),
        text=element_text(size = 12, family = "Serif", color = "ivory"),
        axis.text.y = element_text(colour = "purple"),
        axis.text.x = element_text(colour = "red"),
        panel.background = element_rect(fill = "pink"),
        strip.background = element_rect(fill = "orange"))

p5 + geom_line() + 
  facet_wrap(~State, ncol = 10) + 
  theme_new

#Making Economist graph Exercise

p1 <- ggplot(ed, aes(x = CPI,
                     y = HDI))
p1 + geom_point(aes(color = Region)) +
  theme(legend.position = "top",
        axis.text = element_text(size = 6)) +
  scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",breaks = c(1,2,3,4,5,6,7,8,9,10),labels = c("1","2","3","4","5","6","7","8","9","10")) +
  scale_y_continuous(name = "Human Development Index, 2011 (1=best)",breaks = c(0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0),labels = c("0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1.0"))
