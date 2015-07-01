require(zoo)
require(lubridate)
require(data.table)
# require(sas7bdat)
require(foreign)


setwd("~/Dropbox/Personal/Futures/")
wd<-"~/Dropbox/Personal/Futures_Data/"

# F2010<-read.csv(paste(wd,"2010.csv",sep=""))
# F2011<-read.csv(paste(wd,"2011.csv",sep=""))
# F2012<-read.csv(paste(wd,"2012.csv",sep=""))
# F2013<-read.csv(paste(wd,"2013.csv",sep=""))
# 
# ft<-rbind(F2010,F2011,F2012,F2013)
# 
# ft<-data.table(ft)
# ft[,Time:=as.character(Time)]
# 
# 
# ###############daily data
# ft[,day:=as.Date(Time, "%m/%d/%Y %H:%M")]
# 
# ft_day<-ft[substr(Time,nchar(Time)-4,nchar(Time)) %in% c(" 9:16","15:15"), ]
# 

# price<-read.sas7bdat(paste0(wd,"price.sas7bdat"))

#######################################
########### read data
#######################################
price <- read.ssd(wd, "price", sascmd="C:/Program Files/SASHome/SASFoundation/9.3/sas.exe")

colnames(price)<-c("ticker","date","return","volume","open","close","bid","ask","return100","eqyFloat","closeAllAdj","tradingDay")
price<-data.table(price)

price[,date:=as.Date(date, origin="1960-01-01")]
saveRDS(price, paste0(wd, "price.RDS"))
price<-readRDS(paste0(wd, "price.RDS"))


sws <- read.ssd(wd, "sws", sascmd="C:/Program Files/SASHome/SASFoundation/9.3/sas.exe")
colnames(sws)<-c("ticker","sectorName","sectorID")
sws<-data.table(sws)
saveRDS(sws,paste0(wd,"sws.RDS"))
sws<-readRDS(paste0(wd, "sws.RDS"))



indexx <- read.ssd(wd, "indexx", sascmd="C:/Program Files/SASHome/SASFoundation/9.3/sas.exe")
colnames(indexx)<-c("ticker","date","volume","open","last","return100","return","closeAllAdj","number","tradingDay")
indexx<-data.table(indexx)

indexx[,date:=as.Date(date, origin="1960-01-01")]
saveRDS(indexx,paste0(wd,"indexx.RDS"))
indexx<-readRDS(paste0(wd, "indexx.RDS"))



industry <- read.ssd(wd, "industry", sascmd="C:/Program Files/SASHome/SASFoundation/9.3/sas.exe")
colnames(industry)<-c("ticker","industrySector","industryGroup","industrySubgroup")
industry<-data.table(industry)
saveRDS(industry,paste0(wd,"industry.RDS"))
industry<-readRDS(paste0(wd, "industry.RDS"))


#############################
######### ML on indexx dataset
#############################

indexx[,"ticker"]<-NULL
