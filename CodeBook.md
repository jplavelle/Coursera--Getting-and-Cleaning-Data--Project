# Getting and Cleaning Data - Course Project
### 25 October 2015


NB: Given ambiguity about project expectations for the code book and the 
README, as evidenced by the various discussion on the course forum, there 
may be some overlap in the contents of the two files. This Code Book applies 
to the run_analysis.R script which accompanies it in the Github Repo:
<https://github.com/jplavelle/Coursera--Getting-and-Cleaning-Data--Project>


The intent of this file is to explain the steps followed in processing,
per the project requirements, of the data available at the following link:
 <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

##Code Book
Per the "features_info.txt" file included in the zip file referenced above, 
the following information from that file applies to the original data that 
the run_analysis.R script reads in and processes.

===========================================================================
The features selected for this database come from the accelerometer and 
gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain 
signals (prefix 't' to denote time) were captured at a constant rate of 50 
Hz. Then they were filtered using a median filter and a 3rd order low pass 
Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and 
gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using 
another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were 
derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
Also the magnitude of these three-dimensional signals were calculated 
using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, 
tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals 
producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, 
fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain 
signals). 

These signals were used to estimate variables of the feature vector for 
each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean
===========================================================================

After the transformations outlined below, the resulting fields will be:

* Subject
* Activity

In addition, the mean and standard deviation variables for the following 
signals (broken out by x-y-z axis, if applicable) are present as the 
average of all measurements for that variable with respect to the subject 
and activity to which it is paired.

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