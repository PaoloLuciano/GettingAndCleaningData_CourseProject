#
# Data Science Specialization - Getting and Cleaning Data
# 
# Courser Project
#
# March 2015
#
# In this project we collect and clean data from a study performed in UCI for wearable computing.
# The data was obtained from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#
#---------------------------------

#0. Preamble
#-------------------------------------------------------------------------------------------------------
library(dplyr)
library(reshape2)

#1. Getting Data
#-------------------------------------------------------------------------------------------------------

    # First we get the data and extract the files. 
    # For simplicity, both the .zip and the extracted files will be in the same dir

if(!file.exists("UCI HAR Dataset")) #UCI HAR Dataset must be a folder
{
    dir.create("UCI HAR Dataset")
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, destfile = "UCI HAR Dataset/UCI HAR Dataset.zip", mode = "wb")
    unzip("UCI HAR Dataset/UCI HAR Dataset.zip", overwrite = TRUE)
}

#2. Reading the relevant data
#-------------------------------------------------------------------------------------------------------

    #2.1 Reading measurments
X_test <-  read.table("UCI HAR Dataset/test/X_test.txt")             #Test Set -  Test Values
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt")              #Test Labels - Activity labels
S_test <- read.table("UCI HAR Dataset/test/subject_test.txt")        #Test Subjects - Test participants 
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")           #Training Set - Train Values
Y_train <- read.table("UCI HAR Dataset/train/y_train.txt")           #Training Label - Activity labels
S_train <- read.table("UCI HAR Dataset/train/subject_train.txt")     #Training Subjects - Test participants 

    #2.2 Reading Labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt") #Labels
features_labels <- read.table("UCI HAR Dataset/features.txt")        #Measurments

#3. Merging the data and naming everyhting
#-------------------------------------------------------------------------------------------------------

    #3.1 Naming and clasifying data
names(activity_labels) <- c("number", "activity")
names(features_labels) <- c("id", "features")

        #Activities
names(Y_test) <- "act_number"
names(Y_train) <- "act_number" 

        #Subjects
names(S_train) <- "subject"
names(S_test) <- "subject"

    #3.2 Puting pieces together
        #Since merge unorders the data we need to keep track of the original indexes and the return the data to its original order once merged
Y_test$id <- c(1:length(Y_test$act_number))
Y_test <- merge(Y_test, activity_labels, by.x = "act_number", by.y = "number", sort = F, )
Y_test <- Y_test[order(Y_test$id),]
Y_test <- Y_test[c("act_number", "activity")]

        #Analogus to the train set
Y_train$id <- c(1:length(Y_train$act_number))
Y_train <- merge(Y_train, activity_labels, by.x = "act_number", by.y = "number", sort = F, )
Y_train <- Y_train[order(Y_train$id),]
Y_train <- Y_train[c("act_number", "activity")]

        #Naming Features
names(X_test) <- features_labels$features
names(X_train) <- features_labels$features

        #Creating 2 data frames
test <- cbind(S_test, Y_test, X_test)
train <- cbind(S_train, Y_train, X_train)

        #Creating a final data frame with everyting on it.
data <- rbind(test,train) 
        
        #Revising the data Frame
        #NOTE: We can't arrange the data frame, the way we would like to because of a bug detecting repeated columns in the arrange func (dplyr).
data[1:100,c(1,2,3)]
data[10290:10299, c(1,2,3)] #We only revise the first 3 relevant columns

        #Saving the full un-ordenred data set for future references and removing all that we don't need to free RAM
write.csv(data, file = "full_data_set.csv")
rm(S_test)
rm(S_train)
rm(X_test)
rm(X_train)
rm(Y_test)
rm(Y_train)
rm(test, train)
rm(activity_labels, features_labels)

#4. Obtaining relevant mean and sd columns
#-------------------------------------------------------------------------------------------------------
    
    #4.1 Getting the indexes of the mean and standar deviation columns
std_index  <- grep("std", names(data))
mean_index  <- grep("mean", names(data))
index <- c(std_index, mean_index)
index <- index[order(index)]

        #We want to include the firs three columns of the data set that contain the participants and the activity
index <- c(1,2,3,index)

    #4.2 Thinning the big data set
data.1 <- data[ , index]

    #4.3 Ordering
        #Having eliminated the problematic columns we can order our data
        #Since we are dealing with 30 participants each with 6 activities it would be natural to arrange it in that order
data.1 <- arrange(data.1, subject, act_number)
write.csv(data.1, file = "relevant_data.csv")

#5. Summarizing the data
#-------------------------------------------------------------------------------------------------------

    #5.1 Metling the data according to the features
        #We extract the columns to melt
features_names <- names(data.1)
features_names <- features_names[c(4:length(features_names))]
clean_data <- melt(data.1, id = c("subject", "activity"), measure.var = features_names)

    #5.2 Summarasing and obtaining the mean and getting our final data set
clean_data <- summarise(group_by(clean_data, subject, activity, variable), mean_features = mean(value))

    #5.3 Creating a text file
write.csv(clean_data, file = "clean_data.csv")
write.table(clean_data, file = "clean_data.txt" , row.name = FALSE)




