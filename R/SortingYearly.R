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



#------------------------------#
########################################
#1. Sort the daily.1998 frame by company ID
library(plyr)
daily.1998 <- arrange(daily.1998, id)

#create the first index
company_id <- 1

#initializing counter
current_company <- daily.1998[1,"id"]

for (i in 1:length(daily.1998$id)) {
  
  if (daily.1998[i, "id"] != current_company) {
    company_id <- c(company_id, i)
    current_company <- daily.1998[i, "id"]
  }
  
}

#now, obtain the sorted company ids  
library(ws.data)
data(daily.1998)
y <- sort(daily.1998$id)
y <- unique(y)

byyear_1998 <- arrange(yearly_1998, id)

#just getting the correct dimensions
temp_yearly <- byyear_1998[1:length(y), ]
counter <- 1

#temp_secref is a sorted data.frame that contains ONLY the stocks that appeared in daily.1998
#print statements were used for debugging...
for (i in 1:length(x)){ #length(x)) {
  
  #check if the IDs match  
  if (x[i] == byyear_1998[counter, "id"]) {
    #move onto the next ID 
    temp_yearly[i, ] <- byyear_1998[counter, ]
    counter <- counter + 1 
  }
  
  else {
    while(x[i] != byyear_1998[counter, "id"]){
      counter <- counter + 1 
    }
    
    temp_yearly[i, ] <- byyear_1998[counter, ]
    counter <- counter + 1 
  }
}

#final_1998 <- daily.1998
final_1998["cap.usd"] <- ""
final_1998["top.1500"] <- ""

#Check for NA? 
for (i in 1:length(company_id)) {
  
  if (i != length(company_id)) {
    #fix out of index error at the end
    final_1998[c(company_id[i]: company_id[i+1]-1), "cap.usd"] <- temp_yearly[i, "cap.usd"]
    final_1998[c(company_id[i]: company_id[i+1]-1), "top.1500"] <- temp_yearly[i, "top.1500"]
  }
  
  #fixed
  else {
    final_1998[c(company_id[i]: length(final_1998$id)), "cap.usd"] <- temp_yearly[i, "cap.usd"]
    final_1998[c(company_id[i]: length(final_1998$id)), "top.1500"] <- temp_yearly[i, "top.1500"]
    
  }
  
}

################################################################