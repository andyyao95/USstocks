
#Create a smaller frame to work with first
#testframe <- daily.1998
#length(testframe$id) -----> returns 549868

#Truncate the frame so that it only has the first 100 elements
#Now this is a good frame that we can work with
#testframe <- testframe[-c(101:549868), ]


#initializing the test.frames
testframe[,"m.sec"] <- NA
testframe[,"m.ind"] <- NA
testframe[,"top.1500"] <- NA
testframe[,"cap.usd"] <- NA


#iterating through the testframe
for (j in 1:length(testframe$id)) {
 
  #iterating through the yearly.data
  for (q in 1:length(yearly.data$id)) {
    
    #1998
    if ((yearly.data[q, "id"] == testframe[j, "id"]) & (yearly.data[q, "year"] == "1998")) {
      testframe[j, "top.1500"] <- yearly.data[q, "top.1500"]
      testframe[j, "cap.usd"] <- yearly.data[q, "cap.usd"]     
    }
    
    
  }
  
  #iterating through the secref
  for (i in 1:length(secref$id)) {
    
      if (secref[i,"id"] == testframe[j,"id"]) {
          testframe[j, "m.sec"] <- secref[i, "m.sec"]
          testframe[j, "m.ind"] <- secref[i, "m.ind"]
      }
      
  }
}  

