---
title: "README"
author: "Bruce Schofield"
date: "January 29, 2017"
output: html_document
---
# Getting and Cleaning Data

Data Sources: The data source for this project is found at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script run_analysis.R performs the following steps:

	1. Merges the training and the test sets to create one data set.
	2. Extracts only the measurements on the mean and standard deviation for each measurement.
	3. Uses descriptive activity names to name the activities in the data set
	4. Appropriately labels the data set with descriptive variable names.
	5. From the data set in step 4, creates an independent tidy data set with the average of each variable for each activity and subject.

## Step 0 - Download data sets
	The data was downloaded and unZip into UCI HAR Dataset folder with sub-folders for test and train data sets.

## Step 1 - Merges the training and the test sets into a single data set
	Test and Train data were read from the sub-folders into R using read.table with the options header=FALSE and sep = "".
		testSet <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE, sep = "")
		trainSet <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE, sep = "")
	Before merging the data sets, the dimensions of the data were checked to ensure the # of columns are consistent
		dim(testSet) -> [1] 2947  561
		dim(trainSet) -> [1] 7352  561	
	rbind is used to merge the data sets
		mergedSet <- rbind(testSet, trainSet)
	Based on the data description found at UCI Human Activity Recognition Using Smartphones Data Set 
	(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
	we should have 10299 instances with 561 attributes
		dim(mergedSet) -> [1] 10299   561	
	
## Step 2 - Extracts only the measurements on the mean and standard deviation for each observation
	Before subsetting the dataset, the descriptive names are added to the columns (Step 4)
		features <- read.csv("UCI HAR Dataset/features.txt", header=FALSE, sep = "")
	Extract only the column names form 'features'
		colNames <- features["V2"]
	And the names to the dataset
		names(mergedSet) <- colNames[ ,1]
	Before continuing, dim() and names() functions were used to check the work
	Next, the grep1 function is sued to to creat a Subset of the data frame with colums containing mean or std attributes
		meanOrSTD <- mergedSet[ grepl("mean|std", names(mergedSet), ignore.case = TRUE) ]
	Again, the	dim() and names() functions were used to check the work
			dim(meanOrSTD)  
   			[1] 10299    86

## Step 3 - Applies descriptive activity names to name the activities in the meanOrSTD data set
	Read test and train lables  
			testLabels<- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE, sep = "")
			trainLabels<- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE, sep = "")
	Before merging the data sets, the dimensions of the data were checked to ensure the a consisten # of columns
			dim(testLabels)  
			[1] 2947    1  
			dim(trainLabels)  
			[1] 7352    1 
	The test and train labels are merged using the rbind() function	and the worked checked using dim()
			mergedLabels <- rbind(testLabels, trainLabels) 
			dim(mergedLabels)
			[1] 10299     1
	Before adding the column to meanOrSTD, the column is named "activity"
			names(mergedLabels) <- "activity"
	The cbind() function is used to add the column and worked checked with dim()
			meanOrSTD <- cbind(mergedLabels, meanOrSTD)
			dim(meanOrSTD)  
			[1] 10299     87
## Step 4 - Labels the data set with descriptive variable names.	
	Steps 2 and 3 added descriptive names for most of the columns; however, Step 5 requires the subject that is added here.
		Read test and train subjects and check the work before merging
			testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep = "")
			trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep = "")
			dim(testSubjects)
			[1] 2947    1
			dim(trainSubjects)
			[1] 7352    1
		Merge the test and train subjects
			mergedSubjects <- rbind(testSubjects, trainSubjects) 		
		Check work:
			dim(mergedSubjects)
			[1] 10299     1
		Name the column "subject"	
			names(mergedSubjects) <- "subject"
		Add the subject column to meanOrSTD using the cbind() function
			meanOrSTD <- cbind(mergedSubjects, meanOrSTD)	
		Check work:
			dim(meanOrSTD)
			[1] 10299    88
## Step 5 - creates a second, independent tidy data set with the average of each variable for each activity and subject			
		This step is accoplished with the group_by(), summarize(), and arrange() functions
			 tidyData <-
					meanOrSTD %>%
					group_by(subject, activity) %>%
					summarize_each(funs(mean)) %>%
					arrange(subject, activity)
		The work is checked to ensure the results are as expected:
		    Check work:
			Expected number of rows = 180 (30 Subjects, 6 Activites per subject)
				 	dim(tidyData)
					[1] 180  88
					
		Finally the results are written to a file
					write.csv(tidyData, file = "tidyData.csv")
---------------------------------------------------------------------------------------------