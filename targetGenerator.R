library(data.table)
library(TTR)
targetGenerator <- function(priceSeries, executionWindow = 1, fixedHoldingPeriod = FALSE, holdingPeriod = 5)
{
    # fixedHoldingPeriod = FALSE to exit trade on next reverse signal, = TRUE to exit after period of holdingPeriod
    ps <- priceSeries
    ps[,curTimeIndex:=time(dateTime)]
    ps$executionPrice <- rollapply(ps$index, executionWindow, mean)
    ps$profit <- 
}
