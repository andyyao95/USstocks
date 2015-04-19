#3. One Moving Average crossover with 3% buffer.

#Function for transaction
Transaction=function(Obj,bs,date){  
  if(bs==-1){
    for(i in 1:2259){
      if(Obj[i,1]==date){
        Obj[i,2]<-Obj[i,2]+1
      }
    }
  } else if(bs==1) {
    for(i in 1:2259) {
      if(Obj[i,1]==date){
        Obj[i,3]<-Obj[i,3]+1
      }
    }
  }
  return(Obj)
}

#Create array of tickers to be analyzed
ARRAY <- stocks[ , "symbol"]
n <- length(ARRAY)

#Create profit matrix
P <- matrix(data=0, nrow=n, ncol=3)
colnames(P) <- c("Ticker","Strategy","Long")
P <- data.frame(P)

#Create transaction matrix
Trans <- matrix(data=0,nrow=2514,ncol=3)
colnames(Trans) <- c("Date","Buy","Sell")
Trans <- data.frame(Trans)

#Picking out the company "ALO"
sample_stocks <- filter(stocks, symbol == "ALO")

#Arrange the sample stocks by date, and then importing that into the transaction matrix
sample_stocks <- arrange(sample_stocks, v.date)
Trans$Date <- sample_stocks$v.date
  
  
###BELOW ARE THE CODE THAT NEEDS TO BE LOOKED AT AND CLEANED UP####

#####-------------------######
#Create time series for ticker being tested
for(x in 1:n) {
  X <- rbind(daily.1998[daily.1998$symbol==ARRAY[x],],
             daily.1999[daily.1999$symbol==ARRAY[x],],
             daily.2000[daily.2000$symbol==ARRAY[x],],
             daily.2001[daily.2001$symbol==ARRAY[x],],
             daily.2002[daily.2002$symbol==ARRAY[x],],
             daily.2003[daily.2003$symbol==ARRAY[x],],
             daily.2004[daily.2004$symbol==ARRAY[x],],
             daily.2005[daily.2005$symbol==ARRAY[x],],
             daily.2006[daily.2006$symbol==ARRAY[x],],
             daily.2007[daily.2007$symbol==ARRAY[x],])
  X <- X[order(X$v.date),]
  
  print(ARRAY[x])
  
  ROW = nrow(X)
  row = ROW-1
  
  if(ROW>(11)) {
    
    #Create moving average of length u
    mave1 = array(dim=2514)
    u = 10
    
    Z = NULL
    Y <- X[1,]
    Z[1] = 0
    
    #Implement strategy
    for(i in u:ROW) {
      mave1[i]=0
      
      #Fill in values of moving average 
      for(j in 0:(u-1)){
        mave1[i]=mave1[i]+X[i-j,4]
      }
      mave1[i]=mave1[i]/u
    }
    
    h = 0
    for(i in u:row){
      if(h==0){
        if(X[i,5]>(1.03*mave1[i])){
          Z[i] = 1
          Tran=Transaction(Tran,1,X[i,3])
          Y = rbind(Y,X[i,])
          h = 1
        } else if(X[i,5]<(.97*mave1[i])) {
          Z[i] = -1
          Tran=Transaction(Tran,-1,X[i,3])
          Y = rbind(Y,X[i,])  
          h = -1
        }
      } else if(h==-1) {
        if(X[i,5]>(1.03*mave1[i])){
          Z[i] = 1
          Tran=Transaction(Tran,1,X[i,3])
          Y = rbind(Y,X[i,])
          h = 1
        } 
      } else if(h==1) {
        if(X[i,5]<(.97*mave1[i])) {
          Z[i] = -1
          Tran=Transaction(Tran,-1,X[i,3])
          Y = rbind(Y,X[i,])  
          h = -1
        }
      }
    }
    
    Y = rbind(Y,X[ROW,])
    Z[ROW]=0
    
    Z = Z[!is.na(Z)]
    W = data.frame(Y,Z)
    
    P[x,1] = ARRAY[x]
    p=0
    if(nrow(W)>3) {
      p=100
      for (j in 2:(nrow(W)-2)) {
        p = p * (1+(W[j,4]*W[j,9]+W[j+1,4]*W[j+1,9])/W[j,4])
      }
      P[x,2] = p
      P[x,3] = 100*(1+(W[nrow(W),4] - W[1,4])/W[1,4])
    }
    assign(paste(ARRAY[x],"final",sep="."),W)
    
  }
}  