#------------------------------------------
#genearte Twitter Sentiment Valence
#------------------------------------------

library(tm)
library(syuzhet)
library(changepoint)
library(AnomalyDetection)
library(ggplot2)


sentiment = list() 
Nsentiment = list()
Psentiment = list()

#NRC: 
for (i in 1:length(d)) {
  if (length(d[[i]]) != 0) {
    #senti_table = get_nrc_sentiment(levels(d[[i]]$x))
    #negative_table = senti_table$negative
    #positive_table = senti_table$positive
    senti_table = get_nrc_sentiment(d[[i]])
    negative_table = senti_table$negative
    positive_table = senti_table$positive
    Nscore = mean(negative_table)
    Pscore = mean(positive_table)
    Nsentiment[[i]] = Nscore
    Psentiment[[i]] = Pscore
    #***-----------------------------
    #scores = get_sentiment((d[[i]]), method = c("nrc"))
    #score = mean(scores)
    #sentiment[[i]] = score
  }
}


#----------------------------------Plot---------------------------------------------------------------
Pscore = as.numeric(Psentiment)
Nscore = as.numeric(Nsentiment)
Oscore = Pscore - Nscore #also == Pscore - Nscore 
range = c (min(Oscore, Pscore, Nscore), max(Oscore, Pscore, Nscore))
#Check length
length(Pscore)
#-----------------Generate file with weekend days-----------------------------------------------------
write.csv(x = cbind(Pscore, Nscore, Oscore), row.names = F, file = "valence.txt")
#-----------------Generate file without weekend days--------------------------------------------------
eliminate = weekend - 1
write.csv(x = cbind(Pscore, Nscore, Oscore)[-eliminate, ], row.names = F, file = "valence_without_weekend.txt" )
#------------------------------------------------------------------------------------------------------



cbind(Pscore, Nscore, Oscore)[-weekend]


#------------------------------------Plot----------------------------------------
plot(Oscore, type = 'l', ylim = range, col = "#3c78d8", main = "Syuzhet Package")
lines(as.numeric(Nsentiment), col = "#cc0000")
lines(as.numeric(Psentiment), col = "#639d49")
legend( "bottomright", col = c("#3c78d8",  "#cc0000", "#639d49"),lty = c(1,1,1),legend = c("overall score", "positive score", "negative score"))

#----------------------------------Detection-------------------------------------
plot(index, main = "S&P500", type = "l" )
points(which(index==2067.64), 2067.64, col = "red", pch = 16)#140
#points(which(index==1867.61), 1867.61, col = "red", pch = 16)#
points(which(index==1893.21), 1893.21, col = "red", pch = 16)
points(which(index==2057.64), 2057.64, col = "red", pch = 16) #120
#points(which(index==2096.92), 2096.92, col = "red", pch = 16) #120



