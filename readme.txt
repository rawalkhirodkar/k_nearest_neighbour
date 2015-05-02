Question 1:

Answer ---> Best value of k is at k = 4, there is a tradeoff between variance and bias, and k = 4 gets the best of both worlds from the graph.

Plot 1: LOOCV

1. Accuracy of the model decreases as we increase k, this can be explained as follows:- As k increases, we are taking into consideration more number of votes from the neighbours of
   a point for predicting the y-label. This destroys the intuition behind the KNN algorithm that "closely spaced" data points are more similar in labels as well. As a result we lose the
   localness of data, and we wrongly predict the label for high k values (roughly > 20 in this case).

   Maximum accuracy = 72.68% at k =1
 
2. When k is low, noises will have a higher influence on the result as can be seen from the rapid decrease in accuracy as k decreases.
   A large value of k makes it computationally expensive but it is less prone to noise. Generally k = (number of features)^(1/2) (k = 4 in this case) is choosed, the decay is reasonable along with decent accuracy( 51% ) at k = (16)^(1/2) = 4.

3. Low value of k shows high variance, i.e the prediction by the model is very flexible and varies drastically. Intuition behind this is that at k = 1, we are heavily predicting values
   with respect to the training set.

4. High values of k shows high bias, that is the model is very rigid and is not responding enough to slight change in the training set.Intuition behind this is that at k > 30, we are 
   taking into global vote into consideration for prediction. The global vote maybe same for a bunch of points, this results in we wrongly classifying such bunch of points. Hence the low
   accuracy at high k values. 

   Accuracy = 9.26% at k = 50

############################################################################################################################################################################################

Plot 2: 5-fold CV

1. 5-fold CV belongs to the class of K-fold cross validation, it shows similar trend of decrease in accuracy as observed in LOOCV. This can be explained as LOOCV is nothing but K-fold
   cross validation with K = m (number of data points). LOOCV is more computationally expensive as we are taking average over all the points in the dataset. This reduces irregularities
   (noise) in the predictions of the model. Hence 5-fold performs a little poorly than as compared to LOOCV.

   Maximum accuracy = 71.32& at k = 1

2. High variance of the model can be seen at low values of k, along with high bias for large value of k. The arguments given in the LOOCV holds the same in this case also.

3. K-fold CV has a huge over repeated random sub-sampling as all observations are used for both training and validation, and each observation is used for validation exactly once.This
   explains the high accuracy of the model depicted from the plot.

4. The decrease in accuracy (slope of the plot) is very less in magnitude at high k, intuitively this can be explained ,as k is high, number of points contributing to the label of point
   from validation set is very high, on a global scale the average over this point is almost the same for a cluster of data. Hence all of the cluster is almost classified as belonging to 
   the same class. This results in error, but the increase in error is very less after a while in the process of increasing k

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Question 2:

Plot 1: Testr30.csv

1. The accuracy for the model is very low in the beginning, for k = 1 to 10. This further drops to zero for k greater than 10.This can be explained on the following lines, as the
   training dataset is highly skewed (most labels are 1s , and very few 0's) and all the data in the test set has correct labels all equal to 0's. 
   The KNN incorrectly classifies the labels as 1's for almost all the points from the test set.

2. Due to high variance at k = 1, the KNN model correctly classifies the test data according to the training set (Keep in mind the training set has points from both the classes [0,1],
   however Class 0 is in minority). Test set contains only Class 0 labels but there features are very closely matched to the Class 0 points in the training set.This results in 100%
   accuracy at k = 1.

	Accuracy = 100% , k = 1

3. When k is moderate high, due to averaging over more number of neighbours and skewed nature of training set, we experience almost 0% accuracy.
   Accuracy = 0% for k >10

   The class 1 is overly represented in the training set and in this case the metric accuracy is not a good measure of correctness of a model, instead one should use Precision or Recall
   as described by Sir in the class

4. We can conclude from the plot that the feature vectors in the test1 are more close to the Class 0, as if this was not the case then we wont get 100% accuracy at low values of k.
   This can be verified from a look at the datafiles too. The class 0 labels have there x-co-ordinate positive in both test set 1 and training set.

############################################################################################################################################################################################

Plot 2: Testr31.csv

1. The skew of the training data set is in favor of this test set, thus the trend in accuracy is increasing with increase in k.

2. All the points in the test set are belonging to Class 1, but they are geometrically more close to Class 0 points in the training set. 

3. When k is low, due to high variance of the model, we classify all the points from test set 2 as belonging to Class 0, as they are more closer to it featur wise. This results in
   0% accuracy at k = 1.

4. Moderate k results in more number of votes from the training data for the label of a point from test-set, as the training set is skewed with majority labels being 1s, we predict every 
   label as 1 at this k. This results in 100% accuracy which can be verified from the plot 2b. The distances between points is neglected as we consider the global vote for the prediction.

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
