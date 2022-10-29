rm(list=ls())
library(httr)
library(xml2)
library(dplyr)
library(data.table)
library(tidyr)
library(stringr)
data <-GET("https://www.worldometers.info/coronavirus/#countries")
content <- content(data, as="text")
html_data <- read_xml(content, as_html = TRUE)
table_data <- xml_text(xml_find_all(html_data,
              "//table[@id='main_table_countries_today']//tbody//tr//td"))
table_head <- xml_text(xml_find_all(html_data,
              "//table[@id='main_table_countries_today']//thead//tr//th"))
dataset <- matrix(ncol=length(table_head), nrow = 
           (length(table_data)/ length(table_head) ))
data_col = length(table_head) 
count = 1
i = 1
while(i<=length(table_data) - data_col) {
     dataset[count, ] <- c(table_data[i:(i -1 + data_col)])
     i = i + data_col;
     count = count + 1
}
dataset <- dataset[-c(237:244),]
dataset <- dataset[-c(1:8),]
dataset <- as.data.frame(dataset)
dataset <- na.omit(dataset)
names(dataset) <- c(table_head)
write.csv(dataset, "corona_data.csv")
# Câu 1. 5 quốc gia có số ca nhiễm nhiều nhất 
for (i in 1 : nrow(dataset)){
  for( j in 1 : ncol(dataset)){
      dataset[i,j] = str_replace(dataset[i,j], "," , "")
      dataset[i,j] = str_replace(dataset[i,j], "," , "")
  }
}    
dataset$TotalCases <- as.numeric(dataset$TotalCases)   
dataset$NewCases <- as.numeric(dataset$NewCases)   
dataset$TotalRecovered <- as.numeric(dataset$TotalRecovered)
for ( i in 1:5){
    print(dataset$`Country,Other`[i])
}
          
# Câu 2. Quốc gia có số ca nhiễm mới cao nhất 
a <- dataset$NewCases 
a <- order(-a)    
print(dataset$Country.Other[a[1]])

# Câu 3. Tính tỉ lệ tổng số ca bình phục trên tổng số ca nhiễm. Xác định 3 quốc gia có tỉ lệ
# bình phục cao nhất.           
Tile <- c(0)
dataset <- data.frame(dataset, Tile)         
for ( i in 1:length(a)){
  dataset$Tile[i] <- dataset$TotalRecovered[i] / dataset$TotalCases[i]
}          
b <- dataset$Tile  
b <- order(-b)    
print(dataset$Country.Other[b[1]])
print(dataset$Country.Other[b[2]])
print(dataset$Country.Other[b[3]])
