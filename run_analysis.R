# Getting and Cleaning Data Final Project
# JHU Data Science Specialization 
# Created:  4/26/15
# Updated:  4/26/15

# Set Working directory
setwd("../Desktop/UCI HAR Dataset")

library(data.table)
library(tidyr)
library(reshape2)
library(dplyr)
library(plyr)

####################################################
# Read in Variable Names, Label IDs, & Subject IDs #
####################################################

#Read in Features Data to Extract Variable Names
features_data <- read.table("./features.txt")
var_name <- as.character(features_data[,2])

#Read in Activity Labels and Rename Variables
activity_label <- read.table("./activity_labels.txt")
activity_label <- dplyr::rename(activity_label, ID = V1, Activity = V2)

#Read in Subject IDs to be merged in later
subject_ids_training <- read.table("./train/subject_train.txt")
subject_ids_training <- dplyr::rename(subject_ids_training, Subject_ID = V1)

#Read in Subject IDs to be merged in later
subject_ids_testing <- read.table("./test/subject_test.txt")
subject_ids_testing <- dplyr::rename(subject_ids_testing, Subject_ID = V1)

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
training_data_taccY <- read.table("./train/Inertial Signals/total_acc_y_train.txt")
training_data_taccZ <- read.table("./train/Inertial Signals/total_acc_z_train.txt")

names(training_data_taccX) <- gsub("V","Total_Acceleration_X-axis",names(training_data_taccX))
names(training_data_taccY) <- gsub("V","Total_Acceleration_Y-axis",names(training_data_taccY))
names(training_data_taccZ) <- gsub("V","Total_Acceleration_Z-axis",names(training_data_taccZ))

#Read and Rename Body Acceleration Data
training_data_baccX <- read.table("./train/Inertial Signals/body_acc_x_train.txt")
training_data_baccY <- read.table("./train/Inertial Signals/body_acc_y_train.txt")
training_data_baccZ <- read.table("./train/Inertial Signals/body_acc_z_train.txt")

names(training_data_baccX) <- gsub("V","Body_Acceleration_X-axis",names(training_data_baccX))
names(training_data_baccY) <- gsub("V","Body_Acceleration_Y-axis",names(training_data_baccY))
names(training_data_baccZ) <- gsub("V","Body_Acceleration_Z-axis",names(training_data_baccZ))

#Read and Rename Angular Velocity  Data
training_data_bvelX <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
training_data_bvelY <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
training_data_bvelZ <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")

names(training_data_bvelX) <- gsub("V","Body_Angular_Velocity_X-axis",names(training_data_bvelX))
names(training_data_bvelY) <- gsub("V","Body_Angular_Velocity_Y-axis",names(training_data_bvelY))
names(training_data_bvelZ) <- gsub("V","Body_Angular_Velocity_Z-axis",names(training_data_bvelZ))

#Create Combined Intertial Signals Data
training_intertial_signals_data<- cbind(training_data_taccX,training_data_taccY,
                                       training_data_taccZ,training_data_baccX,training_data_baccY,training_data_baccZ,
                                       training_data_bvelX,training_data_bvelY,training_data_bvelZ)
####################################
# Read And Clean Training Data Set #
####################################

#Read in Training Data with identified features
training_data_x <- read.table("./train/X_train.txt",col.names = var_name)

#Column Bind with Subject ID and Labels Data to create full training data set
training_dataset <- cbind(subject_ids_training,training_data_y_clean,
                          training_data_x,training_intertial_signals_data)

######################################################
# Read And Clean Testing Inertial Signals Data Sets  #
######################################################

#Read and Rename Total Acceleration Data
testing_data_taccX <- read.table("./test/Inertial Signals/total_acc_x_test.txt")
testing_data_taccY <- read.table("./test/Inertial Signals/total_acc_y_test.txt")
testing_data_taccZ <- read.table("./test/Inertial Signals/total_acc_z_test.txt")

names(testing_data_taccX) <- gsub("V","Total_Acceleration_X-axis",names(testing_data_taccX))
names(testing_data_taccY) <- gsub("V","Total_Acceleration_Y-axis",names(testing_data_taccY))
names(testing_data_taccZ) <- gsub("V","Total_Acceleration_Z-axis",names(testing_data_taccZ))

