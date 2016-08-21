# Class3_Final_Project
This project involves reading in files continaing training and test data for 30 subjects who engaged in up to 6 activities.  A collection of 561 statistics were collected on these subjects. The data represent information collected from the accelerometers from the Samsung Galaxy S smartphone.

The R script for this project is contained in a file called r_analysis.R.  Details for the way in which the source information was downloaded, cleaned, and transformed is imbedded in that file.  Many of those details are replicated here for the sake of convenience.

First, the script relies on commands that are part of the 'dplyr' and 'reshape' packages, so those packages are installed at the start of the script. 

The subject observations were contained in two files - one containing the 561 observations of subjects randomly allocated to the 'training' data set and one containing the 561 observations of subjects randomly allocated to the 'test' data set.  These observations are read in via two separate data sets, called 'X_train.txt' and 'X_test.txt', respectively.  These files were read into separate data frames.

The activity associated with each observation (in either the 'training' or 'test' data sets) were available via separate files, called 'y_train.txt' and 'y_test.txt', respectively.  Each observation was associated with 1 of 6 activities.  These files were read into separate data frames.

The subject number (from 1-30) for each observation in each of the 'training' and 'test' data sets were available in separate files, called 'subject_train.txt' and 'subject_test.tx', respectively.  These files were then read into separate data frames.

Each activity in the 'y_train.txt' and 'y_test.txt' files could take on a value from 1-6.  We then read in another file which maps these activity numbers to more meaningful activity names.

Each of the 561 statistics captured on each subject/activity is associated with a 'feature'.  We read in a file which contains the feature associated with each of the 561 statitics captured.  

The data sets containing the subject, the activity, and 

#Now construct the full 'training' and 'test' data sets, which will be comprised of the subject for each obs, 
#the activity number for each obs, and the 561 features measured for each subject/activity (now with
#more meaningful column names)
training<-cbind(subject.train,training.labels,training.obs)
test<-cbind(subject.test,test.labels,test.obs)

#We are asked to combine the 'training' and 'test' data sets into one final data set
data.all<-rbind(training,test)

#We only want to keep those features associated with either a 'mean' or a 'standard deviation'.  We exclude all other
#columns from our final data set.  We will create two different data sets, one containing only the info about the 'means'
#and one containing only the information about the 'std deviations'
mean.data<-data.all[,grepl("[Mn]ean",names(data.all))]
std.data<-data.all[,grepl("[Ss]td",names(data.all))]

#We will now construct the final data set for just features containing mean and std dev info.  
#We show the subject number, the activity number from the full data set and then all features associated with a 
#mean or a std dev
data.meanstd<-cbind(data.all[,c(1,2)],mean.data,std.data)

#We now need to merge in the activity labels/descriptions, which will give better meaning to the activity numbers.  
#We then arrange the final data set by the 'subject'
data.meanstd<-merge(data.meanstd,activity.labels,by="activity.number")
data.meanstd<-arrange(data.meanstd,subject)

#The activity name is at the last column in the data set.  We want to move it to the beginning and overwrite the 
#activity number.  Once we have moved the activity name to the first column, we can rename the first col to better
#correspond to the values it now holds.  Since we moved the activity name to the first column, we no longer need it as 
#the last column.  We can delete the last column, which is now duplicate information.
data.meanstd[,1]<-data.meanstd[,length(data.meanstd)]
data.final<-rename(data.meanstd,activity = activity.number)
data.final<-data.final[,1:length(data.meanstd)-1]

#We now wish to get mean information on all variables, by every subject/activity combination.  We call the 'melt'
#command to tell R that the id variables in which we are interested are called 'activity.name' and 'subject'.  All other
#variables are measure variables (by default in the 'melt' command).  All these measure variables (not specifically
#mentioned in the command line for melt) will collectively be referred to hereafter as 'variable'.  
#To use the 'melt' command, you must install the 'reshape2' package.
melted.df<- melt(data.final,id.vars=c("activity","subject"),variable.name="variable",na.rm=T)

#We now wish to calculate the mean of each measure variable for each combination of 'subject' and 'activity.name'
#Since there are 30 subjects and 6 activities, the max number of combinations is 180 (if there is at least one
#observation for each permutation).  The 'dcast' command requires the 'reshape2' package
avg.df<-dcast(melted.df,subject+activity~variable,mean)

#Make a copy of the tidy data set containing the mean and std deviations.  
avg.df2<-avg.df

names(avg.df2)


#Convert the feature names of this new tiny data set into something more readable & meaningful

names(avg.df2)<-sub("^t","Time ",names(avg.df2)) 
names(avg.df2)<-sub("tBody","Time Body ",names(avg.df2)) 
names(avg.df2)<-sub("^f","FFT ",names(avg.df2)) 
names(avg.df2)<-sub("[Gg]ravity"," Gravity",names(avg.df2)) 
names(avg.df2)<-sub("[Mm]ean"," Mean",names(avg.df2)) 

names(avg.df2)<-sub("-mean\\(\\)","-Mean",names(avg.df2))   
names(avg.df2)<-sub("-meanFreq\\(\\)"," Mean Frequency",names(avg.df2))   
names(avg.df2)<-sub("-std\\(\\)","-Std Deviation",names(avg.df2))
names(avg.df2)<-sub("angle\\("," Angle between vectors \\(",names(avg.df2))

names(avg.df2)<-sub("Acc","Acceleration ",names(avg.df2))
names(avg.df2)<-sub("Mag","Magnitude ",names(avg.df2))
names(avg.df2)<-sub("Jerk","Jerk ",names(avg.df2))
names(avg.df2)<-sub("Gravity","Gravity ",names(avg.df2))
names(avg.df2)<-sub("Gyro","Gyroscope ",names(avg.df2))
names(avg.df2)<-sub("Body","Body ",names(avg.df2))
names(avg.df2)<-sub("Body Body","Body ",names(avg.df2))
names(avg.df2)<-sub("-X$"," X Axis",names(avg.df2))
names(avg.df2)<-sub("-Y$"," Y Axis",names(avg.df2))
names(avg.df2)<-sub("-Z$"," Z Axis",names(avg.df2))

#Put the prior abbreviated feature names next to the new, more descriptive feature names so we can see them 
#side-by-side
names.translation<-paste(names(avg.df[3:length(avg.df)]),names(avg.df2[3:length(avg.df2)]),sep="-->")

names(avg.df)<-c("subject","activity",names.translation)

#View the final data set
View(avg.df)

#Write the final data frame to a text file
write.table(avg.df,file="r_analysis_output.txt",row.names=FALSE)


