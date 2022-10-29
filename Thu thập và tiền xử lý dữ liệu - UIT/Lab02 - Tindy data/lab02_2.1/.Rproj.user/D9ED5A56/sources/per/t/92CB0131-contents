rm(list=ls())

myFiles <- list.files(path="dataset/", pattern="data-")

k <- TRUE
for (f in myFiles){
  if (k==TRUE){
    file <- read.csv(paste("dataset/", f, sep=""), sep="\t",header = FALSE)
    k = FALSE
  }
  else{
    file <- rbind(file, read.csv(paste("dataset/", f, sep=""), sep="\t", header = FALSE))
  }
}
dataset <- file

variables <- c("Date", "Time", "Code", "Value")

colnames(dataset) <- variables

write.csv(dataset, file = "diabet.csv",row.names = FALSE )




