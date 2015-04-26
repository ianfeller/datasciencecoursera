# Getting and Cleaning Data Final Project
# JHU Data Science Specialization 
# Created:  4/26/15
# Updated:  4/26/15

# Set Working directory
setwd("../Desktop/UCI HAR Dataset")

library(dplyr)
library(data.table)
library(tidyr)
library(reshape2)

####################################################
# Read in Variable Names, Label IDs, & Subject IDs #
####################################################

#Read in Features Data to Extract Variable Names
features_data <- read.table("./features.txt")
var_name <- as.character(features_data[,2])

#Read in Activity Labels and Rename Variables
activity_label <- read.table("./activity_labels.txt")
activity_label <- rename(activity_label, ID=V1, Activity=V2)

#Read in Subject IDs to be merged in later
subject_ids_training <- read.table("./train/subject_train.txt")
subject_ids_training <- rename(subject_ids_training, Subject_ID = V1)

#Read in Subject IDs to be merged in later
subject_ids_testing <- read.table("./test/subject_test.txt")
subject_ids_testing <- rename(subject_ids_testing, Subject_ID = V1)

#Read in Labels for Training Data  and Merge to Rename with Activities
training_data_y <- read.table("./train/Y_train.txt")
training_data_y_clean <- merge(training_data_y,activity_label,by.x="V1",by.y="ID")
training_data_y_clean <- select(training_data_y_clean,Activity)

#Read in Labels for Testing Data  and Merge to Rename with Activities
testing_data_y <- read.table("./test/Y_test.txt")
testing_data_y_clean <- merge(testing_data_y,activity_label,by.x="V1",by.y="ID")
testing_data_y_clean <- select(testing_data_y_clean,Activity)



######################################################
# Read And Clean Training Inertial Signals Data Sets #
######################################################

#Read and Rename Total Acceleration Data
training_data_taccX <- read.table("./train/Inertial Signals/total_acc_x_train.txt")
training_data_taccX$Axis <- "X"
training_data_taccY <- read.table("./train/Inertial Signals/total_acc_y_train.txt")
training_data_taccY$Axis <- "Y"
training_data_taccZ <- read.table("./train/Inertial Signals/total_acc_z_train.txt")
training_data_taccZ$Axis <- "Z"

names(training_data_taccX) <- gsub("V","",names(training_data_taccX))
names(training_data_taccY) <- gsub("V","",names(training_data_taccY))
names(training_data_taccZ) <- gsub("V","",names(training_data_taccZ))

#Reshape Long
training_data_taccX<-cbind(subject_ids_training,training_data_y_clean,training_data_taccX)
training_data_taccX <- melt(training_data_taccX,id.vars=c("Subject_ID","Activity", "Axis"))
training_data_taccY<-cbind(subject_ids_training,training_data_y_clean,training_data_taccY)
training_data_taccY <- melt(training_data_taccY,id.vars=c("Subject_ID","Activity", "Axis"))
training_data_taccZ<-cbind(subject_ids_training,training_data_y_clean,training_data_taccZ)
training_data_taccZ <- melt(training_data_taccZ,id.vars=c("Subject_ID","Activity", "Axis"))

training_data_tacc <- rbind(training_data_taccX, training_data_taccY,training_data_taccZ)
training_data_tacc <- rename(training_data_tacc, Observation_Number=variable, Total_Acceleration = value)

#Read and Rename Body Acceleration Data
training_data_baccX <- read.table("./train/Inertial Signals/body_acc_x_train.txt")
training_data_baccX$Axis <- "X" 
training_data_baccY <- read.table("./train/Inertial Signals/body_acc_y_train.txt")
training_data_baccY$Axis <- "Y" 
training_data_baccZ <- read.table("./train/Inertial Signals/body_acc_z_train.txt")
training_data_baccZ$Axis <- "Z" 

names(training_data_baccX) <- gsub("V","",names(training_data_baccX))
names(training_data_baccY) <- gsub("V","",names(training_data_baccY))
names(training_data_baccZ) <- gsub("V","",names(training_data_baccZ))


