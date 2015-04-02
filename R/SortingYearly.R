library(ws.data)
data(yearly)
yearly.data <- yearly
library(plyr)

#sorting the data.frame by year
yearly.data <- arrange(yearly.data, year)


#finding the indices which separate the different years in yearly
#note: yearly.data is already sorted by year

#we make a map: 
#position 1: 1998, position 2:1999, 3:2000, 4:2001, 5:2002, 6:2003, 7:2004, 8:2005, 9:2006, 10: 2007

#empty vector
years_index <- 1 

#initial condition
current_year <- 1998 
for (i in (1:length(yearly.data$year))) {
  
  if (yearly.data[i, "year"] != current_year) {
    years_index <- c(years_index, i)
    current_year <- current_year + 1 
  }
    
}

#print(years_index)
#[1]     1  3084  6167  9250 12333 15416 18499 21582 24665 27748
#We verify this by calling "yearly.data[3084, ]" and so forth, and indeed it returns the correct indices


#--------#

#Therefore, we have this information! : 

yr_1998 <- c(1: 3083) 
yr_1999 <- c(3084: 6166)
yr_2000 <- c(6167: 9249)
yr_2001 <- c(9250: 12332)
yr_2002 <- c(12333: 15415)
yr_2003 <- c(15416: 18498)
yr_2004 <- c(18499: 21581)
yr_2005 <- c(21582: 24664)
yr_2006 <- c(24665: 27747)
yr_2007 <- c(27748: 30830) #30830 being the last one

#Now, we can split the yearly.data frame into different frames by year, which makes things easier!

#THIS IS THE FINAL PRODUCT, FROM WHICH MAKES THE FINAL PROCESS
#OF MERGING EVERYTHING INTO ONE EASIER
yearly_1998 <- yearly.data[yr_1998, ]
yearly_1999 <- yearly.data[yr_1999, ]
yearly_2000 <- yearly.data[yr_2000, ]
yearly_2001 <- yearly.data[yr_2001, ]
yearly_2002 <- yearly.data[yr_2002, ]
yearly_2003 <- yearly.data[yr_2003, ]
yearly_2004 <- yearly.data[yr_2004, ]
yearly_2005 <- yearly.data[yr_2005, ]
yearly_2006 <- yearly.data[yr_2006, ]
yearly_2007 <- yearly.data[yr_2007, ]
