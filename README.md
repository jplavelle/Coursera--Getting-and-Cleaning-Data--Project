# Getting and Cleaning Data - Course Project
### 25 October 2015


NB: Given ambiguity about project expectations for the code book and the 
README, as evidenced by the various discussion on the course forum, there 
may be some overlap in the contents of the two files. This README applies 
to the run_analysis.R script which accompanies it in the Github Repo:
<https://github.com/jplavelle/Coursera--Getting-and-Cleaning-Data--Project>

The intent of this file is to explain the steps followed in processing,
per the project requirements, of the data available at the following link:
 <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>


## Merging datasets & labeling variables

### Reading in the data and labeling columns
Starting with the files referenced above, unzipped into the working 
directory, the code reads in a total of 8 files.

* activity_labels.txt
Contains labels for mapping the activity codes (in the "y" files) to a 
descriptive label. This data is assigned to "activity_labels".

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

For both the "train" and "test" groups, respectively, the "subject", 
"y", and "x" datasets were combined using the cbind function. Once all 
"train" data and all "test" data were combined into their respective groups, 
the consolidated "train" and "test" datasets were combined using the rbind 
function.


## Applying descriptive activity labels
The activity codes (now in the "Activity" column) are converted to 
descriptive names. This is accomplished by subsetting the activity codes 
with the "activity_labels" vector created during read-in. The result is 
assigned back to the "Activity" column.


## Extracting relevant variables
Using the combined dataset ("all_data"), the code creates a vector 
("temp_header") based on selected headers. This vector is used in 
identifying the columns to be extracted. This vector includes "Subject" 
and "Activity" as well as column headers containing "std" (standard 
deviation) or "mean" (mean value). For the purposes of paring down the 
dataset as well as practicing data manipulation techniques, headers 
containing "meanFreq" (weighted average of the frequency components) were 
excluded from the "temp_header" vector.

With the "temp_header" vector, the code then creates a new dataset 
("all_data_new") from the "all_data" dataset by selecting only those 
columns present in the "temp_header" vector.


## Creation of a tidy data set
Using the "group_by" function from the dplyr package, the information in 
"all_data_new" is grouped by both "Subject" and "Activity". Next, the 
dataset is summarized to provide the mean of values for each group. 
In other words, rather than having multiple records for any one subject 
and activity, each pairing of subject and activity occur on just one row. 
That record contains the mean of all observations each column. The 
resulting dataset is assigned to "all_data_new_summarized".

To reflect that the variables are now the mean of all observations in each 
column, the headers are updated to reflect this by way of a "new_headers" 
vector by way of the same approach as used when applying the original 
column names. This vector contains "Subject", "Activity", and prefaces the 
same variable names as before with "Average for subject and activity - ".


## Producing the output file
Once the "all_data_new_summarized" dataset is prepared with updated 
column headers, the final product is written to a text file titled 
"project_output.txt". One can read the output file back into R in order to 
view the tidy data set.