#Reshape Long
training_data_baccX<-cbind(subject_ids_training,training_data_y_clean,training_data_baccX)
training_data_baccX <- melt(training_data_baccX,id.vars=c("Subject_ID","Activity", "Axis"))
training_data_baccY<-cbind(subject_ids_training,training_data_y_clean,training_data_baccY)
training_data_baccY <- melt(training_data_baccY,id.vars=c("Subject_ID","Activity", "Axis"))
training_data_baccZ<-cbind(subject_ids_training,training_data_y_clean,training_data_baccZ)
training_data_baccZ <- melt(training_data_baccZ,id.vars=c("Subject_ID","Activity", "Axis"))

training_data_bacc <- rbind(training_data_baccX, training_data_baccY,training_data_baccZ)
training_data_bacc <- rename(training_data_bacc, Observation_Number=variable, Body_Acceleration = value)

#Read and Rename Angular Velocity  Data
training_data_bvelX <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
training_data_bvelX$Axis <- "X"
training_data_bvelY <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
training_data_bvelY$Axis <- "Y"
training_data_bvelZ <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
training_data_bvelZ$Axis <- "Z"

names(training_data_bvelX) <- gsub("V","",names(training_data_bvelX))
names(training_data_bvelY) <- gsub("V","",names(training_data_bvelY))
names(training_data_bvelZ) <- gsub("V","",names(training_data_bvelZ))

#Reshape Long
training_data_bvelX<-cbind(subject_ids_training,training_data_y_clean,training_data_bvelX)
training_data_bvelX <- melt(training_data_bvelX,id.vars=c("Subject_ID","Activity", "Axis"))
training_data_bvelY<-cbind(subject_ids_training,training_data_y_clean,training_data_bvelY)
training_data_bvelY <- melt(training_data_bvelY,id.vars=c("Subject_ID","Activity", "Axis"))
training_data_bvelZ<-cbind(subject_ids_training,training_data_y_clean,training_data_bvelZ)
training_data_bvelZ <- melt(training_data_bvelZ,id.vars=c("Subject_ID","Activity", "Axis"))

training_data_bvel <- rbind(training_data_bvelX, training_data_bvelY,training_data_bvelZ)
training_data_bvel <- rename(training_data_bvel, Observation_Number=variable, Body_Angular_Velocity = value)

#Remove Subject_ID, Activity, and Axis Before Merge
training_data_bacc <- select(training_data_bacc, -c(1,2,3,4))
training_data_bvel <- select(training_data_bvel, -c(1,2,3,4))


#Create Combined Intertial Signals Data
training_intertial_signals_data<-cbind(training_data_tacc,training_data_bacc,training_data_bvel)

# Correctly done by merge, but took too long/used too much memory. 
# training_intertial_signals_data <- merge(training_data_tacc,training_data_bacc,
#                                          by=c("Subject_ID", "Activity", "Axis", "Observation_Number"))
# training_intertial_signals_data <- merge(training_intertial_signals_data,training_data_bvel,
#                                          by=c("Subject_ID", "Activity", "Axis", "Observation_Number"))


####################################
# Read And Clean Training Data Set #
####################################

#Read in Training Data with identified features
training_data_x <- read.table("./train/X_train.txt",col.names = var_name)

View(training_data_x)

#Column Bind with Subject ID and Labels Data to create full training data set
training_dataset <- cbind(subject_ids_training,training_data_y_clean,
                          training_data_x,training_intertial_signals_data)

######################################################
# Read And Clean Testing Inertial Signals Data Sets  #
######################################################

#Read and Rename Total Acceleration Data
testing_data_taccX <- read.table("./test/Inertial Signals/total_acc_x_test.txt")
testing_data_taccX$Axis <- "X"
testing_data_taccY <- read.table("./test/Inertial Signals/total_acc_y_test.txt")
testing_data_taccY$Axis <- "Y"
testing_data_taccZ <- read.table("./test/Inertial Signals/total_acc_z_test.txt")
testing_data_taccZ$Axis <- "Z"

names(testing_data_taccX) <- gsub("V","",names(testing_data_taccX))
names(testing_data_taccY) <- gsub("V","",names(testing_data_taccY))
names(testing_data_taccZ) <- gsub("V","",names(testing_data_taccZ))

