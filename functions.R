mmm1 <- function(x){
  stopifnot(is.numeric(x))
  max(x) - min(x)
}

mmm1(1:10)
mmm1(gapminder$lifeExp)
mmm1(gapminder$country)
mmm1(c(TRUE,FALSE))

mmm2 <- function(x){
  if(!is.numeric(x)){
    stop("This function only works with numeric data \n",
         "You provided an object of class: ",class(x)[1])
  }
  max(x) - min(x)
}

mmm2(1:10)
mmm2(gapminder$lifeExp)
mmm2(gapminder$country)
mmm2(c(TRUE,FALSE))

boxplot(gapminder$lifeExp, plot = F)$stats
quantile(gapminder$lifeExp)
x <- quantile(gapminder$lifeExp, probs = c(0.5,0.95))

qdiff1 <- function(my_x, prob = c(0,1), na.rm = T, ...){
  stopifnot(is.numeric(my_x))
  stopifnot(is.numeric(prob) & prob <= 1)
  x <- quantile(my_x, probs = prob, ...)
  return(max(x) - min(x))
}

qdiff1(gapminder$lifeExp, c(0.5,0.95))
qdiff1(gapminder$lifeExp, c("a",0.95))
qdiff1(gapminder$lifeExp, c(1.5,0.95))


