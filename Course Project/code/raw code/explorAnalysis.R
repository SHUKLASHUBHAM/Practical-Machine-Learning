
trainUrl <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
testUrl <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

#Getting & Cleaning Data
myData <- read.csv(url(trainUrl))
str(myData)
#table(myData$Classes)
summary(myData)

###Cleaning Data:
##removing DIV/0!




#Exploratory Analysis
featurePlot(x=myData[, c("var1", "var2", "var3")], y=myData$toanaylyse, plot="pairs")

qplot(var1, var2, colour=anotherVar, data=training)




####Experimenting partitioning the data:
#Method 1:
inTrain <- createDataPartition(y=myData$something, p=0.75, list=FALSE)
training <- myData[inTrain, ]; test <- myData[-inTrain, ]
dim(training); dim(test)

#Method 2: K-folds for Cross Validation approach
set.seed(12345)
#Devides training set into 4
folds <- createFolds(y=myData$typeVar, k=4, list=TRUE, returnTrain=TRUE)
sapply(folds, length)
fold1 <- folds[[1]]
fold2 <- folds[[2]]
fold3 <- folds[[3]]
fold4 <- folds[[4]]

#With Resampling (bootstrapping):
set.seed(12345)
folds <- createResample(y=myData$typeVar, times=4, list=TRUE)
sapply(folds, length)

#Note for the test Set:
folds <- createFolds(y=myData$typeVar, k=4, list=TRUE, returnTrain=FALSE)











#Using caret package to start testing ML predictions
library(caret)
modFit <- train(Species ~ ., method="rpart", data=training)
print(modFit$finalModel)

#plot tree




