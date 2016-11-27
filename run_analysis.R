# Ken Koch
# Getting and Cleaning Data - Week 4 Project

# This script runs the getData.R file (which adds variable names and combines the 
# test and train datasets), adds full subject and activity names to each row of 
# the data, and then creates a tidy dataset

library(data.table)

#Run the getData.R file, this will leave us with a dataset called wearableData
source("getData.R")

#Get the Activity Names and set them up in a vector for reading
df <- read.csv("./UCI HAR Dataset/activity_labels.txt", header = FALSE,
                       stringsAsFactors = FALSE)
activities <- data.table(df)
rm(df)

#Replace the Activity number with the descriptive activity name
wearableData$Activity <- as.character(lapply(wearableData$Activity, function(x) 
        x = sub('[1-9] ', '', grep(paste('.*', x,'.*', sep = ""), activities$V1, value = TRUE))))

#Add full subject names to the Subject column
wearableData <- mutate(wearableData, 'Subject' = paste("Subject", Subject))

#Sort the data by the Subject and then Activity
wearableData <- arrange(wearableData, as.integer(sub('*Subject ', '', Subject)),
                        Activity)

#Store the data to a local file
write.csv(wearableData, "wearableData.csv", row.names = FALSE)

#Let's group and summarize the data by averaging each variable by subject and activity
tidyData <- wearableData %>%
        group_by(Subject, Activity) %>%
        summarize('AvgLinearAccel-X' = mean(as.numeric(LinearAccelX), na.rm = TRUE),
                  'AvgLinearAccel-Y' = mean(as.numeric(LinearAccelY), na.rm = TRUE),
                  'AvgLinearAccel-Z' = mean(as.numeric(LinearAccelZ), na.rm = TRUE),
                  'AvgAngularVeloc-X' = mean(as.numeric(AngularVelocX), na.rm = TRUE),
                  'AvgAngularVeloc-Y' = mean(as.numeric(AngularVelocY), na.rm = TRUE),
                  'AvgAngularVeloc-Z' = mean(as.numeric(AngularVelocZ), na.rm = TRUE)) %>%
        arrange(as.integer(sub('*Subject ', '', Subject)),
                Activity)

#Store the tidy data to a local file
write.csv(tidyData, "tidyData.csv", row.names = FALSE)
