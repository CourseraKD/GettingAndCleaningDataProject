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
    * the 128 columns are ***********************************************
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

