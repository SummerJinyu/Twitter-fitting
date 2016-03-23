#generate S&P 500
SP = read.table(file = "SP500.txt", header = TRUE)
value = SP$VALUE #raw S&P500 data within required time range
weekend = which(value==0)
stock = value[-weekend]           #length = 144
#check length:
length(stock)
