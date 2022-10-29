rm(list = ls())

library(ggplot2)
library(lattice)
library(caret)
library(kernlab)
library(utils)
library(dplyr)

# Đọc dữ liệu   
human <- read.csv('Data/tidy_data.csv')
data <- human[,-2]

# Thống kê dữ liệu
label <- unique(data$Activity.1)

# Tổng quan về các thuộc tính 
summary(data)

# Phân bố dữ liệu trên từng nhãn 
percentage <- prop.table(table(data$Activity)) * 100
cbind(freq=table(data$Activity.1), percentage=percentage)

# Chia train-test: tỉ lệ 80-20
validation_index <- createDataPartition(data$Activity.,p=0.80, list=FALSE)
validation <- data[-validation_index,]
training <- data[validation_index,]

# Thiết lập cross validation 
control <- trainControl(method="cv", number=10,savePredictions = TRUE)

# Độ đo đánh giá 
metric <- "Accuracy"

# KNN
library(class)
set.seed(9)
fit.knn <- train(Activity.1~., data=training, method="knn", metric=metric, trControl=control)

# SVM
set.seed(9)
fit.svm <- train(Activity.1~., data=training,method="svmRadial", metric=metric, trControl=control)


plotConfusionMatrix <- function(cfm)
{
  plt <- as.data.frame(cfm$table)
  plt$Prediction <- factor(plt$Prediction, levels=rev(levels(plt$Prediction)))
  
  ggplot(plt, aes(x = Reference,y= Prediction, fill= Freq)) +
    geom_tile() + geom_text(aes(label=Freq)) +
    scale_fill_gradient(low="white", high="#009194") +
    labs(x = "Actual",y = "Prediction") +
    scale_x_discrete(labels=label, position = "top") +
    scale_y_discrete(labels=rev(label))
}


predictions <- predict(fit.knn, validation)
cfm_knn <- confusionMatrix(factor(predictions), factor(validation$Activity.1))
cfm_knn$overall['Accuracy']
plotConfusionMatrix(cfm_knn)


predictions <- predict(fit.svm, validation)
cfm_svm <- confusionMatrix(predictions, as.factor(validation$Activity.1))
cfm_svm$overall['Accuracy']
plotConfusionMatrix(cfm_svm)


#Random Forest (RF)
set.seed(7)
fit.rf <- train(Activity.1~., data=training, method="rf",metric=metric, trControl=control)
predictions <- predict(fit.rf, validation)
cfm_rf <- confusionMatrix(predictions, as.factor(validation$Activity.1))
cfm_rf$overall['Accuracy']
plotConfusionMatrix(cfm_rf)

#Linear Discriminant Analysis (LDA)
library(lda)
library(MASS)
library(ISLR)
set.seed(7)
fit.lda <- train(Activity.1~., data=training, method="lda", metric=metric, trControl=control)
warnings()
predictions <- predict(fit.lda, validation)
cfm_lda <- confusionMatrix(predictions, as.factor(validation$Activity.1))
cfm_lda$overall['Accuracy']
plotConfusionMatrix(cfm_lda)

results <- resamples(list(knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)

human_activity = data.frame()

for (i in 1:5) {
  set.seed(i)
  fit.knn <- train(Activity.1~., data=training, method="knn",metric=metric, trControl=control)
  predictions_1 <- predict(fit.knn, validation)
  cfm_knn <- confusionMatrix(predictions_1, as.factor(validation$Activity.1))
  human_activity[i,'KNN'] <- cfm_knn$overall['Accuracy']
  
  set.seed(i)
  fit.svm <- train(Activity.1~., data=training,method="svmRadial", metric=metric, trControl=control)
  predictions_2 <- predict(fit.svm, validation)
  cfm_svm <- confusionMatrix(predictions_2, as.factor(validation$Activity.1))
  human_activity[i,'SVM'] <- cfm_svm$overall['Accuracy']
  
  
  set.seed(i)
  fit.rf <- train(Activity.1~., data=training, method="rf",metric=metric, trControl=control)
  predictions_4 <- predict(fit.rf, validation)
  cfm_rf <- confusionMatrix(predictions_4, as.factor(validation$Activity.1))
  human_activity[i,'RF'] <- cfm_rf$overall['Accuracy']
  
}

for (i in 1:5){
  set.seed(i)
  fit.lda <- train(Activity.1~., data=training, method="lda",metric=metric, trControl=control)
  predictions_3 <- predict(fit.lda, validation)
  cfm_lda <- confusionMatrix(predictions_3, as.factor(validation$Activity.1))
  human_activity[i,'LDA'] <- cfm_lda$overall['Accuracy']
}

human_activity
mean_human_activity <- summarise_if(human_activity, is.numeric, mean)
mean_human_activity




