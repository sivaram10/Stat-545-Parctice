rm(list = ls())
gc()
library(RSelenium)
library(rvest)
library(XML)
rD <- rsDriver()
remDr <- rD$client
remDr$navigate("https://www.glassdoor.com")
#remDr$getPageSource()[[1]]
#htmlParse(remDr$getPageSource()[[1]])
webElem <- remDr$findElement("class", "sign-in")
#length(webElem)
webElem$highlightElement()
webElem$clickElement()
email <- remDr$findElement(using = "name", "username")
email$highlightElement()
email$sendKeysToElement(list("***emailid***"))
remDr$setImplicitWaitTimeout(milliseconds = 10000)
password <- remDr$findElement("id", "signInPassword")
password$highlightElement()
password$sendKeysToElement(list("***password***"))
remDr$setImplicitWaitTimeout(milliseconds = 10000)
signin <- remDr$findElement("id" , "signInBtn")
signin$highlightElement()
remDr$setImplicitWaitTimeout(milliseconds = 10000)
signin$clickElement()
company <- remDr$findElement("id", "KeywordSearch")
company$highlightElement()
remDr$setImplicitWaitTimeout(milliseconds = 10000)
company$sendKeysToElement(list("pepsico"))
remDr$setImplicitWaitTimeout(milliseconds = 50000)
place <- remDr$findElement("id", "LocationSearch")
place$highlightElement()
remDr$setImplicitWaitTimeout(milliseconds = 10000)
place$clearElement()
context <- remDr$findElement("class", "context-picker")
context$highlightElement()
contextInterviews <- remDr$findElement("class", "reviews")
contextInterviews$clickElement()
context$sendKeysToElement(keys = "Enter")
context$clickElement()
button <- remDr$findElement("class", "gd-btn-mkt")
button$highlightElement()
remDr$setImplicitWaitTimeout(milliseconds = 10000)
button$clickElement()
remDr$setImplicitWaitTimeout(milliseconds = 10000)
remDr$closeall()