#Read and Rename Body Acceleration Data
testing_data_baccX <- read.table("./test/Inertial Signals/body_acc_x_test.txt")
testing_data_baccY <- read.table("./test/Inertial Signals/body_acc_y_test.txt")
testing_data_baccZ <- read.table("./test/Inertial Signals/body_acc_z_test.txt")

names(testing_data_baccX) <- gsub("V","Body_Acceleration_X-axis",names(testing_data_baccX))
names(testing_data_baccY) <- gsub("V","Body_Acceleration_Y-axis",names(testing_data_baccY))
names(testing_data_baccZ) <- gsub("V","Body_Acceleration_Z-axis",names(testing_data_baccZ))

#Read and Rename Angular Velocity  Data
testing_data_bvelX <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")
testing_data_bvelY <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")
testing_data_bvelZ <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")

names(testing_data_bvelX) <- gsub("V","Body_Angular_Velocity_X-axis",names(testing_data_bvelX))
names(testing_data_bvelY) <- gsub("V","Body_Angular_Velocity_Y-axis",names(testing_data_bvelY))
names(testing_data_bvelZ) <- gsub("V","Body_Angular_Velocity_Z-axis",names(testing_data_bvelZ))

#Create Combined Intertial Signals Data
testing_intertial_signals_data<- cbind(testing_data_taccX,testing_data_taccY,
                                testing_data_taccZ,testing_data_baccX,testing_data_baccY,testing_data_baccZ,
                                testing_data_bvelX,testing_data_bvelY,testing_data_bvelZ)

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

#Clean Average_Body_Acceleration_Time
Bacct1 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Body_Acc_X_Mean",
                        "Avg_Time_Body_Acc_Y_Mean", "Avg_Time_Body_Acc_Z_Mean"),
                        variable.name="Axis", value.name="Average_Body_Acceleration_Time")
Bacct1$Stat <- "Mean"

Bacct2 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Body_Acc_X_STD",
                        "Avg_Time_Body_Acc_Y_STD", "Avg_Time_Body_Acc_Z_STD"),
              variable.name="Axis", value.name="Average_Body_Acceleration_Time")

Bacct2$Stat <- "Standard_Deviation"

Bacct<-rbind(Bacct1,Bacct2)

Bacct$Axis<-as.character(Bacct$Axis)
Bacct$Axis[Bacct$Axis == "Avg_Time_Body_Acc_X_Mean"] <- "X"
Bacct$Axis[Bacct$Axis == "Avg_Time_Body_Acc_Y_Mean"] <- "Y"
Bacct$Axis[Bacct$Axis == "Avg_Time_Body_Acc_Z_Mean"] <- "Z"
Bacct$Axis[Bacct$Axis == "Avg_Time_Body_Acc_X_STD"] <- "X"
Bacct$Axis[Bacct$Axis == "Avg_Time_Body_Acc_Y_STD"] <- "Y"
Bacct$Axis[Bacct$Axis == "Avg_Time_Body_Acc_Z_STD"] <- "Z"

#Clean Average_Gravity_Acceleration_Time
Gacct1 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Gravity_Acc_X_Mean",
    "Avg_Time_Gravity_Acc_Y_Mean", "Avg_Time_Gravity_Acc_Z_Mean"),
               variable.name="Axis", value.name="Average_Gravity_Acceleration_Time")
Gacct1$Stat <- "Mean"

Gacct2 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Gravity_Acc_X_STD",
    "Avg_Time_Gravity_Acc_Y_STD", "Avg_Time_Gravity_Acc_Z_STD"),
               variable.name="Axis", value.name="Average_Gravity_Acceleration_Time")

Gacct2$Stat <- "Standard_Deviation"

Gacct<-rbind(Gacct1,Gacct2)

Gacct$Axis<-as.character(Gacct$Axis)
Gacct$Axis[Gacct$Axis == "Avg_Time_Gravity_Acc_X_Mean"] <- "X"
Gacct$Axis[Gacct$Axis == "Avg_Time_Gravity_Acc_Y_Mean"] <- "Y"
Gacct$Axis[Gacct$Axis == "Avg_Time_Gravity_Acc_Z_Mean"] <- "Z"
Gacct$Axis[Gacct$Axis == "Avg_Time_Gravity_Acc_X_STD"] <- "X"
Gacct$Axis[Gacct$Axis == "Avg_Time_Gravity_Acc_Y_STD"] <- "Y"
Gacct$Axis[Gacct$Axis == "Avg_Time_Gravity_Acc_Z_STD"] <- "Z"


