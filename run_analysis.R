## Author: Jeff Noel
## Created: Feb 22, 2015
## Modified: Feb 22, 2015
##
## Uses data from 
##   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##
## which is described at
##   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
##
## The data should be unzipped into a directory called UCI_HAR_Dataset
##  (note the added underscores) in the working directory.
##
## The script formats the data found in the /test/X_test.txt and
##    /train/X_train.txt files, removes undesired measurements, adds columns
##    for the subject numbers and activities, then finds means of the
##    the measurements for each (subject, activity) pair.
run_analysis <- function() {
    # read in the test and training data, then combine them    
    test <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
    train <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
    data <- rbind(train, test)
 
    # read in the column descriptions, then discard those that
    #  don't pertain to a mean or standard deviation
    features <- read.table("./UCI_HAR_Dataset/features.txt")
    features <- features[,2]
    data <- setNames(data, features)
    meanAndStd <- grepl("mean()", features) | grepl("std()", features)
    data <- data[, meanAndStd]

    # read the activity descriptions, and activity per measurement from files    
    activity_labels <- read.table("UCI_HAR_Dataset/activity_labels.txt")
    activity_labels <- activity_labels[,2]
    testY <- read.table("./UCI_HAR_Dataset/test/Y_test.txt")
    trainY <- read.table("./UCI_HAR_Dataset/train/Y_train.txt")
    dataY <- rbind(trainY, testY)

    # create vector of activity descriptions per measurement and add them
    #  to the data table
    activities <- activity_labels[dataY[,1]]
    data <- cbind( activities, data)   
    
    # read the subject numbers from files and add them to the data table
    testSubject <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")
    trainSubject <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")
    subjects <- rbind(trainSubject, testSubject)
    subjects <- setNames(subjects, "subjects")
    data <- cbind(subjects, data)

    # Melt the data to give a seperate row for each type of measurement.
    # Find the mean of each of those measurements by subject and activity
    library(reshape2)
    meltData <- melt(data, id=1:2, measure.vars=3:81)
    dataMeans <- dcast(meltData, subjects + activities ~ variable, mean)
}
