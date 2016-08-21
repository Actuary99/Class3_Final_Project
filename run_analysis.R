
#Download the file
#if dplyr is not installed, you must first install it to manipulate data sets below

install.packages("dplyr")
library("dplyr")

install.packages("reshape2")
library("reshape2")


#Read the training file and test files.  These files contain the 561 obs on each subject (first for the training
#group and then for the test group).    
training.obs <- read.table("./UCI HAR Dataset/train/X_train.txt")

test.obs <- read.table("./UCI HAR Dataset/test/X_test.txt")

#Read the labels for the training and test files.  These files contain the activity associated with each row of either
#the 'training' data set or the 'test' data set read in above.

training.labels <- read.table("./UCI HAR Dataset/train/y_train.txt"
         ,col.names=c("activity.number"))

test.labels <- read.table("./UCI HAR Dataset/test/y_test.txt"
         ,col.names=c("activity.number"))


#Read in the subject information (which shows which subject, from 1-30, corresponds to each of the observation data above
# - for each of the training and test data)

subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                                col.names=c("subject"))
subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                                col.names=c("subject"))

#Read in the activity descriptions associated with each activity number
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt",
                                col.names=c("activity.number","activity.name"))

#The features associated with each obs in the original data set were called V1-V561. 
#We now read in what these general column numbers mean.  These feature names will replace the original 
#V1-V561 default column names

features<-read.table("./UCI HAR Dataset/features.txt")
names(training.obs) <- features$V2
names(test.obs)<-features$V2

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