#Clean Average_Body_Acceleration_Jerk_Time
Baccjt1 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Body_Acc_Jerk_X_Mean",
    "Avg_Time_Body_Acc_Jerk_Y_Mean", "Avg_Time_Body_Acc_Jerk_Z_Mean"),
               variable.name="Axis", value.name="Average_Body_Acceleration_Jerk_Time")
Baccjt1$Stat <- "Mean"

Baccjt2 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Body_Acc_Jerk_X_STD",
    "Avg_Time_Body_Acc_Jerk_Y_STD", "Avg_Time_Body_Acc_Jerk_Z_STD"),
               variable.name="Axis", value.name="Average_Body_Acceleration_Jerk_Time")

Baccjt2$Stat <- "Standard_Deviation"

Baccjt<-rbind(Baccjt1,Baccjt2)

Baccjt$Axis<-as.character(Baccjt$Axis)
Baccjt$Axis[Baccjt$Axis == "Avg_Time_Body_Acc_Jerk_X_Mean"] <- "X"
Baccjt$Axis[Baccjt$Axis == "Avg_Time_Body_Acc_Jerk_Y_Mean"] <- "Y"
Baccjt$Axis[Baccjt$Axis == "Avg_Time_Body_Acc_Jerk_Z_Mean"] <- "Z"
Baccjt$Axis[Baccjt$Axis == "Avg_Time_Body_Acc_Jerk_X_STD"] <- "X"
Baccjt$Axis[Baccjt$Axis == "Avg_Time_Body_Acc_Jerk_Y_STD"] <- "Y"
Baccjt$Axis[Baccjt$Axis == "Avg_Time_Body_Acc_Jerk_Z_STD"] <- "Z"


#Clean Average_Body_Gyroscope_Time
Bgt1 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Body_Gyro_X_Mean",
    "Avg_Time_Body_Gyro_Y_Mean", "Avg_Time_Body_Gyro_Z_Mean"),
                variable.name="Axis", value.name="Average_Body_Gyroscope_Time")
Bgt1$Stat <- "Mean"

Bgt2 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Body_Gyro_X_STD",
    "Avg_Time_Body_Gyro_Y_STD", "Avg_Time_Body_Gyro_Z_STD"),
                variable.name="Axis", value.name="Average_Body_Gyroscope_Time")

Bgt2$Stat <- "Standard_Deviation"

Bgt<-rbind(Bgt1,Bgt2)

Bgt$Axis<-as.character(Bgt$Axis)
Bgt$Axis[Bgt$Axis == "Avg_Time_Body_Gyro_X_Mean"] <- "X"
Bgt$Axis[Bgt$Axis == "Avg_Time_Body_Gyro_Y_Mean"] <- "Y"
Bgt$Axis[Bgt$Axis == "Avg_Time_Body_Gyro_Z_Mean"] <- "Z"
Bgt$Axis[Bgt$Axis == "Avg_Time_Body_Gyro_X_STD"] <- "X"
Bgt$Axis[Bgt$Axis == "Avg_Time_Body_Gyro_Y_STD"] <- "Y"
Bgt$Axis[Bgt$Axis == "Avg_Time_Body_Gyro_Z_STD"] <- "Z"

#Clean Average_Body_Gyroscope_Jerk_Time
Bgjt1 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Body_Gyro_Jerk_X_Mean",
    "Avg_Time_Body_Gyro_Jerk_Y_Mean", "Avg_Time_Body_Gyro_Jerk_Z_Mean"),
             variable.name="Axis", value.name="Average_Body_Gyroscope_Jerk_Time")
Bgjt1$Stat <- "Mean"

Bgjt2 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Body_Gyro_Jerk_X_STD",
    "Avg_Time_Body_Gyro_Jerk_Y_STD", "Avg_Time_Body_Gyro_Jerk_Z_STD"),
             variable.name="Axis", value.name="Average_Body_Gyroscope_Jerk_Time")

Bgjt2$Stat <- "Standard_Deviation"

Bgjt<-rbind(Bgjt1,Bgjt2)


