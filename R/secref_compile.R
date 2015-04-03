#Create a smaller frame to work with first
#testframe <- daily.1998
#length(testframe$id) -----> returns 549868

#Truncate the frame so that it only has the first 100 elements
#Now this is a good frame that we can work with
#testframe <- testframe[-c(1001:549868), ]


#initializing the test.frames
#testframe[,"m.sec"] <- NA
#testframe[,"m.ind"] <- NA
#testframe[,"top.1500"] <- NA
#testframe[,"cap.usd"] <- NA


#INDEX LIKE THIS: testframe[1,][,"m.sec"], where testframe[1,] represents the first row


#1. Sort the daily.1998 frame by company ID
#library(plyr)
#daily.1998 <- arrange(daily.1998, id)

#create empty company id index vector
#company_id <- numeric()

#initializing counter
#current_company <- daily.1998[1,"id"]

#for (i in 1:length(daily.1998$id)) {
  
#  if (daily.1998[i, "id"] != current_company) {
#    company_id <- c(company_id, i)
#    current_company <- daily.1998[i, "id"]
#  }
#  
#}

#now, reorganize the secref so that 

x <- sort(daily.1998$id)
x <- unique(x)

secref_1998 <- arrange(secref, id)


temp_secref <- secref_1998[1:length(x), ]
counter <- 1

#THIS CODE NOW WORKS
#temp_secref is a sorted data.frame that contains ONLY the stocks that appeared in daily.1998
#print statements were used for debugging...
for (i in 1:length(x)){ #length(x)) {
  
  #check if the IDs match  
 if (x[i] == secref_1998[counter, "id"]) {
    #move onto the next ID 
    print(x[i])
    print(secref_1998[counter,"id"])
    print(i)
    print(counter)
    temp_secref[i, ] <- secref_1998[counter, ]
    counter <- counter + 1 
  }
  
  else {
    while(x[i] != secref_1998[counter, "id"]){
      counter <- counter + 1 
      print("inside while loop")
      print("i is")
      print(i)
      print("counter is")
      print(counter)
    }
    
    temp_secref[i, ] <- secref_1998[counter, ]
    counter <- counter + 1 
  }
}

#iterating through the testframe
#for (j in 1:length(testframe$id)) {
 
  #iterating through the yearly.data
 # for (q in 1:length(yearly.data$id)) {
    
    #1998
  #  if ((yearly.data[q, "id"] == testframe[j, "id"]) & (yearly.data[q, "year"] == "1998")) {
   #   testframe[j, "top.1500"] <- yearly.data[q, "top.1500"]
    #  testframe[j, "cap.usd"] <- yearly.data[q, "cap.usd"]     
    #}
    
    
#  }
  
  #iterating through the secref
#  for (i in 1:length(secref$id)) {
    
 #     if (secref[i,"id"] == testframe[j,"id"]) {
  #        testframe[j, "m.sec"] <- secref[i, "m.sec"]
   #       testframe[j, "m.ind"] <- secref[i, "m.ind"]
    #  }
     # 
#  }
#}  

