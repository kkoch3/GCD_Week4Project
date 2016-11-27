# Ken Koch
# Getting and Cleaning Data - Week 4 Project

# This script downloads the data, unzips the files, merges the training and 
# test datasets, and returns the resulting data frame

library(dplyr)
library(downloader)
library(tidyr)
library(stringr)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#The download function from the downloader package is required for https downloads
#download(url, "wearableData.zip")
#unzip("wearableData.zip")

#Get the test data 
df <- read.csv("./UCI HAR Dataset/test/X_test.txt", header = FALSE, stringsAsFactors = FALSE)
testData <- tbl_df(df)
testData <- mutate(testData, V1 = str_trim(V1, side = "left"))

#Get the test activity data
df <- read.csv("./UCI HAR Dataset/test/y_test.txt", header = FALSE, stringsAsFactors = FALSE)
testActivity <- tbl_df(df)
names(testActivity)[1] <- "Activity"  #Name the column

#Get the test subject data
df <- read.csv("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, stringsAsFactors = FALSE)
testSubjects <- tbl_df(df)
names(testSubjects)[1] <- "Subject"  #Name the column

#Get the training data
df <- read.csv("./UCI HAR Dataset/train/X_train.txt", header = FALSE, stringsAsFactors = FALSE)
trainData <- tbl_df(df)
trainData <- mutate(trainData, V1 = str_trim(V1, side = "left"))

#Get the training activity data
df <- read.csv("./UCI HAR Dataset/train/y_train.txt", header = FALSE, stringsAsFactors = FALSE)
trainActivity <- tbl_df(df)
names(trainActivity)[1] <- "Activity"  #Name the column

#Get the training subject data
df <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, stringsAsFactors = FALSE)
trainSubjects <- tbl_df(df)
names(trainSubjects)[1] <- "Subject"  #Name the column

rm(df)

#Separate the testData and name the columns for Linear Acceleration XYZ and 
#Angular Velocity XYZ
testData <- separate(testData, V1, c("LinearAccelX", "LinearAccelY", "LinearAccelZ",
                                     "AngularVelocX", "AngularVelocY", "AngularVelocZ"),
                     sep = " ")

#Combine testData with testActivity to create test dataframe
test <- cbind(testActivity[,1], testData)

#Add testSubjects to test dataframe to fully consolidate test data
test <- cbind(testSubjects[,1], test)

#Separate the trainData and name the columns for Linear Acceleration XYZ and 
#Angular Velocity XYZ
trainData <- separate(trainData, V1, c("LinearAccelX", "LinearAccelY", "LinearAccelZ",
                                     "AngularVelocX", "AngularVelocY", "AngularVelocZ"),
                     sep = " ")

#Combine trainData with trainActivity to create train dataframe
train <- cbind(trainActivity[,1], trainData)

#Add trainSubjects to train dataframe to fully consolidate train data
train <- cbind(trainSubjects[,1], train)

#Merge test and train data into single dataframe called wearableData
wearableData <- union(test, train)

#Clean up everything we no longer need
rm(test)
rm(testData)
rm(testActivity)
rm(testSubjects)
rm(train)
rm(trainData)
rm(trainActivity)
rm(trainSubjects)