Bgjt$Axis<-as.character(Bgjt$Axis)
Bgjt$Axis[Bgjt$Axis == "Avg_Time_Body_Gyro_Jerk_X_Mean"] <- "X"
Bgjt$Axis[Bgjt$Axis == "Avg_Time_Body_Gyro_Jerk_Y_Mean"] <- "Y"
Bgjt$Axis[Bgjt$Axis == "Avg_Time_Body_Gyro_Jerk_Z_Mean"] <- "Z"
Bgjt$Axis[Bgjt$Axis == "Avg_Time_Body_Gyro_Jerk_X_STD"] <- "X"
Bgjt$Axis[Bgjt$Axis == "Avg_Time_Body_Gyro_Jerk_Y_STD"] <- "Y"
Bgjt$Axis[Bgjt$Axis == "Avg_Time_Body_Gyro_Jerk_Z_STD"] <- "Z"

##################


#Clean Average_Body_Acceleration_Freq
Baccf1 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Freq_Body_Acc_X_Mean",
    "Avg_Freq_Body_Acc_Y_Mean", "Avg_Freq_Body_Acc_Z_Mean"),
               variable.name="Axis", value.name="Average_Body_Acceleration_Freq")
Baccf1$Stat <- "Mean"

Baccf2 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Freq_Body_Acc_X_STD",
    "Avg_Freq_Body_Acc_Y_STD", "Avg_Freq_Body_Acc_Z_STD"),
               variable.name="Axis", value.name="Average_Body_Acceleration_Freq")

Baccf2$Stat <- "Standard_Deviation"

Baccf<-rbind(Baccf1,Baccf2)


Baccf$Axis<-as.character(Baccf$Axis)
Baccf$Axis[Baccf$Axis == "Avg_Freq_Body_Acc_X_Mean"] <- "X"
Baccf$Axis[Baccf$Axis == "Avg_Freq_Body_Acc_Y_Mean"] <- "Y"
Baccf$Axis[Baccf$Axis == "Avg_Freq_Body_Acc_Z_Mean"] <- "Z"
Baccf$Axis[Baccf$Axis == "Avg_Freq_Body_Acc_X_STD"] <- "X"
Baccf$Axis[Baccf$Axis == "Avg_Freq_Body_Acc_Y_STD"] <- "Y"
Baccf$Axis[Baccf$Axis == "Avg_Freq_Body_Acc_Z_STD"] <- "Z"

#Clean Average_Body_Acceleration_Jerk_Freq
Baccjf1 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Freq_Body_Acc_Jerk_X_Mean",
    "Avg_Freq_Body_Acc_Jerk_Y_Mean", "Avg_Freq_Body_Acc_Jerk_Z_Mean"),
                variable.name="Axis", value.name="Average_Body_Acceleration_Jerk_Freq")
Baccjf1$Stat <- "Mean"

Baccjf2 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Freq_Body_Acc_Jerk_X_STD",
    "Avg_Freq_Body_Acc_Jerk_Y_STD", "Avg_Freq_Body_Acc_Jerk_Z_STD"),
                variable.name="Axis", value.name="Average_Body_Acceleration_Jerk_Freq")

Baccjf2$Stat <- "Standard_Deviation"

Baccjf<-rbind(Baccjf1,Baccjf2)

Baccjf$Axis<-as.character(Baccjf$Axis)
Baccjf$Axis[Baccjf$Axis == "Avg_Freq_Body_Acc_Jerk_X_Mean"] <- "X"
Baccjf$Axis[Baccjf$Axis == "Avg_Freq_Body_Acc_Jerk_Y_Mean"] <- "Y"
Baccjf$Axis[Baccjf$Axis == "Avg_Freq_Body_Acc_Jerk_Z_Mean"] <- "Z"
Baccjf$Axis[Baccjf$Axis == "Avg_Freq_Body_Acc_Jerk_X_STD"] <- "X"
Baccjf$Axis[Baccjf$Axis == "Avg_Freq_Body_Acc_Jerk_Y_STD"] <- "Y"
Baccjf$Axis[Baccjf$Axis == "Avg_Freq_Body_Acc_Jerk_Z_STD"] <- "Z"

#Clean Average_Body_Gyroscope_Freq
Bgf1 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Freq_Body_Gyro_X_Mean",
    "Avg_Freq_Body_Gyro_Y_Mean", "Avg_Freq_Body_Gyro_Z_Mean"),
             variable.name="Axis", value.name="Average_Body_Gyroscope_Freq")
