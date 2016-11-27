# Getting and Cleaning Data - Week 4 Project

**Ken Koch  
November 27, 2016**

## Files included in this project:

* **CodeBook.md** - *a description of the variables, data, and transformations performed to create a tidy dataset*  

* **getData.r** - *R script that retrieves the dataset, stores it locally, unzips the master file and loads the data into a dataframe*  

* **run_analysis.R** - *R script that retrieves the data via the getData function (getData.R) and does the following:*  

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names.
    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
      
  
* **wearableData.txt** - *output file for steps 1-4 above (combined test and training data)*  

* **tidyData.txt** - *output file for step 5 above*  


### IMPORTANT - The following packages are required to run these scripts:  
* dplyr
* downloader
* tidyr
* stringr
