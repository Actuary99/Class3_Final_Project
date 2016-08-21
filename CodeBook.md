# Class3_Final_Project
##CodeBook

The data for this project was obtained from the following site:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

##License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

##FEATURES

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag

###The following list describes the data contained in each dataframe of the r_analysis.R script.

-training.obs 
- contains the 561 obs on each subject/activity of the training group

-test.obs 
- contains the 561 obs on each subject/activity of the test group

-training.labels
- contains the activity, numbered 1-6, associated with each row of the training group data frame (training.obs)

-test.labels 
- contains the activity, numbered 1-6, associated with each row of the test group data frame (test.obs)
  
-subject.train 
- contains the subject, numbered 1-30, associated with each row of the training group data frame (training.obs)

-subject.test 
- contains the subject, numbered 1-30, associated with each row of the test group data frame (test.obs)

-activity.labels 
- contains the activity description associated with each of the activity numbers (from 1-6) that are part of the training.labels
  and test.labels data frames

-features
- contains an abbreviated reference to the meaning of each of the 561 statistics captured in the training.obs and test.obs data frames.  These abbreviated references are explained more fully above in the "FEATURES" section.

-training
- contains a subject/activity combination from the training group, along with the results of all 561 features for that combination

-test
- contains a subject/activity combination from the test group, along with the results of the 561 features for that combination

-data.all
- is a combination of the data in the 'training' and 'test' data frames 

-mean.data<-data.all[,grepl("[Mn]ean",names(data.all))]
- contains only those columns of the 'data.all' data frame associated with a 'mean' feature result.  Any feature name that included any reference to a 'mean' result was included as part of this data frame.  Such features contained the string 'mean' (where 'm' may or may not be capitalized)

-std.data
- contains only those columns of the 'data.all' data frame associated with a 'standard deviation' feature.  Any feature name that included any reference to a standard deviation was included as part of this data frame. Such features contained the string 'std' (where 's' may or may not be capitalized). 

-data.meanstd
- a data frame that includes the data in the 'mean.data' data frame and the 'std.data' data frame.  This data frame also includes the activity description related to each row.  

-data.final
- a data frame containing the subject number/activity name associated with each observation, along with all features that reference a mean or a standard deviation 

-melted.df
- a data frame that is a 'melted' form of the 'data.final' data frame.  This data frame is required in order to provide averages for each of the features in the 'data.final' data frame (for each combination of subject and activity) 

-avg.df
- the output data frame that contains the average of each feature containing a reference to a mean or a standard deviation for each combination of subject/activity description

-avg.df2
- a replica of the 'avg.df' used in interim steps to provide more robust names to the abbreviated feature names (contained in the 'feature' data frame)

-names.translation
- a data frame that puts the original names of the mean and standard deviation features (contained in the 'feature' data frame) next to the more robust meaning of each of these abbreviated names
