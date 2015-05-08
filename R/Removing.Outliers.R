#In this file, we describe in detail the steps which we took to remove the outlier in our original ws.data frame

removing_outliers <- function() {
#First, let's take a look at the standard deviation plot
stocks  %>% group_by(v.date)  %>% 
  summarize(sd_ret = sd(tret, na.rm = TRUE))  %>% 
  ggplot(aes(v.date, sd_ret)) + geom_point()

#There are these outliers with EXTREMELY high standard deviations
#Let's take a closer look at them

#library(USstocks)
#data(stocks)

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
x <- filter(x, name != names[2])
#non-existent company, filed for bankruptcy already ==> REMOVE ALL

#3.
x %>% filter(name == names[3]) %>% arrange(desc(tret)) %>% head(15)
y <- x %>% filter(name == names[3]) 
y <- x %>% arrange(v.date)
#seems ok ==> KEEP

#4.
x %>% filter(name == names[4]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, (name != names[4]) | (v.date != "2002-06-07")) 
x <- filter(x, (name != names[4]) | (v.date != "2003-08-26")) 
#seems like, only 2 days are outliers, everything else is good ==> REMOVE ONLY THE OUTLIER

#5.
x %>% filter(name == names[5]) %>% arrange(desc(tret)) %>% head(15)
y <- x %>% filter(name == names[5]) 
y %>% filter(year == 2003)
#seems okay ==> KEEP 

#6.
x %>% filter(name == names[6]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, (name != names[6]) | (v.date != "2003-12-04")) 
#seems like, only 1 day is an outlier, everything else is good ==> REMOVE ONLY THE OUTLIER

#7.
x %>% filter(name == names[7]) %>% arrange(desc(tret)) %>% head(15)
y <- x %>% filter(name == names[7])
y %>% filter(year == 2003) %>% arrange(v.date)
#seems okay ==> KEEP

#8.
x %>% filter(name == names[8]) %>% arrange(desc(tret)) %>% head(15)
y <- x %>% filter(name == names[8])
y %>% filter(year == 1998) %>% arrange(v.date) 
y %>% filter(year == 1999) %>% arrange(v.date) #healthy
y %>% filter(year == 2000) %>% arrange(v.date) #healthy
y %>% filter(year == 2001) %>% arrange(v.date) #healthy
y %>% filter(year == 2002) %>% arrange(v.date) #NO DATA
y %>% filter(year == 2003) %>% arrange(v.date) #questionable stuff happens from here on
x <- filter(x, (name != names[8]) | (year < 2002)) 
#DotCom bubble, remove all after 2002

#9.
x %>% filter(name == names[9]) %>% arrange(desc(tret)) %>% head(15)
y <- x %>% filter(name == names[9])
y %>% filter(year == 1998) %>% arrange(v.date) 
y %>% filter(year == 1999) %>% arrange(v.date) #healthy
y %>% filter(year == 2000) %>% arrange(v.date) #healthy
y %>% filter(year == 2001) %>% arrange(v.date) #healthy
y %>% filter(year == 2002) %>% arrange(v.date) #NO DATA
y %>% filter(year == 2003) %>% arrange(v.date) #questionable stuff happens from here on
x <- filter(x, (name != names[9]) | (year < 2002)) 
#DotCom bubble, remove all after 2002

#10.
x %>% filter(name == names[10]) %>% arrange(desc(tret)) %>% head(15)
y <- x %>% filter(name == names[10])
y %>% filter(year == 1998) %>% arrange(v.date) #no data!
y %>% filter(year == 1999) %>% arrange(v.date) #healthy
y %>% filter(year == 2000) %>% arrange(v.date) #healthy
y %>% filter(year == 2001) %>% arrange(v.date) #healthy
y %>% filter(year == 2002) %>% arrange(v.date) #NO DATA
y %>% filter(year == 2003) %>% arrange(v.date) #questionable stuff happens

#after cross-validating with reuters finance:
x <- filter(x, (name != names[10]) | (year < 2002)) 
#KEEP EVERYTHING BEFORE 2002


#11.
x %>% filter(name == names[11]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, (name != names[11]) | (v.date != "2003-07-29")) 
#seems like, only 1 day is an outlier, everything else is good ==> REMOVE ONLY THE OUTLIER

#12.
x %>% filter(name == names[12]) %>% arrange(desc(tret)) %>% head(15)
y <- x %>% filter(name == names[12])
y %>% filter(year == 2004) %>% arrange(v.date)
#seems OK ==> KEEP

#13.
x %>% filter(name == names[13]) %>% arrange(desc(tret)) %>% head(15)
#seems reasonable, around march and april 2004 returns were high.

#14. 
x %>% filter(name == names[14]) %>% arrange(desc(tret)) %>% head(15)
y <- x %>% filter(name == names[14]) 
y %>% filter(year == 2004) %>% arrange(v.date)
#seems reasonable ==> KEEP

#15.
x %>% filter(name == names[15]) %>% arrange(desc(tret)) %>% head(15)
y <- x %>% filter(name == names[15]) %>% filter(year == 2004)
y %>% ggplot(aes(v.date, price)) + geom_point()
y %>% ggplot(aes(v.date, volume)) + geom_point()
#seems reasonable ==> KEEP


#16.
x %>% filter(name == names[16]) %>% arrange(desc(tret)) %>% head(15)
x <- filter(x, name != names[16]) 
#unreasonably high returns for multiple days, low market cap, 
#after validating with historical data, security fraud ==> REMOVE ALL 


#17.
x %>% filter(name == names[17]) %>% arrange(desc(tret)) %>% head(15)
y <- x %>% filter(name == names[17]) 
y %>% filter(year == 1999) %>% arrange(v.date)
y %>% filter(year == 2000) %>% arrange(v.date)
y %>% filter(year == 2001) %>% arrange(v.date) #Company shut down in 2001
y %>% filter(year == 2002) %>% arrange(v.date) #NOTHING LEFT

x <- filter(x, (name != names[17]) | (year < 2002)) 
#DOTCOM BUBBLE, cross-validated with historical data ==> REMOVE ALL AFTER 2001 (when company shut down)

#18.
x %>% filter(name == names[18]) %>% arrange(desc(tret)) %>% head(15)
y <- x %>% filter(name == names[18]) 
y %>% filter(year == 1999) %>% arrange(v.date)
y %>% filter(year == 2000) %>% arrange(v.date)
y %>% filter(year == 2001) %>% arrange(v.date) 
y %>% filter(year == 2002) %>% arrange(v.date) #Company shut down in July
y %>% filter(year == 2003) %>% arrange(v.date) #Junk

x <- filter(x, (name != names[18]) | (year < 2003)) 
#DOTCOM BUBBLE, cross-validated with historical data ==> REMOVE ALL AFTER 2002 (when company shut down)

#19.
x %>% filter(name == names[19]) %>% arrange(desc(tret)) %>% head(15)
y <- x %>% filter(name == names[19]) 

y %>% filter(year == 2003) %>% arrange(v.date)
y %>% filter(year == 2004) %>% arrange(v.date) #from here on, looks suspicious
x <- filter(x, (name != names[19]) | (year < 2004)) 
#suspicious returns, trade volume, and constant market cap 
#something is wrong with the data ==> REMOVE ALL AFTER 2003 

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