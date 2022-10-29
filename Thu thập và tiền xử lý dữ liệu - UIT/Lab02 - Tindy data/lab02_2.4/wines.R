rm(list=ls())

myfiles <- read.csv("dataset/wine.data", header = FALSE, sep =",")

variables <- c("class identifier","Alcohol", "Malic acid", "Ash", "Alcalinity of ash","Magnesium","Total phenols","Flavanoids","Nonflavanoid phenols","Proanthocyanins","Color intensity","Hue","OD280/OD315 of diluted wines","Proline")

colnames(myfiles) <- variables

write.csv(myfiles, file = "wine.csv", row.names = FALSE)






