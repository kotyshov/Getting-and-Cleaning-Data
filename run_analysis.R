unzip("Dataset.zip")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(xtrain) <- features$V2
names(subjtrain) <- c("Subject")
names(ytrain) <- c("Activity")
names(xtest) <- features$V2
names(subjtest) <- c("Subject")
names(ytest) <- c("Activity")
actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
ytrain$Type <- 0
ytrain$Type[ytrain$Activity==1] <- rep("WALKING",length(ytrain$Type[ytrain$Activity==1]))
ytrain$Type[ytrain$Activity==2] <- rep("WALKING_UPSTAIRS",length(ytrain$Type[ytrain$Activity==2]))
ytrain$Type[ytrain$Activity==3] <- rep("WALKING_DOWNSTAIRS",length(ytrain$Type[ytrain$Activity==3]))
ytrain$Type[ytrain$Activity==4] <- rep("SITTING",length(ytrain$Type[ytrain$Activity==4]))
ytrain$Type[ytrain$Activity==5] <- rep("STANDING",length(ytrain$Type[ytrain$Activity==5]))
ytrain$Type[ytrain$Activity==6] <- rep("LAYING",length(ytrain$Type[ytrain$Activity==6]))
train <- cbind(ytrain$Type,xtrain)
ytest$Type <- 0
ytest$Type[ytest$Activity==1] <- rep("WALKING",length(ytest$Type[ytest$Activity==1]))
ytest$Type[ytest$Activity==2] <- rep("WALKING_UPSTAIRS",length(ytest$Type[ytest$Activity==2]))
ytest$Type[ytest$Activity==3] <- rep("WALKING_DOWNSTAIRS",length(ytest$Type[ytest$Activity==3]))
ytest$Type[ytest$Activity==4] <- rep("SITTING",length(ytest$Type[ytest$Activity==4]))
ytest$Type[ytest$Activity==5] <- rep("STANDING",length(ytest$Type[ytest$Activity==5]))
ytest$Type[ytest$Activity==6] <- rep("LAYING",length(ytest$Type[ytest$Activity==6]))
test <- cbind(ytest$Type,xtest)
train <- cbind(subjtrain,train)
test <- cbind(subjtest,test)
names(train)[2] <- "Label"
names(test)[2] <- "Label"
total <- rbind(train,test)
for (i in 1:30) {
  for (a in 1:6) {
    subset1 <- subset(total, Subject==i) # We subset the data for each subject
    subset2 <- subset(subset1, Label==actlabels$V2[a]) # Then we subset subject data again for each activity
    row.names(subset2) <- NULL
    subs4 <- sapply(subset2[3:length(subset2)],mean) # We count averages               
    subs4 <- as.data.frame(t(subs4)) # Transpose data to move variables to columns
    subs4 <- cbind(subset2[1,1:2],subs4) # Add subject and activity
    if (i==1 && a==1) {total1 <- subs4} else
      total1 <- rbind(total1,subs4) # Add a line to the final dataset
  }
}
write.table (total1, "dataset.txt", row.names=F)

