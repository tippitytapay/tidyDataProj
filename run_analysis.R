# Load necessary packages
library(data.table)
library(dplyr)

# This function creates the table tidyMeanTable.txt when run in the working
# directory containing the decompressed folder containing the raw data,
# UCI HAR Dataset. The output is written to that directory.

createTidyData = function() {

        # Load the necessary raw data:
        
        X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
        y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
        subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
        X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
        y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
        subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
        features <- read.table("UCI HAR Dataset/features.txt")
        
        # Combine the training and test sets:
        
        X_all <- rbind(X_train, X_test)
        y_all <- rbind(y_train, y_test)
        subject_all <- rbind(subject_train, subject_test)
        
        # Endow the data (X_all) with its variable (column) names:
        
        colnames(X_all) <- make.names(features[,2], unique = TRUE)
        
        # Extract all means and stds:
        
        X_meanAndstd <- select(X_all, contains("mean", ignore.case = TRUE),
                               contains("std", ignore.case = TRUE))
        
        # Replace integer values in activity labels (y_all) with descriptive names:
        
        y_names <- y_all
        
        y_names[y_names == 1] <- "Walking"
        y_names[y_names == 2] <- "Walking_Upstairs"
        y_names[y_names == 3] <- "Walking_Downstairs"
        y_names[y_names == 4] <- "Sitting"
        y_names[y_names == 5] <- "Standing"
        y_names[y_names == 6] <- "Laying"
        
        # Combine subject labels, activity names, and mean/std data, and name the
        # first two columns:
        
        tidyData <- cbind(subject_all, y_names, X_meanAndstd)
        colnames(tidyData)[1:2] <- c("Subject", "Activity")
        
        # Create the desired tables of averages:
        
        meansTable <- aggregate(.~ Subject + Activity, tidyData, mean)
        
        # Write the output file:
        
        write.table(meansTable, file = "tidyMeansTable.txt", row.names = FALSE)
}