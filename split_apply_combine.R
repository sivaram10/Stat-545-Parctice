library(gapminder)
library(tidyverse)
gapminder
mini_gap <- gapminder %>%
  filter(country %in% c("Belgium", "Canada", "United States", "Mexico") &
           year > 2000) %>%
  select(-pop, -gdpPercap) %>%
  droplevels()
mini_gap
food <- tribble(
  ~ country,    ~ food,
  "Belgium",  "waffle",
  "Canada", "poutine",
  "United States", "Twinkie"
)
food
match(x=mini_gap$country, table = food$country)
(indices <- match(x = mini_gap$country, table = food$country))
add_column(food[indices, ], x = mini_gap$country)
#Split-Apply-Combine
library(gapminder)
library(tidyverse)
#Hadley Wickham Split-Apply-Combine paper
library(plyr)
library(rlm)
#baseball dataset for plyr apply functions practice
# rbi, runs batted in, the number ofruns that the player made in the season; 
# ab, at bat or the number of times the player
faced a pitcher.
baseball
baberuth <- subset(baseball, id == "ruthba01")
baberuth <- transform(baberuth, cyear = year - min(year) + 1)
baseball <- ddply(baseball, .(id), transform, cyear = year - min(year) + 1)
baseball <- subset(baseball, ab >= 25)
xlim <- range(baseball$cyear, na.rm = T)
ylim <- range(baseball$rbi/baseball$ab, na.rm = T)
plotpattern <- function(df) {
   qplot(cyear, rbi / ab, data = df, geom = "line",
           xlim = xlim, ylim = ylim)
}


model <- function(df) {
  lm(rbi/ab ~ cyear, data = df)
}
summary(model(baberuth))$adj.r.squared
baseball["rbi/ab"] = baseball$rbi/baseball$ab
baseball <- baseball[!(is.na(baseball$`rbi/ab`)),]
bmodels <- dlply(baseball, .(id), model)
rsq <- function(x) summary(x)$r.squared
bcoefs <- ldply(bmodels, function(x) c(coef(x), rsquare = rsq(x)))
names(bcoefs)[2:3] <- c("intercept", "slope")
baseballcoef <- merge(baseball, bcoefs, by = "id")
subset(baseballcoef, rsquare > 0.99)$id
#####
#nesting

(gap_nested <- gapminder %>%
  group_by(continent, country) %>%
  nest())

gap_nested %>% View()
gap_nested[["data"]][[1]]
(fit <- lm(lifeExp ~ I(year - 1950), data = gap_nested[[1, "data"]]))
le_vs_yr <- function(df) {
  lm(lifeExp ~ I(year - 1950), data = df)
}

le_vs_yr(gap_nested[[1, "data"]])

fits <- map(gap_nested$data[1:2], le_vs_yr)
(gap_nested <- gap_nested %>% 
    mutate(fit = map(data, le_vs_yr)))
gap_nested[[1,"fit"]]
library(broom)
tidy(gap_nested$fit[[1]])
(gap_nested <- gap_nested %>%
    mutate(tidy = map(fit, tidy)))

(gap_coefs <- gap_nested %>% 
    select(continent, country, tidy) %>% 
    unnest(tidy))

(gap_coefs <- gap_coefs %>%
    mutate(term = recode(term,
                         `(Intercept)` = "intercept",
                         `I(year - 1950)` = "slope")))
(gap_ests <- gap_coefs %>% 
    select(continent:estimate) %>% 
    spread(key = term, value = estimate))

gap_ests %>% 
  select(intercept, slope) %>% 
  summary()

ggplot(gap_coefs, aes(x = estimate)) +
  geom_density() + geom_rug() + facet_wrap(~ term, scales = "free")

ggplot(gap_ests, aes(x = intercept, y = slope)) +
  geom_point() +
  geom_smooth(se = FALSE, lwd = 2)
