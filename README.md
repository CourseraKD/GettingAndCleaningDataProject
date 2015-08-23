---
title: "Coursera - Getting and Cleaning Data Class Project"
author: "CourseraKD"
date: "2015-08-23"
---

#Summary#
This README file is a description of the work done in fulfillment of the class project for the online Coursera - Getting and Cleaning Data class. It describes how the scripts used to produce the required output work and how they are connected.

This README file assumes you have read the associated Codebook.

* the data presented in [Human Activity Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) (this raw data will be referred to as the 'raw UCI data') (UCI stands for [University of California at Irvine](http://www.ics.uci.edu/))
* the tidy data set generated from that data
* the code used to generate the tidy data set
    
#Background#
The abstract for the data is: Abstract: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. No mention in either the abstract or the data description 
    
The [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) were taken from the [Coursera](https://www.coursera.org/) site for the class [Getting and Cleaning data](https://www.coursera.org/course/getdata), part of their [Data Science Specialization](https://www.coursera.org/specialization/jhudatascience/1).

#Coursera Project Deliverables#
* a codebook that describes the variables, the data and any transformations or work performed to clean up the data
* a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. [NOTE: this is a confusing instruction. I interpret it to mean we need a README.md file that explains how the single required script, run_analysis.R, works]
* a link to a Github repository containing the R script, run_analysis.R, that generates the tidy dataset
* a tidy dataset (variables in columns, observations is rows) of the raw UCI data which
    * merges the training and test data sets
    * extracts only the measurements of the mean and standard deviation of each measurement
    * uses descriptive activity names to name the activities in the data set
    * appropriately labels the data set with descriptive names
    * creates a second, independent tidy data set with the average of each variable for each activity and each subject

#Data Preparation#
[NOTE: the script run_analysis.R requires package 'dplyr' to be installed. The script checks that the package is available and if not, issues a message and stops execution.]

The script run_analysis.R is self-documenting, that is, it contains comments (which print out during execution) that describe what is going on in each portion of the code. Here is a list of the sections of code:

1. Getting activity names and indexes
2. Getting features
3. Getting mean and standard deviation features
    This is needed for step 2 of the project instructions
4. Getting activity indexes
5. Getting subject ids
6. Already have X data
7. Subsetting X data to get only mean and standard deviation columns
    This is step 2 out of 5 of the project instructions
8. Adding column names to X data
    This is step 4 out of 5 of the project instructions
9. Adding subject id column to X data (needed for step 5)
10. Adding activity name column to X data
    This is step 3 out of 5 of the project instructions
11. Merging the two data sets
    This is step 1 out of 5 of the project instructions
12. Generating 2nd tidy data set with averages by activity and subject
    This is step 1 out of 5 of the project instructions

[NOTE: there is a section which reads in data from the files in the directores Inertial Signals directories, but since that data is not needed to complete the project requirements, it is not run.]

# DataTransformations#
As described in Codebook.md, the data existed in files that were separate from the activity and subject identifiers (row identifiers) and from the labels for the variables (column names, residing in file features.txt). The bulk of the script was reading in all the files, converting to factors where needed, subsetting and naming the columns so that only mean and standard deviation columns were preserved and then merging the measurement data with the activity and subjectids for each row. Finally, the resulting table was aggregated to provide column means for each activity-subject combination (using package dplyr). 

#Comments and Complaints#
This section of the codebook is not related to completion of the project. It is a list of observations and value judgements about the data we had to work with.
Granted the purpose of the course is to have us learn how to work with messy, real world data. But it is worthwhile to catalog in what ways the data is messy so help identify how to provide tidy data in our own work.

The instructions for working with the data were vague, and I think this was by design. It was meant to force us to think through the problem and make the instructions make sense. Example: "2. Extracts only the measurements on the mean and standard deviation for each measurement." Here the word 'measurement' refers to two different objects. The second 'measurement' refers to the data in the Inertial Signals folders. The first 'measurement' refers to the X data (data in files X_train and X_test) which are not really measurements, they are summary values of the actual raw measurements as recorded in the files in the Inertial Signals folders. Figuring out that we should ignore those files was key to completing the project.

The documentation that came with the data for this project (I'm here referring to the README.txt and features_info.txt files) was very frustrating to use. Here is a list of problems that might be avoided in future work.

   * The biggest problem with the data is that it had no stated purpose. In the README.txt file, the authors describe the procedures used to collect and transform the data. Perhaps that was their goal: collect data for use by themselves or others to draw conclusions about human movement or how to record human movement or the current state of technology for the recording of human movement. If their goal was just to collect, transform and make available to others electronic measurements of human movement, they did not state this. Perhaps, as the title of the study in the README.txt file hinted at, the purpose was to provide data for the development of algorithms to recognize different types of human movement. It is not clear why the authors expended time and money to gather the data they did. Any experiment or study that does not have a clearly defined goal can neither succeed nor fail: there is nothing one can use to judge the results.
   * In the README.txt file that accompanied the data, the work done was described as an experiment. Since the different subjects did not receive different treatments, since they were not treated differently in any way, this hardly qualifies as an experiment. It could be called a study, but not an experiment (this may seem a bit like nit picking but it is necessary to distinguish if this is an experiment or a study when doing analyses of the data, e.g. an ANOVA on subjects and activities).
   * The authors of the study seemed to assume the reader had a lot of background information about the study. This doesn't include the data transformation techniques used  by the authors (e.g., Butterworth filter or more basically, the features that are means and standard deviations - it is not clear if these are simply the mean and standard deviation of all 128 readings of each row in the raw measurement files in the Inertial Signals folders). Rather, the nature of the data in each file was not made clear, nor did the names of the files add any clarification. 
        * The features.txt file was a list of parameters derived from the raw data from the accelerometer and gyrosccope in the smart phone. The word 'feature' is not a good label for this derived data. Naming the file 'result-parameters' or 'derived-parameters' or something else to indicate that the contents of the file was a list of values calculated from the raw data would make things clearer.  
        * X_test was the file of values for the 561 'features' from each volunteer for each type of activity. These values were derived from the raw data in the files in the Inertial Signals folder. The use of the symbol 'X' was confusing because 'X' was already in use, along with 'Y' and 'Z', to label the axes of motion. Labeling the file as 'results' ('results-train' and 'results-test') would have made the nature of the data in that particular file much clearer. 
        * Y_test was the file of indexes back to the activity labels. The labels described the activity (walking, walking upstairs, etc.) each of which had an index (1 through 6). The Y_test file was a list of indexes that lined up with the 2947 raw measurements in the Inertial Signal files and the 2947 values ('features') derived from the raw measurements. Lining up the rows in the Y_test file with those in the Inertial Signals files and the X_test file was how to identify the activity for each data row in the files. Y_test is a name that not only has nothing to indicate what is in the file, it actually confuses the matter with the use of 'Y' which is already in use, along with 'X' and 'Z', to label the axes of motion.
    
    
*Lessons Learned*
    * State the goal or goals of your activities.
    * Name your data files with words that are descriptive of the file contents and how the contents relate to data in other files. 

