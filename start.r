library(readr)
start<-read.csv(file.choose())
View(start)
attach(start)
start$State<-as.numeric(start$State)
View(start)
start1<-scale(start)
summary(start1)
View(start1)
startnorm<-as.data.frame(start1)
summary(start$Profit)
train<-startnorm[1:35,]
test<-startnorm[36:50,]

# Using multilayered feed forward nueral network
# package nueralnet
library(neuralnet)
library(nnet)
# Building model
model<-neuralnet(Profit~.,data=train)
plot(model,type="b")
str(model)
# SSE sum of squared errors . least SSE best model
# Evaluating model performance
# compute function to generate ouput for the model prepared
result<-compute(model,test[1:5])
predictedprofit<-result$net.result
result$neurons
cor(predictedprofit,test$Profit)
plot(predictedprofit,test$Profit)
# New model
model1<-neuralnet(Profit~.,data = startnorm,hidden = c(5,3))
plot(model1)
result1<-compute(model1,test[1:5])
prdprofit<-result1$net.result
result1$neurons
cor(prdprofit,test$Profit)
plot(prdprofit,test$Profit)
