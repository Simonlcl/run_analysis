setwd("~/Desktop/ R Programming Code/JHU-Getting and Cleaning Data/Week 4")
#STEP 1: read data

#read features and activity labels from UCI
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, sep = "")

#change the col and row of features
features_change <- t(features)

#read data of labels
labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "")

#read x, y, and subject data from train
xtrain <- read.table(file = "./UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = c(1:561), sep = "")
ytrain <- read.table(file = "./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "")
subtrain <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "")

#read x, y, and subject data from test
xtest <- read.table(file = "./UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = 1:561, sep = "")
ytest <- read.table(file = "./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "")
subtest <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "")


#merge xtrain and xtest data

mergeData <- rbind(xtrain, xtest)

#STEP 2: Extracts the measurements of on the Mean and Standard deviation for every measurement
MeanStd <- grep("mean()|std()", features[, 2])
mergeData <- mergeData[ ,MeanStd]

#STEP 4: rename the data set with descriptive activity names
FeatureName <- sapply(features[, 2], function(x){gsub("[()]", "", x)})
names(mergeData) <- FeatureName[MeanStd]

#combine test and train of subject data and activity data, givce descriptive names
subject <- rbind(subtrain, subtest)
names(subject) <- c("subject")
activity <- rbind(ytrain, ytest)
names(activity) <- c("activity")

#combine subject, activity and mergeData to be the final dataset
FinalData <- cbind(subject, activity, mergeData)
head(FinalData)

#STEP 3: use descriptive ctivity names to name the activity in the data set
group <- factor(FinalData$activity)

#group the activity column of FinalData, rename label of levels with labels, and apply it to FinalData.
levels(group) <- labels[, 2]
FinalData$activity <- group

#STEP 5: create a independent tidy data set 
#with the average of each variable for each activity and each subject.

#install reshape2 package
library(reshape2)

#melt data and cast mean, write the tidy data to working directory as "tidy_data.txt"
newData <- melt(FinalData,(id.vars = c("subject", "activity")))
SecondData <- dcast(newData, subject + activity ~ variable, mean)
names(SecondData) <- paste("[mean of]", names(SecondData))
write.table(SecondData, "tidy_data.txt", sep = ",")

