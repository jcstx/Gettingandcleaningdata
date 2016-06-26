library(plyr)

##################################################################################################
### 1. Merges the training and the test sets to create one data set.
##################################################################################################


##Getting activity labels data
activity_labels <- read.table("~/R/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
##Getting features
features <- read.table("~/R/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
## Getting the test subject list
subject_test <- read.table("~/R/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
##Getting the test data
x_test <- read.table("~/R/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
y_test <- read.table("~/R/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
##Getting the train subject list
subject_train <- read.table("~/R/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
##Getting the train data
x_train <- read.table("~/R/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
y_train <- read.table("~/R/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")


##combining both train and test dataset
total <-  rbind(x_train, x_test)

#################################################################################################
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#################################################################################################

##setting variables names using the features vector
names(total) <- features[,2]

##extracting columns names that correspond to mean and standard deviation
listcolumns <- grep(pattern = "*\\-(std|mean)\\(\\)*",value = TRUE,x = features$V2)

##selecting only columns that correspond to mean and standard deviation
total <- total[,listcolumns]


###############################################################################################
## 3. Uses descriptive activity names to name the activities in the data set
###############################################################################################


##combine activity description for training and testing 
y_total <- rbind(y_train, y_test)
##prepare y_total, setting variable names
names(y_total) <- c("activityid")

##combine measurements with activities
total <- cbind(y_total, total)

##prepare activity_labels for merge, setting columns names 
names(activity_labels) <- c("activityid", "activity")

##adding activity description, merging on activityid column
total <- merge(activity_labels,total, by = c("activityid"))
##activity id is not requested for the assignment, only the description
total$activityid <- NULL

###########################################################################################
## 4. Appropriately labels the data set with descriptive variable names. 
###########################################################################################


##combining subject information
subject <- rbind(subject_train, subject_test)
##setting proper variable name, activitydescription already done in previous step
names(subject) <- c("subject")
##adding subject information
total <- cbind(subject, total)


###########################################################################################
## 5. From the data set in step 4, creates a second, independent tidy data set with the 
## average of each variable for each activity and each subject.
############################################################################################
##Caculate the mean for observations by subject and activity
mean_subj_activity  <- ddply(.data = total, .variables = c("subject","activity"), function(x) colMeans(x[,3:68]))

##save the result file
write.table(mean_subj_activity, "mean_subj_activity.txt", row.names = FALSE, quote = FALSE)

