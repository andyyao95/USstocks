#This file contains some of the draft R code for 
#what we might want to potentially include in the vignette (rmd file)

#----------------------------------------------------#

library(lubridate)
library(dplyr)
library(tidyr)
library(ggplot2)

library(USstocks)
data(stocks)

###If we want to look a specific stock and its performance:

#all of the years
filter(stocks, symbol == "MSFT")

#the year 2002
filter(stocks, symbol == "MSFT", year == 2002)
stocks %% filter(symbol == "MSFT", year == 2002)


###Chaining with the %>% operator from dplyr

stocks %>%
  filter(symbol == "IBM") %>%
  arrange(v.date) %>%
  ggplot() + geom_point(aes(x = v.date, y = price.unadj, shape = "price unadjusted", colour = "price unadjusted")) + geom_point(aes(x = v.date, y = price, shape = "price", colour = "price")) 






