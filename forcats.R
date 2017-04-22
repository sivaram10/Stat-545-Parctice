library(forcats)
library(gapminder)
str(gapminder)
str(gapminder$continent)
levels(gapminder$continent)
nlevels(gapminder$continent)

gapminder %>%
  dplyr::count(continent)

fct_count(gapminder$continent)

h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")
h_gap <- gapminder %>%
  filter(country %in% h_countries)

nlevels(h_gap$country)

h_gap %>%
  droplevels()

h_gap$country %>%
  fct_drop() %>%
  nlevels()

gapminder$continent %>%
  fct_infreq() %>%
  levels()

gapminder$continent %>%
  fct_infreq() %>%
  fct_rev() %>%
  levels()

fct_reorder(gapminder$country,gapminder$lifeExp,median) %>%
  levels() %>%
  head()

fct_reorder(gapminder$country,gapminder$lifeExp,min) %>%
  levels() %>%
  head()

fct_reorder(gapminder$country,gapminder$lifeExp, .desc = T) %>%
  levels() %>%
  head()

gap_asia_2007 <- gapminder %>% filter(year == 2007, continent == "Asia")
ggplot(gap_asia_2007, aes(x = lifeExp, y = country)) + geom_point()
ggplot(gap_asia_2007, aes(x = lifeExp, y = fct_reorder(country, lifeExp))) +
  geom_point()

h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")
h_gap <- gapminder %>%
  filter(country %in% h_countries) %>% 
  droplevels()
ggplot(h_gap, aes(x = year, y = lifeExp, color = country)) +
  geom_line()
ggplot(h_gap, aes(x = year, y = lifeExp,
                  color = fct_reorder2(country, year, lifeExp))) +
  geom_line() +
  labs(color = "country")

h_gap$country %>% levels()
h_gap$country %>% fct_relevel("Romania", "Haiti") %>% levels()

i_gap <- gapminder %>%
  filter(country %in% c("United States", "Sweden", "Australia")) %>% 
  droplevels()

levels(i_gap$country)

i_gap$country %>%
  fct_recode("USA" = "United States", "Oz" = "Australia") %>%
  levels()
