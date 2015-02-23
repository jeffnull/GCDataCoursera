# GCDataCoursera
Project for Getting and Cleaning Data Coursera course

Uses data from 
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 which is described at
   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

 The data should be unzipped into a directory called UCI_HAR_Dataset
  (note the added underscores) in the working directory.

 The script formats the data found in the /test/X_test.txt and
    /train/X_train.txt files, removes undesired measurements, adds columns
    for the subject numbers and activities, then finds means of the
    the measurements for each (subject, activity) pair.
    
The script operates as follows:

1. Reads in the test and training data (X_test and X_train), then combines them into a single data frame.
2. Reads in the column descriptions (features.txt), then discards those that don't pertain to a mean or
   standard deviation. In particular, it only keeps those columns with mean() or std() in their names.
3. Reads the activity descriptions (activity_labels.txt) and the corresponding activity signifiers for the data
   sets (Y_test and Y_train). Then attaches the correct activity label to each observation in the data.
4. Reads in the id numbers for the human subjects (subject_test and subject_train)  for each observation and attaches
   them to the data.
5. "Melts" the data, so that each row contains a subject id, an activity, and a particular measurement (label and   
   value).
6. "Casts" the data, taking the mean over each measurement type for each human subject and activity.

The script returns the data frame with the calculated means. The following will run the script and write the data:
   
    x <- run_analysis()
   
    write.table(x, "samsungDataMeans.txt", row.names=FALSE)

Which can then be read back into R via:

    x <- read.table("samsungDataMeans.txt", header=TRUE)
