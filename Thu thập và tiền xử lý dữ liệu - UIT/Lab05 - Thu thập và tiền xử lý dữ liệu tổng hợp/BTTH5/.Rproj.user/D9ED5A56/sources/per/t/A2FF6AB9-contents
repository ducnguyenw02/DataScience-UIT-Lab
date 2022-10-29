rm(list=ls())
library(magrittr) 
library(dplyr)
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

download.file(url, destfile = 'D:/Môn Học/HK4-DS(3)-Thu thập và tiền xử lý dữ liệu/Lab05/20521196_Nguyễn Mạnh Đức_BT5/data/human_activity.zip')

uzp <- 'D:/Môn Học/HK4-DS(3)-Thu thập và tiền xử lý dữ liệu/Lab05/20521196_Nguyễn Mạnh Đức_BT5/data/human_activity.zip'

unzip(uzp, exdir = 'D:/Môn Học/HK4-DS(3)-Thu thập và tiền xử lý dữ liệu/Lab05/20521196_Nguyễn Mạnh Đức_BT5/data/')

X_train <- read.table('D:/Môn Học/HK4-DS(3)-Thu thập và tiền xử lý dữ liệu/Lab05/20521196_Nguyễn Mạnh Đức_BT5/data/UCI HAR Dataset/train/X_train.txt')

y_train <- read.table('D:/Môn Học/HK4-DS(3)-Thu thập và tiền xử lý dữ liệu/Lab05/20521196_Nguyễn Mạnh Đức_BT5/data/UCI HAR Dataset/train/y_train.txt', col.names = c('ID'))

subject_train <- read.table('D:/Môn Học/HK4-DS(3)-Thu thập và tiền xử lý dữ liệu/Lab05/20521196_Nguyễn Mạnh Đức_BT5/data/UCI HAR Dataset/train/subject_train.txt', col.names = c('Subject'))

X_test <- read.table('D:/Môn Học/HK4-DS(3)-Thu thập và tiền xử lý dữ liệu/Lab05/20521196_Nguyễn Mạnh Đức_BT5/data/UCI HAR Dataset/test/X_test.txt')

y_test <- read.table('D:/Môn Học/HK4-DS(3)-Thu thập và tiền xử lý dữ liệu/Lab05/20521196_Nguyễn Mạnh Đức_BT5/data/UCI HAR Dataset/test/y_test.txt', col.names = c('ID'))

subject_test <- read.table('D:/Môn Học/HK4-DS(3)-Thu thập và tiền xử lý dữ liệu/Lab05/20521196_Nguyễn Mạnh Đức_BT5/data/UCI HAR Dataset/test/subject_test.txt', col.names = c('Subject'))

Features <- read.table('D:/Môn Học/HK4-DS(3)-Thu thập và tiền xử lý dữ liệu/Lab05/20521196_Nguyễn Mạnh Đức_BT5/data/UCI HAR Dataset/features.txt', col.names = c('ID', 'features'))

names(X_train) = Features$features

names(X_test) = Features$features

activity_label <- read.table('D:/Môn Học/HK4-DS(3)-Thu thập và tiền xử lý dữ liệu/Lab05/20521196_Nguyễn Mạnh Đức_BT5/data/UCI HAR Dataset/activity_labels.txt', col.names = c('ID'))

full_train <- cbind(y_train, subject_train, X_train) 

full_test <- cbind(y_test, subject_test, X_test)

full <- rbind(full_train, full_test)

names(full)

names1 <- grep("mean\\(\\)", names(full))

mean_features <- full %>% select(ID, Subject, names(full)[grep("mean\\(\\)", names(full))])

std_features <- full %>% select(names(full)[grep("std\\(\\)", names(full))])

data_mean_std <- cbind(mean_features, std_features)

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "^t", replacement = "Time domain: ")

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "^f", replacement = "Frequency domain: ")

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "mean\\(\\)", replacement = "mean value ")

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "std\\(\\)", replacement = "standard deviation value ")

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "-X", replacement = "on X axis ")

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "-Y", replacement = "on Y axis ")

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "-Z", replacement = "on Z axis ")

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "AccJerk", replacement = "acceleration jerk ")

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "Acc", replacement = "acceleration ")

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "GyroJerk", replacement = "angular velocity jerk ")

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "Gyro", replacement = "angular velocity ")

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "Mag", replacement = "magnitude ")

colnames(data_mean_std) <- sub(x = colnames(data_mean_std), pattern = "-", replacement = ", ")

tidy <- aggregate(data_mean_std[,3:68], list(data_mean_std$ID, data_mean_std$Subject), FUN = mean)

write.csv(tidy, 'D:/Môn Học/HK4-DS(3)-Thu thập và tiền xử lý dữ liệu/Lab05/20521196_Nguyễn Mạnh Đức_BT5/data/tidy_data.csv')

