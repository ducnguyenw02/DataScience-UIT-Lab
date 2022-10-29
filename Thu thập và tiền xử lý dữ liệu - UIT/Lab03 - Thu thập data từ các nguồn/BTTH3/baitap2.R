rm(list=ls())
library(httr)
library(xml2)
library(dplyr)
library(data.table)
library(tidyr)
library(stringr)
library(jsonlite)
library(anytime)
library(lubridate)

link <-"https://samples.openweathermap.org/data/2.5/forecast/hourly?zip=70000&appid=b6907d289e10d714a6e88b30761fae22"
api <- GET(link)
content <- content(api)
json_content <- toJSON(content)
# doc du lieu dang json
data <- fromJSON(json_content, flatten = TRUE)
#data2 <- fromJSON(json_content, flatten = FALSE)
dataset <- as.data.frame(data['list'])
# chuyen nhet do tu do F sang do C
convert_to_censius <- function(temp) {
  return(temp - 273.15)
}
# chuyen timestamp to date
convert_timestamp_to_date <- function(time) {
  return(anytime(time))
}

# chuyen nhiet do tu do K sang do C
dataset$list.main.temp = lapply(dataset$list.main.temp, 
                                convert_to_censius)

# sap xep theo thoi gian tang dan
dataset$list.dt <- as.numeric(dataset$list.dt)
dataset <- dataset[order(dataset$list.dt), ]
dataset$list.dt <- as_datetime(anytime(dataset$list.dt))

# Câu 1.  Vẽ biểu đồ áp suất không khí (pressure) theo từng ngày

plot(dataset$list.dt, y=dataset$list.main.pressure, type="o", 
     main="Pressure", labels = FALSE)
axis.POSIXct(1, at=anytime(dataset$list.dt), format="%Y-%m-%d %H:%M:%S", origin="1970-01-01 00:00:00", 
             labels=TRUE)

# Câu 2. Vẽ biểu đồ tốc độ gió (wind speed) theo từng ngày 
plot(dataset$list.dt, y=dataset$list.wind.speed, type="o", 
     main="Wind speed", labels = FALSE)
axis.POSIXct(1, at=anytime(dataset$list.dt), format="%Y-%m-%d %H:%M:%S", origin="1970-01-01 00:00:00", 
             labels=TRUE)







