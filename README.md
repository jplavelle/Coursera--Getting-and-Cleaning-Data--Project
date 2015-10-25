# Getting and Cleaning Data - Course Project
###Jacob Lavelle - 25 October 2015

The intent of this file is to explain the steps followed in processing,
per the project requirements, of the data available at the following link:
 <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> per the project requirements.


## Merging datasets & labeling variables

### Reading in the data
Starting with the files referenced above, unzipped into the working 
directory, the code reads in a total of 8 files.

* activity_labels.txt
Contains labels for mapping the activity codes (in the "y" files) to a 
descriptive label. This data is assigned to "activity_label".

* features.txt
Contains labels for the column headers for the various recorded 
measurements (in the "x" files). This data is assigned to "features".

* subject_train.txt
Contains a unique identifier for the study participants engaged in 
recording the training data.

* x_train.txt
Contains the actual measurements recorded for the training data. Column 
names were applied as the file was read in, using the "col.names" argument 
and referencing the "features" variable.

* y_train.txt
Contains codes representing one of six different activities which study 
participants engaged in while the training measurements were recorded.

* subject_test.txt
Contains a unique identifier for the study participants engaged in 
recording the testing data.

* x_test.txt
Contains the actual measurements recorded for the testing data. Column 
names were applied as the file was read in, using the "col.names" argument 
and referencing the "features" variable.

* y_test.txt
Contains codes representing one of six different activities which study 
participants engaged in while the testing measurements were recorded.

### Merging datasets
Both the train and test datasets fit together in the same way: 

* "subject" identifies the particpant
* "y" identifies the activity by a code
* "x" contains the actual measurements

For both the train and test datasets, respectively, the subject, y, and x 
datasets were combined using the cbind function. Once all train data and 
all test data was combined into their respective groups, both the entire 
train and test datasets were combined using the rbind function.


## Applying descriptive labels



## Extracting relevant variables


## Creation of a tidy data set

