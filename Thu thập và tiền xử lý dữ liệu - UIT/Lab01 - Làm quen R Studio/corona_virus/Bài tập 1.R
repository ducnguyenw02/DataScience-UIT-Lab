# --------------------------BAI THUC HANH 01------------------------------------

# a) Code l???i các ví d??? trong Ph???n 3

rm(list = ls())

coronaData <- read.csv("data/covid_19_data.csv") 

coronaData$ObservationDate <- as.Date(coronaData$ObservationDate, "%m/%d/%Y")

nrow(coronaData) 

ncol(coronaData)

head(coronaData, 10) 

names(coronaData) 

countryCorona <- coronaData['Country.Region']

maxConfirmedCases <- max(coronaData['Confirmed'])  

coronaChina <- coronaData[which(coronaData$Country.Region == 'Mainland China'),] 

maxCountryConfirmedCorona <- 
  coronaData[which(coronaData$Confirmed==maxConfirmedCases),]['Country.Region'] 

maxStateConfirmedCorona <-
  coronaData[which(coronaData$Confirmed==maxConfirmedCases),]['Province.State']

data_jan <- coronaData[which(coronaData$ObservationDate>= 
                               "2020-01-01" & coronaData$ObservationDate <= "2020-01-31"), ]

# b) D??? li???u s??? ca lây nhi???m t???i Vi???t Nam 

coronaVietnam <- coronaData[which(coronaData$Country.Region == 'Vietnam'),]

# c) In ra s??? ca lây nhi???m nhi???u nh???t t???i Vi???t Nam (S??? d???ng l???ch print() trong R)

print(max(coronaVietnam['Confirmed'])  )

# d) Tìm d??? li???u v??? s??? ca lây nhi???m t???i Vi???t Nam trong tháng 2 

data_Vietnam_2 <- coronaVietnam[which(coronaVietnam$ObservationDate >= "2021-02-01" 
                                    & coronaVietnam$ObservationDate < "2021-03-01"),]

# e) In ra s??? d??? li???u v??? ca lây nhi???m nhi???u nh???t trong tháng 01 và 02 t???i Vi???t Nam (2021)

# VietNam Thang 1 
data_Vietnam_1 <- coronaVietnam[which(coronaVietnam$ObservationDate >= "2021-01-01" 
                                      & coronaVietnam$ObservationDate < "2021-02-01"),]

max_cofirmed_Vietnam_1 <- max(data_Vietnam_1['Confirmed'])

print(max_cofirmed_Vietnam_1)

# VietNam Thang 2 
max_cofirmed_Vietnam_2 <- max(data_Vietnam_2['Confirmed'])

print(max_cofirmed_Vietnam_2)

# f) Th???c hi???n tuong t??? câu e) cho Indonesia và Philipine.

# Indonesia Thang 1 
data_Indonesia <- coronaData[which(coronaData$Country.Region == 'Indonesia'),]

data_Indonesia_1 <- data_Indonesia[which(data_Indonesia$ObservationDate >= '2021-01-01'
                                         & data_Indonesia$ObservationDate < '2021-02-01' ),]

max_cofirmed_Indonesia_1 <- max(data_Indonesia_1['Confirmed'])

print(max_cofirmed_Indonesia_1)

# Indonesia Thang 2

data_Indonesia_2 <- data_Indonesia[which(data_Indonesia$ObservationDate >= '2021-02-01'
                                           & data_Indonesia$ObservationDate < '2021-03-01' ),]

max_cofirmed_Indonesia_2 <- max(data_Indonesia_2['Confirmed'])

print(max_cofirmed_Indonesia_2)

#Philippines Thang 1 
data_Philippines <- coronaData[which(coronaData$Country.Region == 'Philippines'),]

data_Philippines_1 <- data_Philippines[which(data_Philippines$ObservationDate >= '2021-01-01' 
                                             & data_Philippines$ObservationDate < '2021-02-01' ),]

