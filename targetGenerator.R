library(data.table)
targetGenerator <- function(priceSeries, purchaseWindow, holdingPeriod)
{
    ps <- data.table(priceSeries)
    setnames(ps, "date", "dateTime")
    ps[,dateTime:=as.POSIXct(dateTime, format="%m/%d/%Y %H:%M", tz="Asia/Shanghai")]
    ps[,time:=]
}
