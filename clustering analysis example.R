#install.packages("devtools")
#devtools::install_github("petermeissner/wikipediatrend")
#devtools::install_github("twitter/AnomalyDetection",force=T)
#install.packages("Rcpp")

library(wikipediatrend) ## Library containing API wikipedia access   
library(AnomalyDetection)
library(ggplot2)

## Download wiki webpage "fifa" 
fifa_data = wp_trend("fifa", from="2013-03-18", lang = "en")

## Plotting data
ggplot(fifa_data, aes(x=date, y=count, color=count)) + geom_line()

## Convert date variable
fifa_data$date = as.POSIXct(fifa_data$date)

## Keep only desiered variables (date & page views)
fifa_data=fifa_data[,c(1,2)]

## Apply anomaly detection
#data_anomaly = AnomalyDetectionTs(fifa_data, max_anoms=0.01, direction="pos", plot=TRUE, e_value = T)

SP = read.table(file = "SP500.txt", header = TRUE)
date = SP$DATE[-1]
CP_positive = data.frame(date,positive)
CP_positive$date = paste(as.character(CP_positive$date), rep("01:00:00", length(date)),sep=" ")
CP_positive$date = as.POSIXct(CP_positive$date)
data_anomaly_positive = AnomalyDetectionTs(CP_positive, max_anoms=0.01, direction="pos", plot=TRUE, e_value = T)

SP = read.table(file = "SP500.txt", header = TRUE)
date = SP$DATE[-1]
CP_negative = data.frame(date,negative)
CP_negative$date = paste(as.character(CP_negative$date), rep("01:00:00", length(date)),sep=" ")
CP_negative$date = as.POSIXct(CP_negative$date)
data_anomaly_negative = AnomalyDetectionTs(CP_negative, max_anoms=0.01, direction="pos", plot=TRUE, e_value = T)

stock_alldata = read.table("SP500_CP.txt", header = TRUE)
stock_data = stock_alldata[-which(stock_alldata$VALUE == stock_alldata$VALUE[25]), ]
date = stock_data$DATE
stock = as.numeric(as.character(stock_data$VALUE))
CP_stock = data.frame(date, stock)
CP_stock$date = paste(as.character(CP_stock$date), rep("01:00:00", dim(CP_stock)[1]),sep=" ")
CP_stock$date = as.POSIXct(CP_stock$date)
data_anomaly_stock = AnomalyDetectionTs(CP_stock, max_anoms=0.01, direction="pos",plot=TRUE, e_value = T, verbose=T)





jpeg("03_fifa_wikipedia_term_page_views_anomaly_detection.jpg", width= 8.25, height= 5.25, units="in", res=500, pointsize = 4)
## Plot original data + anomalies points
data_anomaly$plot
dev.off()


## Calculate deviation percentage from the expected value 
data_anomaly$anoms$perc_diff=round(100*(data_anomaly$anoms$expected_value-data_anomaly$anoms$anoms)/data_anomaly$anoms$expected_value)

## Plot anomalies table
anomaly_table=data_anomaly$anoms