#Reshape Long
testing_data_taccX<-cbind(subject_ids_testing,testing_data_y_clean,testing_data_taccX)
testing_data_taccX <- melt(testing_data_taccX,id.vars=c("Subject_ID","Activity", "Axis"))
testing_data_taccY<-cbind(subject_ids_testing,testing_data_y_clean,testing_data_taccY)
testing_data_taccY <- melt(testing_data_taccY,id.vars=c("Subject_ID","Activity", "Axis"))
testing_data_taccZ<-cbind(subject_ids_testing,testing_data_y_clean,testing_data_taccZ)
testing_data_taccZ <- melt(testing_data_taccZ,id.vars=c("Subject_ID","Activity", "Axis"))

testing_data_tacc <- rbind(testing_data_taccX, testing_data_taccY,testing_data_taccZ)
testing_data_tacc <- rename(testing_data_tacc, Observation_Number=variable, Total_Acceleration = value)

#Read and Rename Body Acceleration Data
testing_data_baccX <- read.table("./test/Inertial Signals/body_acc_x_test.txt")
testing_data_baccX$Axis <- "X" 
testing_data_baccY <- read.table("./test/Inertial Signals/body_acc_y_test.txt")
testing_data_baccY$Axis <- "Y" 
testing_data_baccZ <- read.table("./test/Inertial Signals/body_acc_z_test.txt")
testing_data_baccZ$Axis <- "Z" 

names(testing_data_baccX) <- gsub("V","",names(testing_data_baccX))
names(testing_data_baccY) <- gsub("V","",names(testing_data_baccY))
names(testing_data_baccZ) <- gsub("V","",names(testing_data_baccZ))


#Reshape Long
testing_data_baccX<-cbind(subject_ids_testing,testing_data_y_clean,testing_data_baccX)
testing_data_baccX <- melt(testing_data_baccX,id.vars=c("Subject_ID","Activity", "Axis"))
testing_data_baccY<-cbind(subject_ids_testing,testing_data_y_clean,testing_data_baccY)
testing_data_baccY <- melt(testing_data_baccY,id.vars=c("Subject_ID","Activity", "Axis"))
testing_data_baccZ<-cbind(subject_ids_testing,testing_data_y_clean,testing_data_baccZ)
testing_data_baccZ <- melt(testing_data_baccZ,id.vars=c("Subject_ID","Activity", "Axis"))

testing_data_bacc <- rbind(testing_data_baccX, testing_data_baccY,testing_data_baccZ)
testing_data_bacc <- rename(testing_data_bacc, Observation_Number=variable, Body_Acceleration = value)

#Read and Rename Angular Velocity  Data
testing_data_bvelX <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")
testing_data_bvelX$Axis <- "X"
testing_data_bvelY <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")
testing_data_bvelY$Axis <- "Y"
testing_data_bvelZ <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")
testing_data_bvelZ$Axis <- "Z"

names(testing_data_bvelX) <- gsub("V","",names(testing_data_bvelX))
names(testing_data_bvelY) <- gsub("V","",names(testing_data_bvelY))
names(testing_data_bvelZ) <- gsub("V","",names(testing_data_bvelZ))

#Reshape Long
testing_data_bvelX<-cbind(subject_ids_testing,testing_data_y_clean,testing_data_bvelX)
testing_data_bvelX <- melt(testing_data_bvelX,id.vars=c("Subject_ID","Activity", "Axis"))
testing_data_bvelY<-cbind(subject_ids_testing,testing_data_y_clean,testing_data_bvelY)
testing_data_bvelY <- melt(testing_data_bvelY,id.vars=c("Subject_ID","Activity", "Axis"))
testing_data_bvelZ<-cbind(subject_ids_testing,testing_data_y_clean,testing_data_bvelZ)
testing_data_bvelZ <- melt(testing_data_bvelZ,id.vars=c("Subject_ID","Activity", "Axis"))

testing_data_bvel <- rbind(testing_data_bvelX, testing_data_bvelY,testing_data_bvelZ)
testing_data_bvel <- rename(testing_data_bvel, Observation_Number=variable, Body_Angular_Velocity = value)

#Remove Subject_ID, Activity, and Axis Before Merge
testing_data_bacc <- select(testing_data_bacc, -c(1,2,3,4))
testing_data_bvel <- select(testing_data_bvel, -c(1,2,3,4))


