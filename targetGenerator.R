library(data.table)
library(TTR)
targetGenerator <- function(priceSeries, executionWindow = 1, holdingPeriod = 5)
{
    ps <- priceSeries
    ps[,curTimeIndex:=time(dateTime)]
    ps$inPrice <- rollapply(ps$index, executionWindow, mean)
    ps$outPrice <- 
}
