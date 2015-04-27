# datasciencecoursera
Repository for JHU Coursera Data Science Specialization

# run_analysis.R code description
In this repo is a file named run_analysis.R, which contains code cleaning the Human Activity Recognition Using Smartphones Data sets. As a note, the data table submitted for this assignment, seems to have cut off the variables at 13, so that is incorrect. However, this code, should be able to reach the correct result.

To run this code, the data will need to be located in a folder called "UCI HAR Dataset" on your desktop. Otherwise, you can change the code to specific the working directory with the data.

The first section of the code reads in variable names, label IDs, and  subject IDs, which are in separate data sets. The inertial signal training data sets are then read in, cleaned, and column bound. This is combined with the training data set, as well as the variable names and labels. These same steps are repeated for the testing data.

The primary functions used are the read.table command to read in the data, rename/gsub to rename variables, and cbind to merge the datasets by column.

Once the testing and training data are combined, and sorted, the mean and standard deviation variables are found with the grep function and the relevant columns are extracted. From here, find and replace functions are used to clean up the non_descriptive variable names.

The following section of code (which I admit is not well commented), reshapes variables to make sure that Axis and Statistic are indicated in separate columns. This process could have been expanded further to include time vs. frequency, as well as other characteristics to impove the readability of the data, but I was unable to perform this due to time constraints.

The main process for reshaping is grouping variables that are only differentiated by statistic or axis and combined them. The previous variable name is then removed or replaced. All these variables are melted into separated data sets. All variables with Axes are merged using the join_all command, and joined on Subject_ID, Activity, Axis, and Stat (Statistic), which they all share. Then the variables without axes are merged using join_all by Subject_ID, Activity, and Stat.

Finally, these data sets are merged together and sorted into the final tidy data set, named "final_tidy_data."

# Codebook

The final data set contains 22 variables with 240 total observations. Four variables are categorical or identifier variables, while the remaining 18 are quantitative numeric variables. 

Subject_ID:  Is the ID variable of the user that can take on a value from 1 to 30.
Activity:  Is a categorical variable that indicates the activity the user was performing. It can take on one of six values:  Laying, Sitting, Standing, Walking, Walking Down Stairs, and Walking Up Stairs
Axis: Is a categorical variable that separates out the X, Y, and Z axes for the quantitative variables that track these data.
Stat: Is a binary categorical variable indicating if the quantitative variable is a mean or a standard deviation.
The remaining variables are quantitative variables that are averaged by Subject ID and Activity.

Average_Body_Acceleration_Time
Average_Gravity_Acceleration_Time
Average_Body_Acceleration_Jerk_Time
Average_Body_Gyroscope_Time
Average_Body_Gyroscope_Jerk_Time
Average_Body_Acceleration_Freq
Average_Body_Acceleration_Jerk_Freq	Average_Body_Gyroscope_Freq	Average_Angle_Gravity	Average_Body_Acceleration_Magnitude_Time	Average_Gravity_Acceleration_Magnitude_Time	Average_Body_Acceleration_Magnitude_Jerk_Time	Average_Body_Gyroscope_Magnitude_Time	Average_Body_Gyroscope_Magnitude_Jerk_Time	Average_Body_Acceleration_Magnitude_Frequency	Average_Body_Acceleration_Magnitude_Jerk_Frequency	Average_Body_Gyroscope_Magnitude_Frequency	Average_Body_Gyroscope_Magnitude_Jerk_Frequency







