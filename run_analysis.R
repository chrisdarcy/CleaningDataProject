#The purpose of this project is to demonstrate your ability to collect, work with, 
#and clean a data set. The goal is to prepare tidy data that can be used for later 
#analysis. You will be graded by your peers on a series of yes/no questions related 
#to the project. You will be required to submit: 
#   1) a tidy data set as described below,
#   2) a link to a Github repository with your script for performing the analysis, and
#   3) a code book that describes the variables, the data, and any transformations or work
#      that you performed to clean up the data called CodeBook.md. 
#      You should also include a README.md in the repo with your scripts.
#      This repo explains how all of the scripts work and how they are connected.

#One of the most exciting areas in all of data science right now is wearable computing
#- see for example this article (http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-theworlds-                top-sports-brand/).
#Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most
#advanced algorithms to attract new users. The data linked to from the course
#website represent data collected from the accelerometers from the Samsung Galaxy
#S smartphone. A full description is available at the site where the data was obtained:

#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

#Here are the data for the project:
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

#You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each
# variable for each activity and each subject.
# Good luck!


########################################################################
library(plyr)
library(dplyr)


#Limited to 300 rows
rowlimit <- 300


#Features.txt extract those columns with mean & std values
mean.std.cols <- read.csv("Mean-And-STD-cols.csv",sep=",", header=TRUE)


#Process TEST set
Set.ID="test"
directory <- paste("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/",Set.ID,"/",sep="")
df <- read.fwf(paste(directory,"x_",Set.ID,".txt",sep=""), c(rep(16,561)), header = FALSE, sep = "\t", skip = 0,n = rowlimit)

#Just the mean & std columns
df.mas <- df[mean.std.cols[,1]]
#Set column names
colnames(df.mas) <- mean.std.cols[,2]

#Import Test Subject data set
df.test.subject <- read.fwf("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", 2, header = FALSE, skip = 0,n = rowlimit)
#Set column names
colnames(df.test.subject) <- "Subject"

#Import Test Activities data set
df.test.activity <- read.fwf("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", 2, header = FALSE, skip = 0,n = rowlimit)
#Set column names
colnames(df.test.activity) <- "Activity"
#Replace int with descriptive names
df.test.activity$Activity <-as.factor(df.test.activity$Activity)
levels(df.test.activity$Activity) <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

#Add column to identify the set
df.Test  <- mutate(df.mas,Activity=df.test.activity[,1],Subject=df.test.subject[,1],set=Set.ID)

#clean up
rm(df.test.subject,df.test.activity,df,df.mas )


#Import Train Subject data set
df.train.subject <- read.fwf("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", 2, header = FALSE, skip = 0,n = rowlimit)
#Set column names
colnames(df.train.subject) <- "Subject"

#Import Train Activities data set
df.train.activity <- read.fwf("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", 2, header = FALSE, skip = 0 ,n = rowlimit)
#Set column names
colnames(df.train.activity) <- "Activity"
#Replace int with descriptive names
df.train.activity$Activity <-as.factor(df.train.activity$Activity)
levels(df.train.activity$Activity) <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")




#Process TRAIN set
Set.ID="train"
directory <- paste("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/",Set.ID,"/",sep="")
df <- read.fwf(paste(directory,"x_",Set.ID,".txt",sep=""), c(rep(16,561)), header = FALSE, sep = "\t", skip = 0,n = rowlimit)

#Just the mean & std columns
df.mas <- df[mean.std.cols[,1]]

#Set column names
colnames(df.mas) <- mean.std.cols[,2]

#Add column to identify the set
df.Train  <- mutate(df.mas,Activity=df.train.activity[,1],Subject=df.train.subject[,1],set=Set.ID)

#Merge the two sets
dfDataSets <- rbind(df.Train,df.Test)


#Average
#ddply(dfDataSets, .(Activity, Subject), summarize, mean = mean(dfDataSets[,c(1:66)], na.rm = TRUE))

dfx <- ddply(dfDataSets, .(Activity, Subject),  numcolwise(mean))

write.table(dfx,"dfx.txt",sep=",",row.name=FALSE)
