rm(list=ls())
library(magrittr)
library(dplyr)
library(tidyr)
library(tidyverse)
library(lubridate)
# Cau 1
# a) thuc hien lai cac vi du 
data <- read.csv("corona_virus/covid_19_data.csv")

data$ObservationDate <- as.Date(data$ObservationDate, tz = "UTC", "%d/%m/%Y")
# THAO TÁC SELECT TRÊN DỮ LIỆU 

# 1. Lấy dữ liệu ở các thuộc tính bao gồm: ngày quan sát (ObservationDate), quốc gia 
# nhiễm (Country.Region), số ca dương tính (Confirmed), số ca tử vong (Deaths).
data %>% select(ObservationDate, Country.Region, Confirmed, Deaths)

# 2. Lấy dữ liệu về số ca hồi phục ở từng quốc gia, thuộc tính hiển thị gồm: ngày quan 
# sát (ObservationDate), quốc gia nhiễm (Country.Region) và số ca hồi phục 
# (Recovered).
data %>% select(ObservationDate, Country.Region, Recovered)

# 3. Tính tổng số ca dương tính: sử dụng hàm sum(), thuộc tính: Confirmed
sum(data %>% select(Confirmed))

# 4. Tương tự câu 2, nhưng lấy ra 10 dòng đầu tiên:
head(data %>% select(ObservationDate, Country.Region, Confirmed, Deaths), 10)

# THAO TÁC LỌC DỮ LIỆU VỚI FILTER: 
# 1. Lấy dữ liệu về số ca nhiễm ở Trung Quốc (Mainland China):
data %>% filter(Country.Region == "Mainland China")

# 2. Lấy dữ liệu về số ca nhiễm của Việt Nam trong tháng 03 và tháng 04.
data %>% filter(Country.Region == "Vietnam" & 
                ObservationDate >= "2020-03-01" & ObservationDate <= "2020-04-30")

# THAO TÁC THỐNG KÊ DỮ LIỆU VỚI SUMMARIES 
# 1. Thống kê dữ liệu về số ca dương tính của China: số ca dương tính trung bình, trung vị, 
# phương sai và độ lệch chuẩn.
data %>% filter(Country.Region == "Mainland China") %>% 
  summarise(
    Mean=mean(Confirmed, na.rm = TRUE), 
    Median = median(Confirmed, na.rm = TRUE),
    Variance = var(Confirmed, na.rm = TRUE),
    SD = sd(Confirmed, na.rm = TRUE)
  )

# THAO TÁC GOM NHÓM DỮ LIỆU VỚI GROUP BY 

# 1. Hiển thị dữ liệu theo từng ngày quan sát (thuộc tính ObservationDate) của Việt Nam 
# trong 2 tháng: tháng 3 và tháng 4 năm 2020.

data %>% filter(
  Country.Region == "Vietnam" & 
    ObservationDate >= "2020-03-01" & 
    ObservationDate <= "2020-04-30") %>% 
  group_by(ObservationDate)

# THAO TÁC SẮP XẾP DỮ LIỆU VỚI ARRANGE 
# 1. Hiển thị dữ liệu theo từng ngày quan sát (thuộc tính ObservationDate) của Việt 
# Nam trong 2 tháng: tháng 3 và tháng 4 năm 2020. Sắp xếp theo số ca dương tính tăng 
# dần.

data %>% filter(
  Country.Region == "Vietnam" & 
    ObservationDate >= "2020-03-01" & 
    ObservationDate <= "2020-04-30") %>% 
  group_by(ObservationDate) %>%
  arrange(Confirmed)

# 2. Tương tự như trên, nhưng sắp xếp số ca dương tính giảm dần. Để sắp xếp giảm dần 
# một thuộc tính, ta dùng thao tác: desc(<thuộc_tính>) trong hàm arrange

data %>% filter(
  Country.Region == "Vietnam" & 
    ObservationDate >= "2020-03-01" & 
    ObservationDate <= "2020-04-30") %>% 
  group_by(ObservationDate) %>%
  arrange(desc(Confirmed))

