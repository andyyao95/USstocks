#In this file, we describe in detail the steps which we took to remove the outlier in our original ws.data frame

removing_outliers <- function() {
#First, let's take a look at the standard deviation plot
stocks  %>% group_by(v.date)  %>% 
  summarize(sd_ret = sd(tret, na.rm = TRUE))  %>% 
  ggplot(aes(v.date, sd_ret)) + geom_point()

#There are these outliers with EXTREMELY high standard deviations
#Let's take a closer look at them

library(USstocks)
data(stocks)

x <- stocks 
unwanted <- x %>% filter(tret > 30)

#Looking at stock with total return (daily) > 30%
unwanted <- stocks %>% filter(tret > 30)
#getting all the companies with atleast 1 date of tret > 30%
names <- unique(unwanted$name)

#########Looking at them individually##########

#1.
x %>% filter(name == names[1]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, name != names[1])
#extremely low volume ==> REMOVE ALL


#2.
x %>% filter(name == names[2]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, (name != names[2]) | (v.date != "1998-11-24")) 
#seems like, only 1 day is an outlier, everything else is good ==> REMOVE ONLY THE OUTLIER

#3.
x %>% filter(name == names[3]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, (name != names[3]) | (v.date != "1999-05-07")) 
#seems like, only 1 day is an outlier, with unreasonably low volume ==> REMOVE ONLY THE OUTLIER

#4.
x %>% filter(name == names[4]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, (name != names[4]) | (v.date != "2002-06-07")) 
x <- filter(x, (name != names[4]) | (v.date != "2003-08-26")) 
#seems like, only 2 days are outliers, everything else is good ==> REMOVE ONLY THE OUTLIER

#5.
x %>% filter(name == names[5]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, (name != names[5]) | (v.date != "2003-01-13")) 
#seems like, only 1 day is an outlier, everything else is good ==> REMOVE ONLY THE OUTLIER

#6.
x %>% filter(name == names[6]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, (name != names[6]) | (v.date != "2003-12-04")) 
#seems like, only 1 day is an outlier, everything else is good ==> REMOVE ONLY THE OUTLIER

#7.
x %>% filter(name == names[7]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, (name != names[7]) | (v.date != "2003-07-16")) 
#seems like, only 1 day is an outlier, everything else is good ==> REMOVE ONLY THE OUTLIER

#8.
x %>% filter(name == names[8]) %>% arrange(desc(tret)) %>% head(15)
#?

#9.
x %>% filter(name == names[9]) %>% arrange(desc(tret)) %>% head(15)
#?

#10.
x %>% filter(name == names[10]) %>% arrange(desc(tret)) %>% head(15)
#?

#11.
x %>% filter(name == names[11]) %>% arrange(desc(tret)) %>% head(15)
#?

#12.
x %>% filter(name == names[12]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, (name != names[12]) | (v.date != "2004-12-16")) 
#seems like, only 1 day is an outlier, everything else is good ==> REMOVE ONLY THE OUTLIER

#13.
x %>% filter(name == names[13]) %>% arrange(desc(tret)) %>% head(15)
#seems reasonable, around march and april 2004 returns were high.

#14. 
x %>% filter(name == names[14]) %>% arrange(desc(tret)) %>% head(15)
#?

#15.
x %>% filter(name == names[15]) %>% arrange(desc(tret)) %>% head(15)
#? volume pretty high, extremely low price though


#16.
x %>% filter(name == names[16]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, name != names[16]) 
#unreasonably high returns, extreme outlier, remove all from dataset


#17.
x %>% filter(name == names[17]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, (name != names[17]) | (v.date != "2004-12-21")) 
#seems like, only 1 day is an outlier, everything else is good ==> REMOVE ONLY THE OUTLIER

#18.
x %>% filter(name == names[18]) %>% arrange(desc(tret)) %>% head(15)
#very low market cap. remove??

#19.
x %>% filter(name == names[19]) %>% arrange(desc(tret)) %>% head(15)
#very low market cap. remove??



####After we scrape our data, we re-examine our standard deviation plot. 

#original dataframe (without extreme outliers)
stocks  %>% group_by(v.date)  %>% 
  summarize(sd_ret = sd(tret, na.rm = TRUE))  %>% 
  ggplot(aes(v.date, sd_ret)) + geom_point()

#removed questionable stock listings 
x  %>% group_by(v.date)  %>% 
  summarize(sd_ret = sd(tret, na.rm = TRUE))  %>% 
  ggplot(aes(v.date, sd_ret)) + geom_point()

#the plot seems much better
#now we save the new, cleaned up data frame
}