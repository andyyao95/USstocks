#AUDIT TRAIL FOR CLEANING UP WS.DATA#

library(ws.data)

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
total.daily <- rbind(
  daily.1998, daily.1999, daily.2000, daily.2001, daily.2002, daily.2003, daily.2004, daily.2005, daily.2006, daily.2007)

#saving the data
save(total.daily, file = "total.daily.RData")

#--------------------------------------------#

#2. Include the secref data.frame
data(secref)
company.id <- secref
save(secref, file = "secref.RData")

#--------------------------------------------#


#3. Cleaning up the yearly data.frame

data(yearly)
yearly.data <- yearly
library(plyr)

#sorting the data.frame by year
yearly.data <- arrange(yearly.data, year)

#saving the data
save(yearly.data, file = "yearly.data.RData")