max_cofirmed_Philippines_1 <- max(data_Philippines_1['Confirmed'])

print(max_cofirmed_Philippines_1)

#Philippines Thang 2 

data_Philippines_2 <- data_Philippines[which(data_Philippines$ObservationDate >= '2021-02-01' 
                                               & data_Philippines$ObservationDate < '2021-03-01' ),]

max_cofirmed_Philippines_2 <- max(data_Philippines_2['Confirmed'])

print(max_cofirmed_Philippines_2)

# g) In ra d??? li???u v??? ca t??? vong c???a Trung Qu???c trong kho???ng th???i gian t??? 01/02/2021 cho d???n 15/02/2021. 
#    In ra màn hình s??? d???ng l???nh print().

data_MainlandChina <- coronaData[which(coronaData$Country.Region == 'Mainland China'),]

data_MainlandChina_1.2_15.2 <- data_MainlandChina[which(data_MainlandChina$ObservationDate >= '2021-02-01' 
                                                      & data_MainlandChina$ObservationDate <= '2021-02-15'),]

print(data_MainlandChina_1.2_15.2['Deaths'])

# h) D???m s??? lu???ng ca ghi nh???n theo t???ng t???nh c???a Trung Qu???c trong tháng 02/2021

data_MainlandChina_2 <- data_MainlandChina[which(data_MainlandChina$ObservationDate >= '2021-02-01' 
                                                 & data_MainlandChina$ObservationDate < '2021-03-01'),]

count_data_province_MainlandChina_2 <- table(data_MainlandChina_2$Province.State)

list_province_MainlandChina_2 <- unique(data_MainlandChina_2$Province.State)

for (i in 1:length(list_province_MainlandChina_2)){
  
  cur_data <- data_MainlandChina_2[which(data_MainlandChina_2$Province.State == list_province_MainlandChina_2[i]),]  

  min_date <- min(cur_data$ObservationDate)
  
  max_date <- max(cur_data$ObservationDate)
  
  case <- cur_data[which(cur_data$ObservationDate == max_date),]$Confirmed 
        - cur_data[which(cur_data$ObservationDate == min_date),]$Confirmed 
  
  print(paste(list_province_MainlandChina_2[i], ": ", case))
}

# k) *Có nh???n xét gì v??? s??? ca nhi???m m???i t???i Vi???t Nam gi???a tháng 05/2020 và tháng 05/2021. 

#     V??? bi???u d??? du???ng th??? hi???n s??? ca nhi???m m???i trong 2 tháng trên. 

#     G???i ý: Dùng hàm plot() trong R.

data_Vietnam_5.2020 <- coronaVietnam[which(coronaVietnam$ObservationDate >= '2020-05-01' 
                                         & coronaVietnam$ObservationDate < '2020-06-01'),]

plot(data_Vietnam_5.2020$ObservationDate, data_Vietnam_5.2020$Confirmed, type = "b" , col = 5) 

data_Vietnam_5.2021 <- coronaVietnam[which(coronaVietnam$ObservationDate >= '2021-05-01' 
                                         & coronaVietnam$ObservationDate < '2021-06-01'),]

plot(data_Vietnam_5.2021$ObservationDate, data_Vietnam_5.2021$Confirmed, type = "b" , col = 5)

# l) * V??? bi???u d??? v??? s??? ca lây nhi???m nhi???u nh???t c???a 3 qu???c gia: Vietnam, Indonesia và 
#Philippine trong tháng 01 và tháng 02 nam 2021.

Ten <- c("VN_max_1","VN_max_2", "ID_max_1", "ID_max_2", "PH_max_1", "PH_max_2")

SoLuong <- c(max_cofirmed_Vietnam_1,max_cofirmed_Vietnam_2,max_cofirmed_Indonesia_1, 
             max_cofirmed_Indonesia_2,max_cofirmed_Philippines_1, max_cofirmed_Philippines_2)

barplot(SoLuong, names.arg = Ten)











