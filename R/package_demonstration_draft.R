#This file contains some of the draft R code for 
#what we might want to potentially include in the vignette (rmd file)

#----------------------------------------------------#

library(lubridate)
library(dplyr)
library(tidyr)
library(ggplot2)

library(USstocks)
data(stocks)

###If we want to look at a specific stock and its performance:

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

##Example of Key Statistics
stocks %>% 
  filter(symbol == "IBM") %>%
  summarize(mean_volume = mean(volume))

stocks %>%  
  filter(symbol == "MSFT") %>%
  summarise_each(funs(mean, median), volume, volume.unadj, price, price.unadj)

###If you only want certain parts of the stock, it is very easy to do 
#with the filter() function in dplyr

stocks  %>% 
  filter(top.1500 == "TRUE", volume > 100000, year == 2000) %>%
  tbl_df

##Visualizing returns
#Notice that there are some far outliers in our dataset

stocks  %>% group_by(v.date)  %>% 
  summarize(sd_ret = sd(tret, na.rm = TRUE))  %>% 
  ggplot(aes(v.date, sd_ret)) + geom_point()

## We can use the following command to examine these outliers
x <- stocks
x <- filter(x, tret <= 40)
x  %>% 
  select(-id) %>% 
  filter(row_number(desc(tret)) < 10) %>% 
  arrange(desc(tret))

#Looking at these outliers
stocks  %>% filter(tret > 50) %>% arrange(id)

##Creating a local variable, and then we can mess around with the local variables by deleting outliers
x <- stocks
x <- filter(x, tret <= 50)
#unwanted <- filter(stocks, tret > 50)
#x <- stocks
#x <- filter(x, ! symbol %in% unwanted$symbol)

##Looking at the new standard deviation plot, we've removed a lot of outliers 
x  %>% group_by(v.date)  %>% 
  summarize(sd_ret = sd(tret, na.rm = TRUE))  %>% 
  ggplot(aes(v.date, sd_ret)) + geom_point()