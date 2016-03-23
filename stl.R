(31-1) + (30-4) + (31-3) + (30-2) + (31-12) + 31 + (30-3)

ts3 <- data.Mar[-1]
ts4 <- data.Apr[c(-29, -28, -27)]
ts5 <- data.May[c(-1, -2, -3)]
ts6 <- data.June[c(-29,-30)]
ts7 <- data.July[c(-1:-4)]
ts8 <- data.Aug
ts9 <- data.Sep[c(-30, -29, -28)]
ts <- c(ts3, ts4, ts5, ts6, ts7, ts8, ts9)



#AR(n) = ARIMA(n,0,0)
#MA(n) = ARIMA(0,0,n)

acf(Nscore)
pacf(Nscore) #==> cutoff at lag 7
#
m1 = arima (Nscore, order = c(7,0,0)); m.1.1
acf(resid(m1))
plot(stl(Nscore[c(-1,-2)], "per"))
plot(stl(nottem, "per"))
plot(stl(nottem, s.window = 7, t.window = 50, t.jump = 1))
acf(resid(m.1.1))
    