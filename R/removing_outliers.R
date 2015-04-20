#Removing the outliers 

#1. Looking at stock with total return (daily) > 50%

unwanted <- stocks %>% filter(tret > 50)

#getting all the companies with atleast 1 date of tret > 50%
names <- unique(unwanted$name)

#Looking at them individually

#1. CHATHAM 
stocks %>% filter(name == "CHATHAM CORP-DE") %>% arrange(v.date) 
stocks <- filter(stocks, name != "CHATHAM CORP-DE")
#clearly, outlier, total.return in 1998, extremely low volume ==> REMOVE ALL 

#2. STRATOSPHER CORP
stocks %>% filter(name == "STRATOSPHERE CORP") %>% arrange(desc(tret)) %>% head
stocks <- filter(stocks, (name != "STRATOSPHERE CORP") | (v.date != "1998-11-24")) 
## logical OR works better because if 1st condition evaluations to true, then it doesn't need to check second condition

#seems like, only 1 day is an outlier, everything else is good ==> REMOVE ONLY THE OUTLIER


#Looking at the plot of total returns
#stocks %>% ggplot(aes(v.date, tret)) + geom_point()
#Filtering out total daily return > 50 
#stocks <- stocks %>% filter(tret <= 50)

#Alternatively: 
#unwanted <- filter(stocks, tret > 50)
#x <- stocks
#x <- filter(x, ! symbol %in% unwanted$symbol)





##Seeing highest positive daily return
## Look at the biggest positive daily return.

x  %>% 
  group_by(v.date)  %>% 
  filter(row_number(desc(tret)) == 1)  %>% 
  ggplot(aes(x = v.date, y = tret)) + geom_point()

## Then do it by m.sec

x  %>% 
  group_by(v.date, m.sec)  %>% 
  filter(row_number(desc(tret)) == 1)  %>% 
  ggplot(aes(x = v.date, y = tret)) + geom_point() + facet_wrap(~m.sec)

## Focus in on just TEC and UTL.

x  %>% 
  filter(m.sec %in% c("TEC", "UTL")) %>%
  group_by(v.date, m.sec)  %>% 
  filter(row_number(desc(tret)) == 1)  %>% 
  ggplot(aes(x = v.date, y = tret)) + geom_point() + facet_wrap(~m.sec)













accrue %>% ggplot(aes(v.date, price)) + geom_point()
> accrue %>% ggplot(aes(v.date, price.unadj)) + geom_point()
> accrue %>% ggplot(aes(v.date, tret)) + geom_point()


accrue <- stocks %>% filter(symbol == "ACRUQ")
> accrue %>% ggplot(aes(v.date, tret)) + geom_point()