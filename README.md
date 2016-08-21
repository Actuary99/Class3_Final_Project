# Class3_Final_Project
This project involves reading in files continaing training and test data for 30 subjects who engaged in up to 6 activities.  A collection of 561 statistics were collected on these subjects. The data represent information collected from the accelerometers from the Samsung Galaxy S smartphone.

The R script for this project is contained in a file called r_analysis.R, part of this same repo.  Details for the way in which the source information was downloaded, cleaned, and transformed is imbedded in that file.  Many of those details are replicated here for the sake of convenience.

First, the script relies on commands that are part of the 'dplyr' and 'reshape' packages, so those packages are installed at the start of the script. 

The subject observations were contained in two files - one containing the 561 observations of subjects randomly allocated to the 'training' data set and one containing the 561 observations of subjects randomly allocated to the 'test' data set.  These observations are read in via two separate data sets, called 'X_train.txt' and 'X_test.txt', respectively.  These files were read into separate data frames.

The activity associated with each observation (in either the 'training' or 'test' data sets) were available via separate files, called 'y_train.txt' and 'y_test.txt', respectively.  Each observation was associated with 1 of 6 activities.  These files were read into separate data frames.

The subject number (from 1-30) for each observation in each of the 'training' and 'test' data sets were available in separate files, called 'subject_train.txt' and 'subject_test.tx', respectively.  These files were then read into separate data frames.

Each activity in the 'y_train.txt' and 'y_test.txt' files could take on a value from 1-6.  We next read in another file which maps these activity numbers to more meaningful activity names.

Each of the 561 statistics captured for each observation associated with some combination of subject/activity is associated with a 'feature'.  We read in a file which contains the feature associated with each of these 561 statitics.  

The data sets containing the subject identifier, the activity, and each of the 561 features for each observation are then combined, first for each of the training and test data sets, and then in thea aggregate (for the training and test data sets combined).  

We are asked only to keep only those features associated with a 'mean' or a standard deviation, 'std'.  This request is fairly open-ended, so we captured the broadest interpreation of this request, selecting any of the 561 features whose name or description included some reference to one of these statistics (even if some of these 'features' are means or std deviation of other available features).  

We create a new data set that includes only the mean and standard deviation features for all subject and activity combinations included in the original data set.   We then merge this data set with the file that translates the activity numbers (1-6) with the associated activity name (laying, sitting, standing, walking, walking_downstairs,walking_upstairs).  When this merge occurs, the newly added activity name is in the last column.  We move the name to the first column (overwriting the associated activity number), rename the first column to reflect it now holds the activity name (not the activity number), and remove the last column (as it is now redundant with column 1).

We then call the 'melt' and 'dcast' functions to transform the data frame into one wherein we can calcuate the average of each mean and standard deviation feature associated with each subject/activity combination.  

At the very end, we try to further describe the resulting column data.  First, we look at the abbreviated 'feature' names and save more robust names that detail for what each abbrevation stands. These more robust names are stored in a separate data frame.  At the very end, we put the original (abbreviated) feature names next to these more robust names.  For example, the column name 'tBodyGyrostd()-X' (from the original feature name) is placed next to its more robust descriptor "Time Body Gyroscope Std Deviation - X Axis" in the final naming convention of the output data frame, making it clear which original 'feature' name was mapped to the more robust descriptor.  This is done simply as a reminder of what each abbrevation in the original naming convention for each feature is meant to represent. 

This final data frame is then written to a table, to a text file called 'r_analysis_output.txt'.

To view this file in an easily-readable format, you can use the following command:

data<-read.table("./r_analysis_output.txt",HEADER=TRUE)  #if the submitted R script is executed in your working directory
View(data)

