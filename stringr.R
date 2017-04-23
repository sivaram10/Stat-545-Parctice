library(tidyverse)
library(stringr)
string1 <- "This is a string"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'
?"'"
str_length(c("a","R for data science",NA))
str_c("x","y",sep = ",")
x <- c("abc", NA)
x
str_c("|-", x, "-|")
str_c("|-",str_replace_na(x),"-|")
str_c("prefix-", c("a", "b", "c"), "-suffix")
str_c(c("x", "y", "z"))
str_c(c("x", "y", "z"),collapse = "-")
x <- c("Apple", "Banana", "Pear")
str_sub(x,1,3)
str_sub(x,-3,-1)
str_sub("a", 1, 5)
str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
str_to_upper(c("i", "ı"))
str_to_upper(c("i", "ı"), locale = "tr")
x <- c("apple", "eggplant", "banana")
str_sort(x, locale = "en")
str_sort(x, locale = "haw")
x <- c("a","b","c")
length(x)
EG1 <- function(x){
  if (length(x) == 0){
    print("No string")
  }
  if (length(x) == 1){
    print(x)
  }
  if (length(x) == 2){
    print(str_c(x, collapse = ", and "))
  }
  if (length(x) > 2){
    print(str_c(c(str_c(x[1:length(x)-1], collapse = ", "),x[length(x)]),
          collapse=", and "))
  }
}
x <- c("apple","banana","pear")
str_view(x,"an")
str_view(x,".a.")
dot <- "\\."
writeLines(dot)
str_view(c("abc","a.c","bef"),"a\\.c")
x <- "a\\b"
writeLines(x)
str_view(x,"\\\\")
x <- c("apple","banana","pear")
str_view(x,"^a")
str_view(x,"a$")
x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")
str_view(x, "^apple$")
x <- "$^$"
str_view(x,"\\$\\^\\$")

# \d: matches any digit.
# \s: matches any whitespace (e.g. space, tab, newline).
# [abc]: matches a, b, or c.
# [^abc]: matches anything except a, b, or c.

str_view(c("grey","gray"),"gr(e|a)y")
str_view(c("yellow","orange","apple"),"^(a|e|i|o|u)")
str_view(c("yellow","orange","apple"),"[^aeiou]")
str_view(c("helped","jkjeed"),"[^e]ed$")
str_view(c("quill","queen","qill"),"qu")


# ?: 0 or 1
# +: 1 or more
# *: 0 or more
x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x,"CC?")
str_view(x, "CC+")
str_view(x, 'C[LX]+')

# {n}: exactly n
# {n,}: n or more
# {,m}: at most m
# {n,m}: between n and m

str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,3}")
str_view(x, 'C{2,3}?')
str_view(x, 'C[LX]+?')
str_view(fruit, "(..)\\1", match = TRUE) #for all repeater pair of letters


str_detect(x,"[aeiou]")
"^[^aeiou]+$"
str_count(x,"a")
str_detect(c("xavier","latex","taxi"),"^x|x$")
colours <- c("red", "orange", "yellow", "green", "blue", "purple")
colour_match <- str_c(colours, collapse = "|")
str_extract(sentences, colour_match)
str_extract_all(sentences, colour_match)
str_extract_all(sentences, colour_match, simplify = T)
str_view(sentences,"([^ ]+)")
str_view_all(sentences,"[^ ]+")
head(sentences)
str_match()
str_match_all()
str_replace()
str_replace_all()
str_split(sentences," ")
str_split(sentences,boundary("word"))
apropos("replace")
