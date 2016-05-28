README.md

This file describes the 6 parts in "run_analysis.R" - a R script to perform Data acquisition and Cleaning
Final Project of the "Getting and Cleaning Data Course" in Coursera Data Science Specialization
last release: 28/May/2016

# General Initialization
sets the default directory and loads needed libraries

# 0. Overall Data Reading

reads the input files in default directory and subdirectories,in this order:

- 'test/X_test.txt': Test set. (accelerometer and gyroscope readings during the Testingphase)

- 'test/y_test.txt': Test labels.(6 Activities performed during the Testing phase)

- 'train/subject_test.txt': Each row identifies the subject who performed the activity for each window sample.

- 'train/X_train.txt': Training set. (accelerometer and gyroscope readings during the Training phase)

- 'train/y_train.txt': Training labels.(6 Activities performed during the Training phase)

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample.

- 'features.txt': List of all features (561 variables)

- 'activity_labels.txt': Links the class labels with their activity name:
  (6 different Activities:1 WALKING
; 2 WALKING_UPSTAIRS;
3 WALKING_DOWNSTAIRS
; 4 SITTING; 
5 STANDING; 
6 LAYING
)

# 1. joins testData and trainData into file totalData; joins "Activities" and "Subjects" accordingly
-Uses rbind function to join the following measurement data tables vertically: 
(testData, trainData)
(testActivities, trainActivities)
(testSubjects, trainSubjects)

# 2. extracts only the measurements on the mean and standard deviation, for each measurement

-extracts feature names from "features.txt" and assigns it to testNames list
-filters only the Names containing '-mean" or "-std" and puts result in data table "totalDataFiltered" using the grep function

# 4. Appropriately labels the data set with descriptive variable names:
-inserts header names in data table "totalDataFiltered" from testNames [filterColumns]
-adds two more columns to data table totalDataFiltered:
 "Activities"
 "Subjects"
 with their respective joined values

# 3. uses descriptive Activity Names to name the activities in the "totalDataFiltered" data set:

1- Walking
2- Walking Upstairs
3- Walking Downstairs
4- Sitting
5- Standing
6- Laying

-creates "Activity" vector with Activity description
-inserts Activity names into "totalDataFiltered" data set

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

-performs a loop on every Subject and each Activity code to calculate the average values for every reading in the "totalDataFiltered" data set
-inserts the header names and saves the tidy dataset in "dataset.Rda" file