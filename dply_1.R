#dplyr
#filter 
#select and %>%
gap <- gapminder
gap %>% filter(country == "Canada")
my_precious <- gap %>% filter(country == "Canada")
gap %>% mutate(gdp = pop * gdpPercap)
ctib <- gap %>%
  filter(country == "Canada")
gap <- gap %>% 
  mutate(tmp = rep(ctib$gdpPercap, nlevels(country)),
         gdpPercapRel = gdpPercap / tmp,
         tmp = NULL)
gap %>%
  arrange(year, country)
gap %>%
  filter(year == 2007) %>%
  arrange(lifeExp)
gap %>%
  filter(year == 2007) %>%
  arrange(desc(lifeExp))
gap %>%
  rename(life_exp = lifeExp,
         gdp_percap = gdpPercap,
         gdp_percap_rel = gdpPercapRel)
gap %>%
  filter(country == "Burundi", year > 1996) %>%
  select(yr = year, lifeExp, gdpPercap) %>%
  select(gdpPercap, everything())
gap %>%
  group_by(continent) %>%
  summarize(n = n())
gap %>%
  group_by(continent) %>%
  tally()
gap %>%
  count(continent)
gap %>%
  group_by(continent) %>%
  summarize(n = n(),
            n_countries = n_distinct(country))
gap %>%
  group_by(continent) %>%
  summarise(avg_lifeExp = mean(lifeExp))
gap %>%
  filter(year %in% c(1952,2007)) %>%
  group_by(continent) %>%
  summarise_each(funs(mean,median), lifeExp, gdpPercap)
gap %>%
  filter(continent == "Asia") %>%
  group_by(year) %>%
  summarise(min_lifeExp = min(lifeExp), max_lifeExp = max(lifeExp))
gap %>%
  group_by(country) %>%
  select(country, year, lifeExp) %>%
  mutate(lifeExp_gain = lifeExp - first(lifeExp)) %>%
  filter(year < 1963)
gap %>%
  filter(continent == "Asia") %>%
  group_by(year) %>%
  filter(lifeExp == min(lifeExp)) %>%
  select(year, country, lifeExp)
gap %>%
  filter(continent == "Asia") %>%
  select(year, country, lifeExp) %>%
  group_by(year) %>%
  filter(min_rank(desc(lifeExp)) < 2 | min_rank(lifeExp) < 2) %>%
  arrange(year) %>%
  print(n = Inf)
gap %>%
  select(country, year, continent, lifeExp) %>%
  group_by(continent, country) %>%
  mutate(le_delta = lifeExp - lag(lifeExp)) %>%
  summarise(worst_le_delta = min(le_delta, na.rm = TRUE)) %>%
  top_n(-1, wt = worst_le_delta) %>%
  arrange(worst_le_delta)