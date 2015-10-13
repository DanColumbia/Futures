library(data.table)
library(TTR)
library(dplyr)
library(zoo)
targetGenerator <- function(priceSeries, executionWindow = 1, fixedHoldingPeriod = TRUE, holdingPeriod = 5)
{
    # fixedHoldingPeriod = FALSE to exit trade on next reverse signal, = TRUE to exit after period of holdingPeriod
    ps <- priceSeries

    ps[,date:=as.Date(dateTime)]
    
    # get time point ranking within each day
    ps[,timeIndex:=time(dateTime)]
    ps <- cbind(ps, timeInDay=ave(ps$timeIndex, ps$date, FUN=rank))
    ps[,timeIndex:=NULL]
    ps[,timeInDay:=as.numeric(timeInDay)]

    ps$executionPrice <- rollapply(ps$index, executionWindow, mean)
    if(fixedHoldingPeriod){# sell at # of holdingPeriod days later, in the morning? (WANT TO IMPLEMENT IN THE MORNING, BUT HOW???)
        ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16) - ps$executionPrice)/ps$executionPrice
    }else{
        ps$profit <- 
    }
}