Bgf1$Stat <- "Mean"

Bgf2 <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Freq_Body_Gyro_X_STD",
    "Avg_Freq_Body_Gyro_Y_STD", "Avg_Freq_Body_Gyro_Z_STD"),
             variable.name="Axis", value.name="Average_Body_Gyroscope_Freq")

Bgf2$Stat <- "Standard_Deviation"

Bgf<-rbind(Bgf1,Bgf2)


Bgf$Axis<-as.character(Bgf$Axis)
Bgf$Axis[Bgf$Axis == "Avg_Freq_Body_Gyro_X_Mean"] <- "X"
Bgf$Axis[Bgf$Axis == "Avg_Freq_Body_Gyro_Y_Mean"] <- "Y"
Bgf$Axis[Bgf$Axis == "Avg_Freq_Body_Gyro_Z_Mean"] <- "Z"
Bgf$Axis[Bgf$Axis == "Avg_Freq_Body_Gyro_X_STD"] <- "X"
Bgf$Axis[Bgf$Axis == "Avg_Freq_Body_Gyro_Y_STD"] <- "Y"
Bgf$Axis[Bgf$Axis == "Avg_Freq_Body_Gyro_Z_STD"] <- "Z"

#Clean Average_Angle_Gravity
Ag <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Angle_X_Gravity_Mean",
    "Avg_Angle_Y_Gravity_Mean", "Avg_Angle_Z_Gravity_Mean"),
              variable.name="Axis", value.name="Average_Angle_Gravity")
Ag$Stat <- "Mean"

Ag$Axis<-as.character(Ag$Axis)
Ag$Axis[Ag$Axis == "Avg_Angle_X_Gravity_Mean"] <- "X"
Ag$Axis[Ag$Axis == "Avg_Angle_Y_Gravity_Mean"] <- "Y"
Ag$Axis[Ag$Axis == "Avg_Angle_Z_Gravity_Mean"] <- "Z"


#############



#Clean Average_Body_Acceration_Magnitude_Time
Bamt <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Body_Acc_Mag_Mean",
        "Avg_Time_Body_Acc_Mag_STD"),variable.name="Stat", value.name="Average_Body_Acceleration_Magnitude_Time")

Bamt$Stat<-as.character(Bamt$Stat)
Bamt$Stat[Bamt$Stat == "Avg_Time_Body_Acc_Mag_Mean"] <- "Mean"
Bamt$Stat[Bamt$Stat == "Avg_Time_Body_Acc_Mag_STD"] <- "Standard_Deviation"


#Clean Average_Gravity_Acceration_Magnitude_Time
Gamt <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Gravity_Acc_Mag_Mean",
    "Avg_Time_Gravity_Acc_Mag_STD"),variable.name="Stat", value.name="Average_Gravity_Acceleration_Magnitude_Time")

Gamt$Stat<-as.character(Gamt$Stat)
Gamt$Stat[Gamt$Stat == "Avg_Time_Gravity_Acc_Mag_Mean"] <- "Mean"
Gamt$Stat[Gamt$Stat == "Avg_Time_Gravity_Acc_Mag_STD"] <- "Standard_Deviation"


#Clean Average_Body_Acceleration_Magnitude_Jerk_Time
Bamjt <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Body_Acc_Jerk_Mag_Mean",
    "Avg_Time_Body_Acc_Jerk_Mag_STD"),variable.name="Stat", value.name="Average_Body_Acceleration_Magnitude_Jerk_Time")

Bamjt$Stat<-as.character(Bamjt$Stat)
Bamjt$Stat[Bamjt$Stat == "Avg_Time_Body_Acc_Jerk_Mag_Mean"] <- "Mean"
Bamjt$Stat[Bamjt$Stat == "Avg_Time_Body_Acc_Jerk_Mag_STD"] <- "Standard_Deviation"

#Clean Average_Body_Gyroscope_Magnitude_Time
Bgmt <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Body_Gyro_Mag_Mean",
    "Avg_Time_Body_Gyro_Mag_STD"),variable.name="Stat", value.name="Average_Body_Gyroscope_Magnitude_Time")

Bgmt$Stat<-as.character(Bgmt$Stat)
Bgmt$Stat[Bgmt$Stat == "Avg_Time_Body_Gyro_Mag_Mean"] <- "Mean"
Bgmt$Stat[Bgmt$Stat == "Avg_Time_Body_Gyro_Mag_STD"] <- "Standard_Deviation"


