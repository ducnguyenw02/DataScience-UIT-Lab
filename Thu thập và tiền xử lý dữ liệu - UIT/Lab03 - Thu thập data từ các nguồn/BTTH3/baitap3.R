rm(list=ls())
library(gsheet)
library(stringr)
link_patien <-"https://docs.google.com/spreadsheets/d/1XEFg047aSbg3OsEVx9PzmgSxGbCvCidfLiHfsgRS3R0/edit?usp=sharing"

dataset <- gsheet2tbl(link_patien)

# Câu 1 Liệt kê số ca nhiễm theo từng thành phố (Detected City)

data_by_detected_city <- table(dataset$Detected.City)
data_by_detected_city

# Câu 2 Liệt kê số ca nhiễm theo độ tuổi, vẽ biểu đồ (sử dụng hàm plot).

data_by_age <- table(dataset$Age.Bracket)

plot(data_by_age)

# Câu 3 Liệt kê số ca nhiễm tại Hokkaido theo từng ngày. Vẽ biểu đồ.
for (i in 1 : nrow(dataset)){
    j = 2
    dataset[i,j] = str_replace(dataset[i,j], "#" , "")
    dataset[i,j] = str_replace(dataset[i,j], "0" , "")
    dataset[i,j] = str_replace(dataset[i,j], "1" , "")
    dataset[i,j] = str_replace(dataset[i,j], "2" , "")
    dataset[i,j] = str_replace(dataset[i,j], "3" , "")
    dataset[i,j] = str_replace(dataset[i,j], "4" , "")
    dataset[i,j] = str_replace(dataset[i,j], "5" , "")
    dataset[i,j] = str_replace(dataset[i,j], "6" , "")
    dataset[i,j] = str_replace(dataset[i,j], "7" , "")
    dataset[i,j] = str_replace(dataset[i,j], "8" , "")
    dataset[i,j] = str_replace(dataset[i,j], "9" , "")
    dataset[i,j] = str_replace(dataset[i,j], "0" , "")
    dataset[i,j] = str_replace(dataset[i,j], "1" , "")
    dataset[i,j] = str_replace(dataset[i,j], "2" , "")
    dataset[i,j] = str_replace(dataset[i,j], "3" , "")
    dataset[i,j] = str_replace(dataset[i,j], "4" , "")
    dataset[i,j] = str_replace(dataset[i,j], "5" , "")
    dataset[i,j] = str_replace(dataset[i,j], "6" , "")
    dataset[i,j] = str_replace(dataset[i,j], "7" , "")
    dataset[i,j] = str_replace(dataset[i,j], "8" , "")
    dataset[i,j] = str_replace(dataset[i,j], "9" , "")
    dataset[i,j] = str_replace(dataset[i,j], "0" , "")
    dataset[i,j] = str_replace(dataset[i,j], "1" , "")
    dataset[i,j] = str_replace(dataset[i,j], "2" , "")
    dataset[i,j] = str_replace(dataset[i,j], "3" , "")
    dataset[i,j] = str_replace(dataset[i,j], "4" , "")
    dataset[i,j] = str_replace(dataset[i,j], "5" , "")
    dataset[i,j] = str_replace(dataset[i,j], "6" , "")
    dataset[i,j] = str_replace(dataset[i,j], "7" , "")
    dataset[i,j] = str_replace(dataset[i,j], "8" , "")
    dataset[i,j] = str_replace(dataset[i,j], "9" , "")
  }
dataset3 <- dataset[which(dataset$City.Patient.Number == 'Hokkaido'),]

data_hokkaido <- table(dataset$Date.Announced)
barplot(data_hokkaido)



