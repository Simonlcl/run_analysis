# run_analysis
the first thing is to set working directory to the UCI HAR Dataset.
STEP 1: use read.table to read data from working directory, merge train and test data using rbind function.
STEP 2: extract the measurement of the data on the mean and Std for every measurement.
STEP 4: reanme the data set with descriptive activity names using sapply function, continue combine subtrain and subtest data using rbind function.
STEP 3: use descriptive activity names to name the acitivity in the data set.
STEP 5: create independent tidy data set, firstlty install reshape2 package, use melt and dcast function to create newData and SecondData, finally use write.table function to get tidy.data.txt file.

Code Book:
features: features.txt
labels: activity_labels.txt
xtrain: X_train.txt
ytrain: y_train.txt
subtrain: subject_train.txt
xtest: X_test.txt
ytest: y_test.txt
subtest: subject_test.txt
mergeData: xtrain combine xtest
Meanstd: variable contains mean and std  in features
