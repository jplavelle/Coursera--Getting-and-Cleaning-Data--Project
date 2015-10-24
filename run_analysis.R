#This code is in partial fulfillment of the course project for "Getting and
#Cleaning Data" offered by Johns Hopkins Univeristy through Coursera.

#Source data used in this project comes from:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Additional backgroun regarding the source information can be found here:
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Load required package
library(dplyr)

#Read in all data
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt",
                            stringsAsFactors = F,col.names = c("code","label"))
features<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = F)
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",
                          col.names = "Subject")
x_train<-read.table("./UCI HAR Dataset/train/x_train.txt",
                    col.names = features[,2])
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt",
                    col.names = "Activity")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",
                         col.names = "Subject")
x_test<-read.table("./UCI HAR Dataset/test/x_test.txt",
                   col.names = features[,2])
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt",
                   col.names = "Activity")

#Combine Train (Subject, Y, and X) datasets
train_all<-cbind(subject_train,y_train,x_train)

#Combine Test (Subject, Y, and X) datasets
test_all<-cbind(subject_test,y_test,x_test)

#Combine Train & Test datasets
all_data<-rbind(train_all,test_all)

#Update activity codes to labels
all_data$Activity<-activity_labels$label[all_data$Activity]

#Create vector with column names
temp_header_list<-grep("Freq",grep("Subject|Activity|mean|std",colnames(all_data),
                                   value = T),invert = T,value = T)

#Subset desired data
all_data_new<-subset(all_data,select=temp_header_list)

#Set groups
all_data_new_group<-group_by(all_data_new,Subject,Activity)

#Summarize data
all_data_new_summarized<-summarize_each(all_data_new_group,funs(mean))

#Write data to file
write.table(all_data_new_summarized,file="project_output.txt",row.names = FALSE)

