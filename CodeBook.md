run_analysis.R CodeBook

Description of main data, variables and transformations performed to clean up input and generate output data.
Version: 28/May/2016

a) Input Data

a.1) Main data was read from the following files, located in the "./data" directory:

- 'README.txt': Basic information about the project: Human Activity Recognition Using Smartphones Dataset

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features (561 variables)

- 'activity_labels.txt': Links the class labels with their activity name:
  (6 different Activities:1 WALKING
; 2 WALKING_UPSTAIRS;
3 WALKING_DOWNSTAIRS
; 4 SITTING; 
5 STANDING; 
6 LAYING
)

- 'train/X_train.txt': Training set. (accelerometer and gyroscope readings during the Training phase)

- 'train/y_train.txt': Training labels.(6 Activities performed during the Training phase)

- 'test/X_test.txt': Test set. (accelerometer and gyroscope readings during the Testingphase)

- 'test/y_test.txt': Test labels.(6 Activities performed during the Testing phase)

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Support files that were provided but not used by run_analysis.R:

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

b) Transformations performed

b.1) Merges the training and the test sets to create one data set.

b.2) Extracts only the measurements on the mean and standard deviation for each measurement.

b.3) Uses descriptive activity names to name the activities in the data set

b.4) Appropriately labels the data set with descriptive variable names.

b.5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

c) Main System Variables description:

# 0. Overall Data Reading

fileUrl: variable used to store the name of several input files

testData: data table with the Testing accelerometer and gyro readings

testActivities: data table with 6 activities codes for both Testing and Training phases

testSubjects: codes for subjects for both Testing and Training phases

trainData, trainActivities and trainSubjects analog to the above, but for Training phase


# 1. joins testData and trainData into file totalData; joins Activities and Subjects accordingly

totalData: table data for joined Testing and Training accelerometer and gyro readings

totalActivities: table data for joined Testing and Training Activity codes

totalSubjects: table data for joined Testing and Training Activity Subject codes


# 2. extracts only the measurements on the mean and standard deviation for each measurement

features: data table with Feature Names from features file (561 types of variables)

testNames: the data table complete header

filterColumns: index vector with number of columns with the Mean and Standard Deviation values from totalData

totalDataFiltered: data table with only the Mean and Standard Deviation values from totalData


# 3. uses descriptive Activity Names to name the activities in the data set


Activity: vector with Activity description ("Walking","Walking Upstairs","Walking Downstairs","Sitting","Standing","Laying")


# 5. From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.

i: loop counter: final matrix Subject (from 1 to 30)

j: loop counter: final matrix rActivity (from 1 to 6)

k: loop counter: final matrix row variable (from 1 to 180, (i=30 * j=6))

m: (matrix) final tidy data table with average of each variable for each activity and each subject

D) Output data

dataset.Rda: output file with the m tidy dataset