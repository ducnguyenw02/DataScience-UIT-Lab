rm(list=ls())

myfiles <- read.csv("dataset/bank-full.csv", header = FALSE, sep = ";")

variables <- c("age", "job", "marital", "education","default","balance","housing","loan","contact","day","month","duration","campaign","pdays","previous","poutcome","y")

colnames(myfiles) <- variables

myfiles <- myfiles[ -c(1),]

write.csv(myfiles, file = "bankfull.csv",row.names = FALSE )


