library(ws.data)
library(dplyr)
library(lubridate)

#1. Making a daily data set that includes 1998-2007

#import the data
data(daily.1998)
data(daily.1999)
data(daily.2000)
data(daily.2001)
data(daily.2002)
data(daily.2003)
data(daily.2004)
data(daily.2005)
data(daily.2006)
data(daily.2007)

#merge all the years into one frame
stocks <- rbind(
  daily.1998, daily.1999, daily.2000, daily.2001, daily.2002, daily.2003, daily.2004, daily.2005, daily.2006, daily.2007)


#2. Including the information from secref
data(secref)
temp_secref <- select(secref, id, m.sec, m.ind)
stocks <- left_join(stocks, temp_secref)

