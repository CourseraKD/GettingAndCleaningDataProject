#Codebook#

##Summary##

This Codebook is a description of the variables, the data, and transformations to clean up and make tidy the data presented in [Human Activity Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) from UCI (UCI stands for [University of California at Irvine](http://www.ics.uci.edu/))

---

##Background##

The abstract for the data is: Abstract: Human Activity Recognition **database** built from the recordings of 30 **subjects** performing **activities** of daily living (ADL) while carrying a waist-mounted smartphone with embedded **inertial sensors**. 

There is no mention in either the abstract or the data description (README.txt) file as to the purpose for collecting the data.
    
The [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) were taken from the [Coursera](https://www.coursera.org/) site for the class [Getting and Cleaning data](https://www.coursera.org/course/getdata), part of their [Data Science Specialization](https://www.coursera.org/specialization/jhudatascience/1).

---

##Variables##
The variables are defined in the file features_info.txt and their names are listed in the features.txt file. They are **summary values** of the raw data located in the Inertial Signals folders (see section Data Sets below for a longer description of the raw data values), consisting of acclerometer (**accel**) and gyroscope (**gyro**) measurements for 3 axes (X, Y, Z) taken from mobile phones attached to **subjects** that engaged in a variety of activities for a certain amount of time. 

The acceleration signal was separated into **body** and **gravity** acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

The body linear acceleration and angular velocity were derived in time to obtain **Jerk** signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).

The **magnitude** of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals)

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

###List of values derived from raw data###
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

###List of values calculated from the derived values###
* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors

###List of additional values###
These were obtained by averaging the signals in a signal window sample. These are used on the angle() variable

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

###Variable Names###
The variable names are listed in features.txt and are made up of from the lists of values and calculations above. The names are descriptive enough, and there are so many of them, it seems most useful to use the names as they are given in the features.txt file.

Example: tBodyAcc-max()-Z is the value of the maximum Body Acceleration in the time domain in the Z axis.

---

##Data##

The UCI data is broken into two sets of data, one used for training and one used for testing [training refers to the development of models that describe relations bewteen the data variables and the models would then be validated with the test data set; the UCI data does not include models]. 

###Data Sets###

* train (in folder train)
* test (in folder test)

Each data set has the same format and consists of two **data components** and several files to **index** and **label** the data. 

The two **data components** in each data set are 

* raw measurements (9 files for each data set located in the Inertial Signals folders)
    * each train raw measurement file has 7352 rows and 128 columns
    * each test raw measurement file has 2947 rows and 128 columns
    * the 128 columns (described in the README.txt file for the data) are acclerometer (accel) and gyroscope (gyro) measurements for 3 axes (X, Y, Z) taken from mobile phones attached to "subjects" that engaged in a variety of activities for a certain amount of time. (What follows is taken from the data's README.txt file). The measurements selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.  
* derived data (consists of values derived from the raw measurements [this is the **database** referred to in the abstract], located in the X_test and X_train files); there is one rows of derived data for each data of raw measurements
    * X_train has 7352 rows and 561 columns
    * X_test has 2947 rows and 561 columns
    * the 561 columns are the derived quantities described above under Variables

The necessary **labels** and **indexes** are

* labels for the **activities** (in file activity_labels.txt)
    * 6 rows and 2 columns for 6 activities for an index and associated activity label (the file that identifies the activity for each observation consists of activity indexes; the labels in activity_labels.txt are used to transform the observation indexes (in files Y_test and Y_train) into labels)
* labels for the variables in the derived data (in file features.txt)
    * 561 rows and 2 columns for an index and associated derived data label; the labels in 
* indexes to identify the **activity** for each of the train (in file y_train) and test (in file y_test) observations and for each of the UCI raw measurements in the files in the Inertial Signals folders
    * 7352 rows and 1 column for the train data and 2947 rows and 1 column for the test data
* indexes to identify the **subject** for each of the test (in file subject_test.txt) and train observations
    * 7352 rows and 1 column for the train data and 2947 rows and 1 column for the test derived data

For each data set (train and test), the files for the derived data line up as follows (train data file names are used here) :

    |----------------------------------------------------------------------|
    |                                                       | features.txt |
    |                                                       | (col labels) |
    |                                                       |   561 cols   |
    |----------------------------------------------------------------------|
    | activity_labels.txt | y_train.txt | subject_train.txt |  X_train.txt |
    | (one label per row) |(label index)|   (subject id)    |    561 cols  |
    |     7352 rows       |  7352 rows  |     7352 rows     |   7352 rows  |
    |----------------------------------------------------------------------|

For each data set (train and test), the files for the raw measurements line up as follows (train data file names for the body_acc_x_train.txt file are used here) :

    |-------------------------------------------------------------------------------|
    |                                                       |   (no column labels)  |
    |                                                       |         128 cols      |
    |-------------------------------------------------------------------------------|
    | activity_labels.txt | y_train.txt | subject_train.txt |  body_acc_x_train.txt |
    | (one label per row) |(label index)|   (subject id)    |         128 cols      |
    |     7352 rows       |  7352 rows  |     7352 rows     |        7352 rows      |
    |-------------------------------------------------------------------------------|

