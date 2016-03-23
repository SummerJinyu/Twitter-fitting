SP = read.table(file = "SP500.txt", header = TRUE)
value = SP$VALUE; weekend = which(value == 0); stock = value[-weekend]; length(stock)
label = numeric();
for (i in 2:length(stock)) {
  if (stock[i] - stock[i-1] > 0) {
    label[i-1] = 1
  }else{
    label[i-1] = 0
  }
}
length(label)
write.table(file = "label.txt", x = label, row.names = F)