# THÊM VÀO MỘT THUỘC TÍNH MỚI SỬ DỤNG MUTATE 
# 1. Hiển thị dữ liệu theo từng ngày quan sát (thuộc tính ObservationDate) của Việt Nam 
# trong 2 tháng: tháng 3 và tháng 4 năm 2020. Sắp xếp theo số ca dương tính giảm dần.
# Thêm thuộc tính Patients = số lượng ca dương tính (Confirmed) - số ca phục hồi 
# (Recovered)
data %>% filter(
  Country.Region == "Vietnam" & 
    ObservationDate >= "2020-03-01" & 
    ObservationDate <= "2020-04-30") %>% 
  group_by(ObservationDate) %>%
  arrange(desc(Confirmed)) %>%
  mutate(Patient = Confirmed - Recovered)

# LÀM SẠCH DỮ LIỆU VỚI TIDYR
data_mt <- read.csv("mtcars/mtcars.csv")

# THAOTÁC GOM DỮ LIỆU VỚI GATHER 
gathered <- data_mt %>% gather(attribute, value, -model)

spread <- gathered %>% spread(attribute, value)

set.seed(1)
date <- as.Date('2016-01-01') + 0:14
hour <- sample(1:24, 15)
min <- sample(1:60, 15)
second <- sample(1:60, 15)
event <- sample(letters, 15)
data_mt$date <- date

fullTime <- data_mt %>%
  unite(datehour, date, hour, sep = ' ') %>%
  unite(datetime, datehour, min, second, sep = ':')

fullTime %>% 
  separate(datetime, c('date', 'time'), sep = ' ') %>% 
  separate(time, c('hour', 'min', 'second'), sep = ':')

print(data[1,])
leap_year(data$ObservationDate[1])

print(data[1,])
year(data$ObservationDate[1])

print(data[1,])
month(data$ObservationDate[1])

print(data[1,])
day(data$ObservationDate[1])

data %>% filter(Country.Region == "Vietnam" & month(ObservationDate) %in% c(1,3))

data %>% filter(Country.Region == "Vietnam" & wday(ObservationDate, label=TRUE) == "Wed")

# b) Tìm dữ liệu về số ca nhiễm của Nhật Bản từ ngày 02/3/2021 đến ngày 15/03/2021. 
# Vẽ biểu số ca nhiễm theo từng ngày. (sử dụng hàm plot)
data_NB_days <- data %>% filter(
  Country.Region == "Japan" & 
    ObservationDate >= "2021-03-02" & 
    ObservationDate <= "2021-03-15") %>% 
  group_by(ObservationDate) %>% summarise(SumConfirmed = sum(Confirmed))

plot(data_NB_days$ObservationDate,data_NB_days$SumConfirmed, 
      xlab = "Date", ylab = "SumConfirmed")

# c) Tìm dữ liệu về số ca nhiễm của Hoa Kỳ từ ngày 15/03/2021 đến ngày 15/04/2021. 
# Vẽ biểu đồ số ca nhiễm theo từng ngày (biểu đồ đường - hàm plot) và vẽ biểu đồ đếm
# số ca nhiễm được ghi nhận theo từng bang (biểu đồ cột - hàm barplot).

data_HK_days <-data %>% filter(
  Country.Region == "US" & 
    ObservationDate >= "2021-03-15" & 
    ObservationDate <= "2021-04-15") %>% 
  group_by(ObservationDate) %>% summarise(SumConfirmed = sum(Confirmed))

plot(data_HK_days$ObservationDate,data_HK_days$SumConfirmed,type = "l")

data_HK_Bang <-data %>% filter(
  Country.Region == "US" & 
    ObservationDate >= "2021-03-15" & 
    ObservationDate <= "2021-04-15") %>% 
  group_by(Province.State) %>% summarise(SumConfirmed = sum(Confirmed))

