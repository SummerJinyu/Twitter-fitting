#--------------Twitter Valence----------------
setwd("~/Documents/Courses/STAT682/Important")
valence = read.csv(file = "valence_without_weekend.txt")
Pscore = valence$Pscore
Nscore = valence$Nscore

#---------------label-------------------------
label = read.csv(file = "label.txt")

#----------------------------------------------
data = cbind(Pscore, Nscore, label); head(data)
#---------------lag---------------------------
l = length(Pscore)
#Pscore lag-------------------------
Pscore1 = c(NA, Pscore[-l])
data1 = cbind(Pscore1,data); data1
Pscore2 = c(NA, Pscore1[-l])
data2 = cbind(Pscore2,data1); data2
Pscore3 = c(NA, Pscore2[-l])
data3 = cbind(Pscore3,data2); data3
Pscore4 = c(NA, Pscore3[-l])
data4 = cbind(Pscore4,data3); data4
Pscore5 = c(NA, Pscore4[-l])
data5 = cbind(Pscore5,data4); data5
#Nscore lag-------------------------
Nscore1 = c(NA, Nscore[-l])
data6 = cbind(Nscore1,data5); data6
Nscore2 = c(NA, Nscore1[-l])
data7 = cbind(Nscore2,data6); data7
Nscore3 = c(NA, Nscore2[-l])
data8 = cbind(Nscore3,data7); data8
Nscore4 = c(NA, Nscore3[-l])
data9 = cbind(Nscore4,data8); data9
Nscore5 = c(NA, Nscore4[-l])
data10 = cbind(Nscore5,data9); data10
#Generate table 
write.csv(file = "dataset.csv", x = data10[c(-1:-5), ], row.names = F)
x = read.csv(file = "dataset.csv")


#corrlation matrix -----------------
cor(x[, 1:12])



#Difference------------------------- 
N = Nscore[-1:-4]
P = Pscore[-1:-4]
dN = c( diff (N, lag = 1)); dN
dP = c( diff(P, lag = 1)); dP
write.csv(file = "diff.csv",  x = cbind(cbind(dN, dP), x$Nscore), row.names = F)


#Label------------------------------
label = label[[1]]
l1 = length(label)
label1 = c(NA, label[-l1]); 
stock1 = cbind(label, label1);

label2 = c(NA, label1[-l1]);
stock2 = cbind (stock1, label2);

label3 = c(NA, label2[-l1]);
stock3 = cbind (stock2, label3);

label4 = c(NA, label3[-l1]);
stock4 = cbind (stock3, label4);

label5 = c(NA, label4[-l1]);
stock5 = cbind (stock4, label5)

#Generate table 
write.csv(file = "stock.csv", x = stock5[c(-1:-5), ], row.names = F)




#first-order difference---------

