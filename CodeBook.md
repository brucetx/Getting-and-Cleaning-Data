---
title: "CodeBook"
author: "Bruce Schofield"
date: "January 29, 2017"
output: html_document
---
##Source Dataset Information

###Human Activity Recognition Using Smartphones Dataset

Version 1.0
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

###Description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

1. Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.

2. Triaxial Angular velocity from the gyroscope. 

3. A 561-feature vector with time and frequency domain variables. 

4. Its activity label. 

5. An identifier of the subject who carried out the experiment.

### Source Datasets
UCI HAR Dataset

* test
    + Inertial Signals
    + subject_test.txt
    + X_test.txt
    + y_test.txt

* training
    + Inertial Signals
    + subject_train.txt
    + X_train.txt
    + y_train.txt
    
* activity_labels.txt
* features.txt
* features_info.txt
*	README.txt
	
### Transformations
* X_test.txt and X_train.txt are merged into a dataframe of 10299 instances with 561 attributes
* features.txt provides the names for the 561 attributes
* A subset of the dataframe of 10299 instances with 86 attribute columns names containing only 'mean' or 'std' in their names
* y_test.txt and y_train.txt are merged into a 10299 instances with 1 attribute representing the 'activity' and is merged into the dataframe resulting in a dataframe of 10299 instances with 87 attributes
* subject_test.txt and subject_train.txt are merged into a 10299 instances with 1 attribute representing the 'subject' is merged into the dataframe resulting in a dataframe of 10299 instances with 88 attributes
* From this dataframe, a second, independent tidy data set with the average of each variable for each activity and subject is formed through the use of the group_by(), summarize(), and arrange() functions resulting in a dataframe with 180 observations of 88 attributes
    + 30 subjects with 6 Activites per subject
    