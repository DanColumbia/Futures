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
    if(fixedHoldingPeriod){# sell at # of holdingPeriod days later, in the morning only
        ps$test<-ifelse(ps$timeInDay==1,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==2,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-1) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==3,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-2) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==4,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-3) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==5,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-4) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==6,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-5) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==7,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-6) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==8,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-7) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==9,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-8) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==10,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-9) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==11,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-10) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==12,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-11) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==13,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-12) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==14,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-13) - ps$executionPrice)/ps$executionPrice,
                    ifelse(ps$timeInDay==15,ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-14) - ps$executionPrice)/ps$executionPrice,
                    ps$profit <- 100*(lead(ps$executionPrice, holdingPeriod*16-15) - ps$executionPrice)/ps$executionPrice)
        ))))))))))))))
    }else{
        ps$profit <- 
    }
}






























# ps$exitTest<-ifelse(ps$timeInDay==1,ps$profit <- lead(ps$executionPrice, holdingPeriod*16),
# ifelse(ps$timeInDay==2,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-1),
# ifelse(ps$timeInDay==3,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-2),
# ifelse(ps$timeInDay==4,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-3),
# ifelse(ps$timeInDay==5,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-4),
# ifelse(ps$timeInDay==6,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-5),
# ifelse(ps$timeInDay==7,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-6),
# ifelse(ps$timeInDay==8,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-7),
# ifelse(ps$timeInDay==9,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-8),
# ifelse(ps$timeInDay==10,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-9),
# ifelse(ps$timeInDay==11,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-10),
# ifelse(ps$timeInDay==12,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-11),
# ifelse(ps$timeInDay==13,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-12),
# ifelse(ps$timeInDay==14,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-13),
# ifelse(ps$timeInDay==15,ps$profit <- lead(ps$executionPrice, holdingPeriod*16-14),
# ps$profit <- lead(ps$executionPrice, holdingPeriod*16-15)
# )))))))))))))))
