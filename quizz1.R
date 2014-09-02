#Question 1
#Which of the following are steps in building a machine learning algorithm?

#A: Evaluating the prediction.
#Creating features.

#Question 2
#Suppose we build a prediction algorithm on a data set and it is 100% accurate on that data set. Why might the algorithm not work well if we collect a new data set?
#A: Our algorithm may be overfitting the training data, predicting both the signal and the noise.


#Question 3
#What are typical sizes for the training and test sets?
#A: 60% in the training set, 40% in the testing set.


#Question 4
#What are some common error rates for predicting binary variables (i.e. variables with two possible values like yes/no, disease/normal, clicked/didn't click)?
#A: Specificity
#Accuracy

#Question 5
#Suppose that we have created a machine learning algorithm that predicts whether a link will be clicked with 99% sensitivity and 99% specificity. The rate the link is clicked is 1/1000 of visits to a website. If we predict the link will be clicked on a specific visit, what is the probability it will actually be clicked?

Rate clicked = 1/1000 visits = 0.1% 

Sensitivity = TP/(TP+FN) = 99% #so for each 100 actual real clicks, 99% are well predicted (TP); so from population 100.000
Specificity = TN/(TN+FP) = 99% #so for each 99.900 non-clicks, 99% are well predicted (TN) = 98901;


#Confusion matrix:

	TP = 99		FP = 999
	
	FN = 1		TN = 98901  

#So, the Positive Predictive Value - Pr(click | positive test)  = TP/(TP+FP)
Pr (Clicked / predicted) = 99/(99+999) = 9%