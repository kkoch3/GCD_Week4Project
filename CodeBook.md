#CodeBook.md

**Ken Koch  
Getting and Cleaning Data  
Week 4 Project
November 27, 2106**

### This file describes the data that was used in the project including the variables, data, and the transformations that were performed to clean up the data

### How the data was obtained:

* The original data was retrieved at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###Two datasets were created via the run_analysis.R script:  
* wearableData - saved to wearableData.txt  
* tidyData - saved to tidyData.txt

---

### wearableData

###This dataset was created by:  
1. Reading the X_test.txt file and separating the data using the dplyr separate() function to create the last 6 variables listed below and also provide the variable names  
2. Reading the Y_test.txt file to retrieve the Activity labels that correspond to the data retrieved from X_test.txt and using the cbind() function to combine it with the data retrieved in step 1.  
3. Reading the subject_test.txt file to retrieve the corresponding Subject data and using the cbind() function to combine it with the data retrieved in steps 1 and 2.  
4. Repeating steps 1 through 3 to retrieve the training data (X_train.txt, Y_train.txt, subject_train.txt)  
5. Combine the test and train datasets (Steps 1 through 4) using the Union() function and storing the result in the wearableData dataset  
6. The Activity detail was added to the wearableData dataset by creating an activities data frame from the activity_label.txt file and then using the lapply() and grep() functions to transform the data in the Activity column
7. The Subject detail was added to the wearableData dataset by using the mutate() and paste() funcions to prefix the subject number with "Subject ".
8. Finally, the wearableData dataset was sorted using the arrange() function. NOTE: In order to properly sort the Subject column in numerical order, the sub() function was used to isolate the subject integer, after which it was coerced to an integer via as.integer().  

####Columns for the Wearable dataset are as follows:  
* Subject - identification of the person being measured  
* Activity - the activity being measured (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)  
* LinearAccelX - Linear Acceleration for the X-axis  
* LinearAccelY - Linear Acceleration for the Y-axis  
* LinearAccelZ - Linear Acceleration for the Z-axis  
* AngularVelocX - Angular Velocity for the X-axis  
* AngularVelocY - Angular Velocity for the Y-axis  
* AngularVelocZ - Angular Velocity for the Z-axis  

---

### tidyData

###This dataset was created by:  
1. Starting with the wearableData dataset.
2. Using the group_by() function to group the data by Subject and Activity
3. Next, using the summarize() function and the mean() function to create the variable averages shown below.
4. Finally, using the arrange() function to order the data by Subject and then by Activity.

####Columns for the tidyData dataset are as follows:  
* Subject - identification of the person being measured
* Activity - the activity being measured (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* AvgLinearAccel-X - Average Linear Acceleration for the X-axis
* AvgLinearAccel-Y - Average Linear Acceleration for the Y-axis
* AvgLinearAccel-Z - Average Linear Acceleration for the Z-axis
* AvgAngularVeloc-X - Average Angular Velocity for the X-axis
* AvgAngularVeloc-Y - Average Angular Velocity for the Y-axis
* AvgAngularVeloc-Z - Average Angular Velocity for the Z-axis  

##Why this dataset is Tidy
1. Each variable forms it's own column. There are 8 distinct variables, as shown above.
2. Each observation is represented by a single row. 
3. The file stores data about one kind of observation. In this case, an observation is a measurement (average XYZ axis data for linear acceleration and angular velocity) for a subject's given activity. 

