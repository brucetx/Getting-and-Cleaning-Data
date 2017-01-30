run_analysis <- function(){
## Week 4 
## Project
## 
library(dplyr)
library(tidyr)
##
## Step 1 - Merge the test and training sets to into a single data set
    testSet <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE, sep = "")
  ## dim(testSet) -> [1] 2947  561
    trainSet <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE, sep = "")
  ## dim(trainSet) -> [1] 7352  561
    mergedSet <- rbind(testSet, trainSet)
  ## Check work: based on the data description found at UCI Human Activity Recognition Using Smartphones Data Set 
  ## (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
  ## we should have 10299 instances with 561 attributes
  ## dim(mergedSet) -> [1] 10299   561
##
## Step 2 - Extract only the measurements on the mean and standard deviation for each observation
##
    features <- read.csv("UCI HAR Dataset/features.txt", header=FALSE, sep = "")
  ## Check work: 
  ## dim(features)
  ## [1] 561   2
  ## Extract only the column names form 'features'
    colNames <- features["V2"]
  ## Check work: 
  ## dim(colNames)
  ## [1] 561   1
  ##Apply the column names to the mergedSet data frame
    names(mergedSet) <- colNames[ ,1]
  ## Check work:
  ## dim(mergedSet)
  ##[1] 10299   561
  ## names(mergedSet)
  ##
  ## Use grep1 to to creat a Subset of the data frame with colums containing mean or std attributes
  ##
    meanOrSTD <- mergedSet[ grepl("mean|std", names(mergedSet), ignore.case = TRUE) ]
  ##
  ## Check work:
  ## dim(meanOrSTD)  
  ## [1] 10299    86
  ## names(meanOrSTD)  
  ##  
## Step 3 - Apply descriptive activity names to name the activities in the meanOrSTD data set
  ## Read test and train lables  
  ##  
    testLabels<- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE, sep = "")
  ## Check work:
  ## dim(testLabels)  
  ## [1] 2947    1    
    trainLabels<- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE, sep = "")
  ## Check work:
  ## dim(trainLabels)  
  ## [1] 7352    1        
  ## Merge the test and train labels
    mergedLabels <- rbind(testLabels, trainLabels)   
  ## Check work:
  ## dim(mergedLabels)
  ## [1] 10299     1
  ## Name the column "activity"
    names(mergedLabels) <- "activity"
  ## Add the activity column to meanOrSTD
    meanOrSTD <- cbind(mergedLabels, meanOrSTD)
  ## Check work:
  ## dim(meanOrSTD)  
  ## [1] 10299     87
## Step 4 -  labels the data set with descriptive variable names   
  ## For step 5 we will also need to know the subject, add it now
  ## Read test and train subjects  
    testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep = "")
  ## Check work:
  ## dim(testSubjects)
  ## [1] 2947    1
    trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep = "")
  ## Check work:
  ## dim(trainSubjects)
  ## [1] 7352    1
  ## Merge the test and train subjects
    mergedSubjects <- rbind(testSubjects, trainSubjects) 
  ## Check work:
  ## dim(mergedSubjects)
  ## [1] 10299     1
  ## Name the column "subject"
    names(mergedSubjects) <- "subject"
  ## Add the subject column to meanOrSTD
    meanOrSTD <- cbind(mergedSubjects, meanOrSTD)
  ## Check work:
  ## dim(meanOrSTD)
  ## [1] 10299    88
## Step 5 - From the data set in step 4, creates a second, independent tidy data set with
## the average of each variable for each activity and each subject
    tidyData <-
            meanOrSTD %>%
            group_by(subject, activity) %>%
            summarize_each(funs(mean)) %>%
            arrange(subject, activity)
  ## Check work:
  ## Expected Rows = 180 (30 Subjects, 6 Activites per subject)
  ## dim(tidyData)
  ##[1] 180  88
    print(tidyData)
##
# Write CSV
    write.csv(tidyData, file = "tidyData.csv")
}