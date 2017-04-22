lotr_tidy <- read.table("E:/GitHub Main/Stat-545-Parctice/lotr_wordsSpoken.tsv", sep = "\t", header = TRUE)
head(lotr_tidy)
lotr_tidy <- as.tibble(lotr_tidy)
lotr_tidy %>%
  count(Race, wt = Words)
temp <- lotr_tidy %>%
  group_by(Film, Race) %>%
  summarise(Words = sum(Words, na.rm = TRUE))
p <- ggplot(temp, aes(x = Film, y = Words, fill = Race))
p + geom_bar(stat = "identity", position = "dodge") +
  coord_flip() + guides(fill = guide_legend(reverse = TRUE))

library(RCurl)
x <- getURL("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")
fship <- read.csv(text = x)
x <- getURL("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")
ttow  <- read.csv(text = x)
x <- getURL("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")
rking  <- read.csv(text = x)
lotr_tidy <- rbind(fship,ttow,rking)
lotr_tidy <- 
  gather(lotr_tidy, key = "Gender", value = "Words", Female, Male)

#Exercise
x <- getURL("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/Female.csv")
Female  <- read.csv(text = x)
x <- getURL("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/Male.csv")
Male  <- read.csv(text = x)
lotr_tidy <- rbind(Female,Male)
lotr_tidy <- 
  gather(lotr_tidy, key = "Race", value = "Words", Elf, Hobbit, Man)
lotr_tidy <- select(lotr_tidy, Film, Race, Gender, Words) %>%
  arrange(Gender,Race)
lotr_tidy
list.files()
lotr_files <- file.path(getwd(), c("The_Fellowship_Of_The_Ring.csv",
                                  "The_Two_Towers.csv",
                                  "The_Return_Of_The_King.csv"))
lotr_files
lotr_list <- lapply(lotr_files, read.csv)
do.call(rbind, lotr_list)
rbind_all(lotr_list)
library(data.table)
rbindlist(lotr_list)
library(plyr)
rbind.fill(lotr_list)
library(reshape2)
reshape2::melt(lotr_tidy, measure.vars = c("Female","Male"),
               value.name="Words")
lotr_tidy <- arrange(lotr_tidy,Gender,Film)
lotr_tidy <- as.tibble(lotr_tidy)
lotr_tidy %>%
  spread(key = Race, value = Words)
lotr_tidy %>%
  spread(key = Gender, value = Words)
lotr_tidy %>%
  unite(Race_Gender, Race, Gender) %>%
  spread(key = Race_Gender, value = Words)
