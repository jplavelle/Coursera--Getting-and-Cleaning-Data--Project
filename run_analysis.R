# Read in all data
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

# Combine Train (Subject, Y, and X) datasets
train_all<-cbind(subject_train,y_train,x_train)

# Combine Test (Subject, Y, and X) datasets
test_all<-cbind(subject_test,y_test,x_test)

# Combine Train & Test datasets
all_data<-rbind(train_all,test_all)

#Set column labels
#column_labels<-c("Subject","Activity",features[,2])
#colnames(all_data)<-column_labels

#Update activity codes to labels
all_data$Activity<-activity_labels$label[all_data$Activity]

#
temp_header_list<-grep("Freq",grep("Subject|Activity|mean|std",colnames(all_data),
                                   value = T),invert = T,value = T)
all_data_new<-subset(all_data,select=temp_header_list)

#Create single column with identifier.
all_data_new$UID<-as.character(paste(all_data_new$Subject,all_data_new$Activity,
                                     sep = ""))

