library(data.table)
library(TTR)
targetGenerator <- function(priceSeries, purchaseWindow = 1, holdingPeriod = 5)
{
    ps <- priceSeries
    ps[,curTime:=time(dateTime)]
    ps$executePrice <- rollapply(ps$index, purchaseWindow, mean)
    time
}