#Create Combined Intertial Signals Data
testing_intertial_signals_data<-cbind(testing_data_tacc,testing_data_bacc,testing_data_bvel)

####################################
# Read And Clean Testing Data Set  #
####################################

#Read in Testing Data with identified features
testing_data_x <- read.table("./test/X_test.txt",col.names = var_name)

#Column Bind with Subject ID and Labels Data to create full testing data set
testing_dataset <- cbind(subject_ids_testing,testing_data_y_clean,
                         testing_data_x,testing_intertial_signals_data)





#########################################
# Merge Training and Testing Data Sets  #
#########################################

combined_dataset <- rbind(training_dataset,testing_dataset)
combined_dataset <- arrange(combined_dataset,Subject_ID,desc(Activity))

##############################
# Keep Mean and SD Variables #
##############################

#Search variable names for mean and std
mean_vars <- grep("mean",names(combined_dataset),ignore.case=TRUE)
sd_vars <- grep("std",names(combined_dataset),ignore.case=TRUE)
mean_sd_vars <- sort(c(1,2,mean_vars,sd_vars))

#Extract Mean and Standard Deviation Vars
extracted_data <- select(combined_dataset,mean_sd_vars)

#Remove Mean Freq
freq_vars <- grep("freq",names(extracted_data),ignore.case=TRUE,invert = TRUE)
extracted_data <- select(extracted_data,freq_vars)

#############################################################################
# Create Data Set with average of each variable for each activity & subject #
#############################################################################

mean_variables <- group_by(extracted_data,Subject_ID,Activity)
tidy_data <- summarise_each(mean_variables,funs(mean))


#Clean up names 

names(tidy_data) <- sub("mean(.*)","\\1_Mean",names(tidy_data),perl = TRUE,ignore.case=TRUE)
names(tidy_data) <- sub("std(.*)","\\1_STD",names(tidy_data),perl = TRUE,ignore.case=TRUE)
names(tidy_data) <- sub("\\.{3}",".",names(tidy_data),perl = TRUE)
names(tidy_data) <- gsub("\\.{1}","_",names(tidy_data),perl = TRUE)
names(tidy_data) <- sub("__$","",names(tidy_data),perl = TRUE)
names(tidy_data) <- gsub("_$","",names(tidy_data),perl = TRUE)
names(tidy_data) <- sub("^t","Time_",names(tidy_data),perl = TRUE)
names(tidy_data) <- sub("^angle_t","Time_angle_",names(tidy_data),perl = TRUE,ignore.case=TRUE)
names(tidy_data) <- sub("angle","Angle",names(tidy_data),perl = TRUE,ignore.case=TRUE)
names(tidy_data) <- sub("^f","Freq_",names(tidy_data),perl = TRUE)
names(tidy_data) <- sub("Body","Body_",names(tidy_data),perl = TRUE,ignore.case=TRUE)
names(tidy_data) <- sub("Body_Body","Body_",names(tidy_data),perl = TRUE,ignore.case=TRUE)
names(tidy_data) <- sub("Gravity","Gravity_",names(tidy_data),perl = TRUE,ignore.case=TRUE)
names(tidy_data) <- sub("Gyro","Gyro_",names(tidy_data),perl = TRUE,ignore.case=TRUE)
names(tidy_data) <- sub("Jerk","Jerk_",names(tidy_data),perl = TRUE,ignore.case=TRUE)
names(tidy_data) <- sub("ACC","Acc_",names(tidy_data),perl = TRUE,ignore.case=TRUE)
names(tidy_data) <- gsub("___","_",names(tidy_data),perl = TRUE)
names(tidy_data) <- gsub("__","_",names(tidy_data),perl = TRUE)
names(tidy_data) <- sub("_Mean_Mean","_Mean",names(tidy_data),perl = TRUE,ignore.case=TRUE)
names(tidy_data) <- paste0("Avg_",names(tidy_data))
names(tidy_data) <- sub("Avg_Subject_ID","Subject_ID",names(tidy_data),perl = TRUE,ignore.case=TRUE)
names(tidy_data) <- sub("Avg_Activity","Activity",names(tidy_data),perl = TRUE,ignore.case=TRUE)