rm(list=ls())

fileiris <- read.csv("dataset/iris.data", header = FALSE, sep = ",")

variables <- c("sepal length", "sepal width", "petal length", "petal width","class")

colnames(fileiris) <- variables

write.csv(fileiris, file = "iris.csv", row.names = FALSE)