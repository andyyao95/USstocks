library(ws.data)
library(dplyr)
library(lubridate)

#1. Making a daily data set that includes all of 1998-2007

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
stocks <- left_join(stocks, temp_secref, by = "id")

#3. Using lubridate to create a year variable in stocks (from the previous v-date variable)
stocks <- mutate(stocks, year = year(ymd(v.date)))

#4. Now, we simply merge the information from yearly onto the final frame
data(yearly)
temp_yearly <- select(yearly, id, cap.usd, top.1500, year)
stocks <- left_join(stocks, temp_yearly, by = c("id", "year"))

#5. And voila, stocks is the final data frame which we want

#Use the following command to save the data as Rdata
#save(stocks, file = "stocks.RData")