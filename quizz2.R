#Question 1
#Load the Alzheimer's disease data using the commands:
library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)
#Which of the following commands will create training and test sets with about 50% of the observations assigned to each?


adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]



#Question 2
#Load the cement data using the commands:
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrainQ2 = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
trainingQ2 = mixtures[ inTrainQ2,]
testingQ2 = mixtures[-inTrainQ2,]

#Make a plot of the outcome (CompressiveStrength) versus the index of the samples. Color by each of the variables in 
#the data set (you may find the cut2() function in the Hmisc package useful for turning continuous covariates into 
	#factors). What do you notice in these plots?

library(Hmisc); library(gridExtra)
#sapply(training, length)
#            Cement    BlastFurnaceSlag              FlyAsh 
#                774                 774                 774 
#              Water    Superplasticizer     CoarseAggregate 
#                774                 774                 774 
#      FineAggregate                 Age CompressiveStrength 
#                774                 774                 774 

###Starting Exploratory Analysis
library(ggplot2); library(ISLR); library(caret)

#Checking out to see if there are any Near Zero Variables:
nsv <- nearZeroVar(trainingQ2, saveMetrics=TRUE)
nsv
                    freqRatio percentUnique zeroVar   nzv
Cement               1.000000     45.736434   FALSE FALSE
BlastFurnaceSlag    29.583333     25.710594   FALSE FALSE
FlyAsh              38.636364     22.222222   FALSE FALSE
Water                1.388889     43.927649   FALSE FALSE
Superplasticizer    24.583333     31.395349   FALSE FALSE
CoarseAggregate      1.388889     44.186047   FALSE FALSE
FineAggregate        1.388889     44.315245   FALSE FALSE
Age                  3.244898      1.808786   FALSE FALSE
CompressiveStrength  1.500000     87.080103   FALSE FALSE
#Goog, apparently all matter..

#Hist
qplot(data=trainingQ2, CompressiveStrength, geom="histogram")
dev.copy(png, file="./Week2/q2hist.png", height=480, width=480)
dev.off()

names <- colnames(mixtures) #Note: mixtures has obviously same columns as trainingQ2...
names <- names[-length(names)] #Remove CompressiveStrength (since relation with itself makes no sense)
featurePlot(x=trainingQ2[,names], y=trainingQ2$CompressiveStrength, plot='pairs')
dev.copy(png, file="./Week2/q2featurePlot.png", height=480, width=480)
dev.off()
#No clear relation is apparent..


#PLot against index:
index <- seq_along(1:nrow(trainingQ2))
ggplot(data = trainingQ2, aes(x = index, y = CompressiveStrength)) + geom_point()
#the data show a step like pattern of outcome versus index in the training set

cutMix <- cut2(trainingQ2$CompressiveStrength) 
table(cutMix)

p1 <- qplot(index, CompressiveStrength, data=trainingQ2, fill=cutMix, geom=c("boxplot"))
p1
dev.copy(png, file="./Week2/q2qplot1.png", height=480, width=480)
dev.off()
p2 <- qplot(index, CompressiveStrength, data=trainingQ2, fill=cutMix, geom=c("boxplot", "jitter"))
grid.arrange(p1,p2, ncol=2)
dev.copy(png, file="./Week2/q2qplot2.png", height=480, width=480)
dev.off()

#Using another feature PLot
featurePlot(x = trainingQ2[, names], y = cutMix, plot = "box")
dev.copy(png, file="./Week2/q2qplot3.png", height=480, width=480)
dev.off()

#No variable clearly explains the Step-like Pattern







#Question 3
#Load the cement data using the commands:
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain3 = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training3 = mixtures[ inTrain3,]
testing3 = mixtures[-inTrain3,]

#Make a histogram and confirm the SuperPlasticizer variable is skewed.
library(ggplot2);
qplot(data=training3, Superplasticizer, geom="histogram") #true story...


#Normally you might use the log transform to try to make the data more symmetric. 
#Why would that be a poor choice for this variable?
#There are values of zero so when you take the log() transform those values will be -Inf.




#Question 4
#Load the Alzheimer's disease data using the commands:
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData4 = data.frame(diagnosis,predictors)
inTrain4 = createDataPartition(adData4$diagnosis, p = 3/4)[[1]]
training4 = adData[ inTrain4,]
testing4 = adData[-inTrain4,]
#Find all the predictor variables in the training set that begin with IL. 
#Perform principal components on these variables with the preProcess() function from the caret package. 
#Calculate the number of principal components needed to capture 80% of the variance. How many are there?

IL <- grep("^IL", colnames(training4), value = TRUE)
preProc <- preProcess(training4[, IL], method = "pca", thresh = 0.8)
preProc$rotation



#Question 5
#Load the Alzheimer's disease data using the commands:
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData5 = data.frame(diagnosis,predictors)
inTrain5 = createDataPartition(adData5$diagnosis, p = 3/4)[[1]]
training5 = adData[ inTrain5,]
testing5 = adData[-inTrain5,]
#Create a training data set consisting of only the predictors with variable names beginning with IL and the diagnosis. 
#Build two predictive models, one using the predictors as they are and one using PCA with principal components 
#explaining 80% of the variance in the predictors. Use method="glm" in the train function. 
#What is the accuracy of each method in the test set? Which is more accurate?
set.seed(3433)
IL <- grep("^IL", colnames(training5), value = TRUE)

predictorsIL <- predictors[, IL]
df <- data.frame(diagnosis, predictorsIL)
inTrain5_2 = createDataPartition(df$diagnosis, p = 3/4)[[1]]
training5_2 = df[inTrain5_2, ]
testing5_2 = df[-inTrain5_2, ]

modelFit5_2 <- train(diagnosis ~ ., method = "glm", data = training5_2)
predictions5_2 <- predict(modelFit5_2, newdata = testing5_2)
Matrix5_2 <- confusionMatrix(predictions5_2, testing5_2$diagnosis)
print(Matrix5_2)
#Accuracy : 0.6463

#Now a model with PCA 80% threshold
set.seed(3433)
modelFit5_3 <- train(training5_2$diagnosis ~ ., method = "glm", preProcess = "pca", 
    data = training5_2, trControl = trainControl(preProcOptions = list(thresh = 0.8)))
predictions5_3 <- predict(modelFit5_3, newdata=testing5_2)
Matrix5_3 <- confusionMatrix(predictions5_3, testing5_2$diagnosis)
print(Matrix5_3)
#Accuracy : 0.7195 
