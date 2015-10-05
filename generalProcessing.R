library(data.table)

df <- read.csv("~/Dropbox/StratData/zz300_15.csv")
df <- data.table(df)
setnames(df, "date", "dateTime")
df[,dateTime:=as.POSIXct(dateTime, format="%m/%d/%Y %H:%M", tz="Asia/Shanghai")]
df[,dow:=weekdays(dateTime)]
df[,date:=as.Date(dateTime)]