#Clean Average_Body_Gyroscope_Magnitude_Jerk_Time
Bgmjt <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Time_Body_Gyro_Jerk_Mag_Mean",
    "Avg_Time_Body_Gyro_Jerk_Mag_STD"),variable.name="Stat", value.name="Average_Body_Gyroscope_Magnitude_Jerk_Time")

Bgmjt$Stat<-as.character(Bgmjt$Stat)
Bgmjt$Stat[Bgmjt$Stat == "Avg_Time_Body_Gyro_Jerk_Mag_Mean"] <- "Mean"
Bgmjt$Stat[Bgmjt$Stat == "Avg_Time_Body_Gyro_Jerk_Mag_STD"] <- "Standard_Deviation"


#Clean Average_Body_Acceleration_Magnitude_Frequency
Bamf <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Freq_Body_Acc_Mag_Mean",
    "Avg_Freq_Body_Acc_Mag_STD"),variable.name="Stat", value.name="Average_Body_Acceleration_Magnitude_Frequency")

Bamf$Stat<-as.character(Bamf$Stat)
Bamf$Stat[Bamf$Stat == "Avg_Freq_Body_Acc_Mag_Mean"] <- "Mean"
Bamf$Stat[Bamf$Stat == "Avg_Freq_Body_Acc_Mag_STD"] <- "Standard_Deviation"

#Clean Average_Body_Acceleration_Magnitude_Jerk_Frequency
Bamjf <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Freq_Body_Acc_Jerk_Mag_Mean",
    "Avg_Freq_Body_Acc_Jerk_Mag_STD"),variable.name="Stat", value.name="Average_Body_Acceleration_Magnitude_Jerk_Frequency")

Bamjf$Stat<-as.character(Bamjf$Stat)
Bamjf$Stat[Bamjf$Stat == "Avg_Freq_Body_Acc_Jerk_Mag_Mean"] <- "Mean"
Bamjf$Stat[Bamjf$Stat == "Avg_Freq_Body_Acc_Jerk_Mag_STD"] <- "Standard_Deviation"

#Clean Average_Body_Gyroscope_Magnitude_Frequency
Bgmf <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Freq_Body_Gyro_Mag_Mean",
    "Avg_Freq_Body_Gyro_Mag_STD"),variable.name="Stat", value.name="Average_Body_Gyroscope_Magnitude_Frequency")

Bgmf$Stat<-as.character(Bgmf$Stat)
Bgmf$Stat[Bgmf$Stat == "Avg_Freq_Body_Gyro_Mag_Mean"] <- "Mean"
Bgmf$Stat[Bgmf$Stat == "Avg_Freq_Body_Gyro_Mag_STD"] <- "Standard_Deviation"

#Clean Average_Body_Gyroscope_Magnitude_Jerk_Frequency
Bgmjf <- melt(tidy_data, id=c("Subject_ID","Activity"),measure.vars=c("Avg_Freq_Body_Gyro_Jerk_Mag_Mean",
    "Avg_Freq_Body_Gyro_Jerk_Mag_STD"),variable.name="Stat", value.name="Average_Body_Gyroscope_Magnitude_Jerk_Frequency")

Bgmjf$Stat<-as.character(Bgmjf$Stat)
Bgmjf$Stat[Bgmjf$Stat == "Avg_Freq_Body_Gyro_Jerk_Mag_Mean"] <- "Mean"
Bgmjf$Stat[Bgmjf$Stat == "Avg_Freq_Body_Gyro_Jerk_Mag_STD"] <- "Standard_Deviation"

dfs<-list(Bacct,Gacct,Baccjt,Bgt,Bgjt,Baccf,Baccjf,Bgf,Ag)

dfs2<-list(Bamt,Gamt,Bamjt,Bgmt,Bgmjt,Bamf,Bamjf,Bgmf,Bgmjf)

#Combine All Vars
cleaned_vars <- join_all(dfs, by=c("Subject_ID","Activity","Axis","Stat"))
cleaned_vars2 <- join_all(dfs2, by=c("Subject_ID","Activity","Stat"))
final_tidy_data <- merge(cleaned_vars,cleaned_vars2)
final_tidy_data<- arrange(cleaned_vars, Subject_ID, Activity)
