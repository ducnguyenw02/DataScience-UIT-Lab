rm(list=ls())

myfiles <- read.csv("dataset/car.data", header = FALSE, sep = ",")

variables <- c("buying", "maint", "doors", "persons","lug_boot","safety")

colnames(myfiles) <- variables

myfiles <- myfiles[1:length(myfiles) - 1]

write.csv(myfiles, file = "car.csv", row.names = FALSE)