barplot(data_HK_Bang$SumConfirmed, names.arg = data_HK_Bang$Province.State)

# BÀI 2. Thống kê số ca nhiễm mới của thế giới theo từng ngày, từ tháng 02 đến tháng 
# 04 của năm 2020. Vẽ biểu đồ số ca nhiễm theo từng ngày (biểu đồ đường)

data_World_days <-data %>% filter(
    ObservationDate >= "2020-02-1" & 
    ObservationDate < "2020-05-1") %>% 
  group_by(ObservationDate) %>% summarise(SumConfirmed = sum(Confirmed))

plot(data_World_days$ObservationDate, data_World_days$SumConfirmed)

# Bài 3: Thống kê số ca nhiễm mới của Việt Nam theo từng tháng trong năm 2021. Vẽ 
# biểu đồ số ca nhiễm theo từng tháng (biểu đồ đường).

data_VN_months <-data %>% filter(
  Country.Region == "Vietnam" &
  ObservationDate >= "2021-01-1" & 
    ObservationDate < "2022-01-1")
data_VN_months$month <- months(data_VN_months$ObservationDate)

  
data_VN_months <-data_VN_months %>%  group_by(month) %>% summarise(SumConfirmed = sum(Confirmed)) %>%
  arrange(SumConfirmed)

plot(data_VN_months$SumConfirmed, type = "l")

# Bài 4. Bài 4: Thống kê số ca nhiễm mới của Việt nam theo từng thứ trong tháng 04 năm 2020

data$Thu <- wday(data$ObservationDate)

data_VN_Thu <-data %>% filter(
  Country.Region == "Vietnam" &
    ObservationDate >= "2021-04-1" & 
    ObservationDate < "2021-05-1") %>% 
  group_by(Thu) %>% summarise(SumConfirmed = sum(Confirmed)) %>%
  arrange(Thu)

# Bài 5: Hãy thống kê số ca nhiễm mới tại Việt Nam trong khoảng tháng 01 - 03/2020
# và tháng 01 - 03/2021, sử dụng tứ phân vị (dùng hàm quantile)

data_VN_1_3_2020_2021 <-data %>% filter(
  Country.Region == "Vietnam" & ((
    ObservationDate >= "2020-01-1" & 
    ObservationDate < "2020-04-1")
    |
    ObservationDate >= "2021-01-1" & 
    ObservationDate < "2021-04-1"))

# Bài 6: *Vẽ biểu đồ so sánh tổng số ca nhiễm mới của Việt nam giữa tháng 04 năm 
# 2019, tháng 04 năm 2020 và tháng 04 năm 2021.

data_VN_4_2019_2020_2021 <-data %>% filter(
  Country.Region == "Vietnam" & ((
      ObservationDate >= "2019-04-1" & 
      ObservationDate < "2019-05-1")
    |
      (ObservationDate >= "2020-04-1" & 
      ObservationDate < "2020-05-1")
    |
      (ObservationDate >= "2021-04-1" & 
      ObservationDate < "2021-05-1")))

data_VN_4_2019_2020_2021$Year <- year(data_VN_4_2019_2020_2021$ObservationDate)
data_VN_4_2019_2020_2021 <- data_VN_4_2019_2020_2021 %>% group_by(Year) %>% 
                           summarise(SumConfirmed = sum(Confirmed))

barplot(data_VN_4_2019_2020_2021$SumConfirmed, names.arg = data_VN_4_2019_2020_2021$Year)


# Bài 7: *Vẽ biểu đồ boxplot, so sánh số ca nhiễm tại Việt Nam trong khoảng tháng 01 
# - 03/2020 và tháng 01 - 03/2021.

data_VN_1_3_2020_2021$Year <- year(data_VN_1_3_2020_2021$ObservationDate)

boxplot(data_VN_1_3_2020_2021$Confirmed ~ data_VN_1_3_2020_2021$Year,
        xlab = "Year" , ylab = "Confirmed")













