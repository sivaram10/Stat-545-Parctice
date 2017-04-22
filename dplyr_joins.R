suppressPackageStartupMessages(library(dplyr))
library(readr)

superheroes <- "
name, alignment, gender,         publisher
Magneto,       bad,   male,            Marvel
Storm,      good, female,            Marvel
Mystique,       bad, female,            Marvel
Batman,      good,   male,                DC
Joker,       bad,   male,                DC
Catwoman,       bad, female,                DC
Hellboy,      good,   male, Dark Horse Comics
"
superheroes <- read_csv(superheroes, trim_ws = TRUE, skip = 1)

publishers <- "
publisher, yr_founded
DC,       1934
Marvel,       1939
Image,       1992
"
publishers <- read_csv(publishers, trim_ws = TRUE, skip = 1)

superheroes
publishers
inner_join(superheroes,publishers)
inner_join(publishers,superheroes)
semi_join(superheroes,publishers) #semi_join(x, y): Return all rows from x where there are matching values in y, keeping just columns from x. A semi join differs from an inner join because an inner join will return one row of x for each matching row of y, where a semi join will never duplicate rows of x. This is a filtering join.
semi_join(publishers,superheroes)
left_join(superheroes,publishers)
right_join(superheroes,publishers)
anti_join(superheroes,publishers) #anti_join(x, y): Return all rows from x where there are not matching values in y, keeping just columns from x. This is a filtering join.
anti_join(publishers,superheroes)
full_join(superheroes, publishers)
full_join(publishers,superheroes)
sessionInfo()
