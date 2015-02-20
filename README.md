# Getting-and-Cleaning-Data

The "run_analysis.R" file has been made to make Human Activity Recognition Using Smartphones Data Set tidy and prepared for the analysis.

First, we unzip all the files in the dataset. Then we read tables from the dataset to R data frames and add labels to all the variables both in training and test sets. We get the labels for all the quantitative variables from the file "features.txt".Also we convert activity names to descriptive format. 

We make training and test data sets tidy and prepare them to merging. Then we merge two datasets vertically.
After merging two datasets, we need to count averages of each variable for each activity and each subject. We use two "for" loops to create this new dataset.

Finally, we write tidy dataset to the text file.

That's all, folks!
