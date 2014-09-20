#Decision Trees

###How to devide Tree branches: try to measure information "impurity"
# 3 Methods: Misclassificaiton, Gini, Deviance/Information Gain
Pmk = 1/(Nm) * SUM(l(yi=k))
Misclassification Error: 1-Pmk(m)=  
	0 - perfect purity;
	0.5 - no purity;

Gini index: 1- SUM(p^2) 
	0 - perfect purity;
	0.5 - no purity;

Deviance/Information Gain: - SUM(p*log2(p))
	0 - perfect purity;
	1 - no purity;

###Example with IRIS dataset
data(iris); library(ggplot)
names(iris)
table(iris$Species)


inTrain <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)
training <- iris[inTrain, ]; testing <- iris[-inTrain, ]
dim(training); dim(testing)


#Exploratory Analysis
qplot(Petal.Width, Sepal.Width, colour=Species, data=training)

#Using caret package to start testing ML predictions
library(caret)
modFit <- train(Species ~ ., method="rpart", data=training)
print(modFit$finalModel)

#plot tree
plot(modFit$finalModel, uniform=TRUE, main="Classification Tree")
text(modFit$finalModel, use.n=TRUE, all=TRUE, cex=.8)

#Prettier plots
library(rattle)
fancyRpartPlot(modFit$finalModel)

predictions <- predict(modFit, newdata=testing)

confusionMatrix(predictions, testing$Species)










