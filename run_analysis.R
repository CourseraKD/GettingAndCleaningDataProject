# Coursera Getting and Cleaning Data

# Course Project

# You should create one R script called run_analysis.R that does the following. 
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
#       for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, 
#       independent tidy data set with the average of each variable 
#       for each activity and each subject.

# test/Y_test.txt is a file with the index of 
#       the activity for each row of the Inertial Signal files. 
# test/subject_test.txt is a file with the subject 
#       for each row of the Inertial Signal files.
# Add columns activities$activity[ActivityIndexes] and 
#       subjectTest$subject 
#  to each of the 9 test Inertial Signal files 
# (each of which has 128 cols corresponding to the 128 readings 
# per "window" mentioned in file README.txt).
# Do the same for the Training data then concatenate (rbind())
#  test and training files.
# I'm not sure how to join/merge the 9 files into one because 
# there are 128 columns in each file. 
# Do I really flatten each file to three columns: activity, measurement, 
# index (1:128)?
# I also don't know what the X_test and X_train files are for and
# I don't know where the 561 features are located in the data.
# So far, none of the number of rows or columns are evenly divided
# by 561. 

{
# ---- ReadData ------------------------------------------------------  
cat("\014")

#rm(list=ls())
#setwd("/Users/kevan/Documents/Coursera/DataScienceSpecialization/03-GettingAndCleaningData/Project")

ip <- as.data.frame(installed.packages())
if (!("dplyr" %in% ip$Package)) {
    print("Please run 'install.package 'dplyr for this script to work.")
    print("Quitting!")
    stop()
}
library(dplyr)
rm(ip)

# IS  - Inertial Signals
# TSTS - Test Signals
# TRNS - Train Signals

srcs <- c("test", "train")

# --- -------------------------------------------------------
# --- Get activity names and indexes
# --- -------------------------------------------------------
msg <- "A. Getting activity names and indexes"
print.noquote(msg)
fname <- "./UCI HAR Dataset/activity_labels.txt"
activities <- read.table(file = fname, sep = " ")
colnames(activities) <- c("index", "activity")


# --- -------------------------------------------------------
# --- Get features and indexes
# --- -------------------------------------------------------
msg <- "B. Getting features"
print.noquote(msg)
fname <- "./UCI HAR Dataset/features.txt"
features <- read.table(file = fname, sep = " ")
colnames(features) <- c("index", "feature")
rm(fname)


# --- -------------------------------------------------------
# --- Get features that are means and standard deviations
# --- -------------------------------------------------------
msg <- "C. Getting mean and standard deviation features"
print.noquote(msg)
msg <- "   This is needed for step 2 of the project instructions"
print.noquote(msg)

pat <- "mean|std"
features_ms_rows <- grepl(pattern = pat, x = features$feature, 
                    ignore.case = FALSE
)
features_ms_names <- as.character(features$feature[features_ms_rows])

rm(pat)

# --- -------------------------------------------------------
# --- Get Inertial Signal data
# --- -------------------------------------------------------
# As far as I can tell, we don't need the Inertial Signal data.
# msg <- "D. Getting Inertial Signal data"
# print.noquote(msg)
# signals <- c("body_acc", "body_gyro", "total_acc")
# axes <- c(rep("x", 3), rep("y", 3), rep("z", 3))
# strIS <- paste(signals, axes, sep = "_")
# 
# strNamesTSTS <- paste(
#     "./UCI HAR Dataset/test/Inertial Signals/", 
#     strIS, "_", rep("test", 9), ".txt", sep = ""
# )
# 
# strNamesTRNS <- paste(
#     "./UCI\ HAR\ Dataset/train/Inertial\ Signals/", 
#     strIS, "_", rep("train", 9), ".txt", sep = ""
# )
# 
# 
# lstInertialData <- lapply(1:2, function(x) {
#     fnames <- paste(
#         "./UCI HAR Dataset/", srcs[x], "/Inertial Signals/", 
#         strIS, "_", rep(srcs[x], 9), ".txt", sep = ""
#     )
#     lapply(x, function(fs) {
#         lapply(fs, read.table)
#     }
#     )
# }
# )


# --- -------------------------------------------------------
# --- Get activity indexes
# --- -------------------------------------------------------
msg <- "E. Getting activity indexes"
print.noquote(msg)
fnames <- paste(
    "./UCI HAR Dataset/", srcs, 
    "/y_", srcs, ".txt", sep = ""
)

lstActivityIndexes <- lapply(1:2, function(x) {
    ai <- read.table(file = fnames[x], sep = " ", fill = TRUE)
    # return a vector, not a data frame
    ai[, 1]
}
)


# --- -------------------------------------------------------
# --- Get subject ID data
# --- -------------------------------------------------------
msg <- "F. Getting subject ids"
print.noquote(msg)
fnames <- paste( 
    "./UCI HAR Dataset/", srcs, 
    "/subject_", srcs, ".txt", sep = ""
)

lstsubjectids <- lapply(1:2, function(x) {
    read.table(file = fnames[x], sep = " ")
}
)
names(lstsubjectids) <- srcs
# Changes values to factors. The actual number of each subject
# is not a numeric value, it is only a code for the subject.
lstsubjectids[[1]][,1] <- as.factor((lstsubjectids[[1]][,1]))
lstsubjectids[[2]][,1] <- as.factor((lstsubjectids[[2]][,1]))


# --- -------------------------------------------------------
# --- Get X data
# --- -------------------------------------------------------
if (!exists("lstX_ORIG")) {
    msg <- "G. Getting X data"
    print.noquote(msg)
    fnames <- paste(
        "./UCI HAR Dataset/", srcs, 
        "/X_", srcs, ".txt", sep = ""
    )
    
    system.time(
    lstX <- lapply(1:2, function(x) {
    # Using fread crashes both RStudio and R, so I use read.table()
        #    fread(input = fnames[x])
        read.table(file = fnames[x], sep = "", fill = TRUE)
    }
    )
    )
    lstX_ORIG <- lstX
} else {
    msg <- "G. Already have X data"
    print.noquote(msg)
    lstX <- lstX_ORIG
}
rm(fnames)


# --- -------------------------------------------------------
# --- Subset X data to get mean and standard deviations only
# --- -------------------------------------------------------
# NOTE: I subset first and then apply column names because some
#       of the features are repeated: there are 3 features with the same
#       name for the 'bandsEnergy()' features.
msg <- "H. Subsetting X data to get only mean and standard deviation columns"
print.noquote(msg)
msg <- "    This is step 2 out of 5 of the project instructions"
print.noquote(msg)
lstX <- lapply(lstX, function(x) {
    x[, features_ms_rows]
}
)


# --- -------------------------------------------------------
# --- Add column names (features) to X data
# --- -------------------------------------------------------
msg <- "I. Adding column names to X data"
print.noquote(msg)
msg <- "    This is step 4 out of 5 of the project instructions"
print.noquote(msg)
lstX <- lapply(lstX, function(x) {
    colnames(x) <- features_ms_names
    x
}
)
rm(features, features_ms_names, features_ms_rows)

# --- -------------------------------------------------------
# --- Add subject IDs column to X data
# --- -------------------------------------------------------
msg <- "J. Adding subject id column to X data (needed for step 5)"
print.noquote(msg)
addcols <- function(x, y, xname) {
    dfnew <- cbind(x, y)
    colnames(dfnew)[1] <- xname
    dfnew
}

lstX <- mapply(addcols, lstsubjectids, lstX, "SubjectID", 
                SIMPLIFY = FALSE)
rm(lstsubjectids)

# --- -------------------------------------------------------
# --- Add activity names column to X data
# --- -------------------------------------------------------
msg <- "K. Adding activity name column to X data"
print.noquote(msg)
msg <- "    This is step 3 out of 5 of the project instructions"
print.noquote(msg)
addcols <- function(x, y, xname) {
    dfnew <- cbind(x, y)
    colnames(dfnew)[1] <- xname
    dfnew
}

# In the following, match(lstActivityIndexes, activities$index)
# returns the row number of activities$index that 
# matches the X data activity index. That row number, 
# put as an index into activities$activity[...],
# returns the activity description (string).
# Thus we transform the activity indexes into activity names

#lstact <- mapply(match, lstActivityIndexes, activities$label)
lstact <- lapply(lstActivityIndexes, function(x) {
    activities$activity[match(x, activities$index)]
})

lstX <- mapply(addcols, lstact, lstX, "Activity", SIMPLIFY = FALSE)
rm(srcs, activities, lstActivityIndexes, addcols, lstact)

# --- -------------------------------------------------------
# --- Concatenate the train and test tables
# --- -------------------------------------------------------
msg <- "L. Merging the two data sets"
print.noquote(msg)
msg <- "    This is step 1 out of 5 of the project instructions"
print.noquote(msg)
tblX <- do.call(rbind, lstX)
rm(lstX)


# --- -------------------------------------------------------
# --- Generate 2nd tidy data set with averages
# --- -------------------------------------------------------
msg <- "M. Generating 2nd tidy data set with averages by activity and subject"
print.noquote(msg)
msg <- "    This is step 1 out of 5 of the project instructions"
print.noquote(msg)
tblXavg <- group_by(tblX, Activity, SubjectID)
tblXavg <- summarise_each(tblXavg, funs(mean))

# --- -------------------------------------------------------
# --- Output data files
# --- -------------------------------------------------------
# msg <- "N. Saving data tables in .RData and .txt format"
# print.noquote(msg)
# save(tblX, file="tblX.RData")
# save(tblXavg, file="tblXavg.RData")
# write.table(tblX, file = "tblX.txt")
# write.table(tblXavg, file = "tblXavg.txt")


# --- -------------------------------------------------------
# --- Cleanup
# --- -------------------------------------------------------
rm(msg)

}