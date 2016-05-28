# run_analysis.R - a script to perform Data acquisition and Cleaning
# Final Project of the "Getting and Cleaning Data Course" in Coursera Data Science Specialization
# last release: 28/May/2016

# General Initialization
#sets the working directory
setwd("./data")
library(dplyr)

# 0. Overall Data Reading

# reads the Test data from file "./test/X_test.txt"
fileUrl <- "./test/X_test.txt"
testData <- read.table(fileUrl,header=FALSE)

# reads the Test Activity Types from "y_test.txt"
fileUrl <- "./test/y_test.txt"
testActivities <- read.table(fileUrl,header=FALSE)

# reads the Test Subjects from "subject_test.txt"
fileUrl <- "./test/subject_test.txt"
testSubjects <- read.table(fileUrl,header=FALSE)


# reads the Training data from file "./train/X_train.txt"
fileUrl <- "./train/X_train.txt"
trainData <- read.table(fileUrl,header=FALSE)

# reads the Training Activity Types from "y_train.txt"
fileUrl <- "./train/y_train.txt"
trainActivities <- read.table(fileUrl,header=FALSE)

# reads the Training Subjects from "subject_train.txt"
fileUrl <- "./train/subject_train.txt"
trainSubjects <- read.table(fileUrl,header=FALSE)

# 1. joins testData and trainData into file totalData; joins Activities and Subjects accordingly
totalData <- rbind (testData, trainData)
totalActivities <- rbind (testActivities, trainActivities)
totalSubjects <- rbind (testSubjects, trainSubjects)

# 2. extracts only the measurements on the mean and standard deviation for each measurement

#reads and extracts the Feature Names from features and assigns it to testNames list
fileUrl <- "features.txt"
features <- read.table(fileUrl)
testNames <- features$V2

# filters only the Names containing '-mean" or "-std" and puts result in Data Table "totalDataFiltered"
filterColumns <- grep ("-mean|-std", testNames)
totalDataFiltered <- totalData [,filterColumns]


# 4. Appropriately labels the data set with descriptive variable names
names (totalDataFiltered) <- testNames [filterColumns]
# adding Activities and Subjects to the data set
names (totalActivities) <- "Activities"
names (totalSubjects) <- "Subjects"
totalDataFiltered [, "Subjects"] <- totalSubjects
totalDataFiltered [, "Activities"] <- totalActivities

# 3. uses descriptive Activity Names to name the activities in the data set
# renaming Activies according to :
#  1- Walking
#  2- Walking Upstairs
#  3- Walking Downstairs
#  4- Sitting
#  5- Standing
#  6- Laying

#creates a vector with Activity description
Activity <- c("Walking","Walking Upstairs","Walking Downstairs","Sitting","Standing","Laying")

for (i in 1:6) { #substitutes Activity integers by Activities descriptions in totalDataFiltered
  totalDataFiltered$Activities [which (totalDataFiltered$Activities ==i)] <- Activity[i]
}

# 5. From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.


k<-0 #initializes the final matrix row variable
m <- data.frame(matrix (NA,nrow=180, ncol=81)) #new tidy dataset with the required mean values

for (i in 1:30) { # i represents each one of the Subjects  
       for (j in 1:6){ # j represents each Activity
             k<-k+1   # k is every line of the new dataset
             t <- filter(totalDataFiltered,Subjects == i, Activities == Activity [j])
             m [k,] <- c(colMeans(t[,1:79]),i,Activity [j]) #calculates the required means
       }
}

# completes the table data with the header (variable names) and writes it to output file "dataset.Rda"

names (m) <- names (totalDataFiltered)  # puts the labels in the new dataset
write.table(m,file="dataset.txt", row.names=FALSE) #writes the tidy dataset in dataset.Rda file