### clear contents of working environment ###
rm(list = ls())

### load necessary libraries ###
library(dplyr)
library(reshape2)

### Read all files into R ###
features<-read.table("features.txt")
labels_activity<-read.table("activity_labels.txt")
labels_test<-read.table("y_test.txt")
labels_train<-read.table("y_train.txt")
subject_test<-read.table("subject_test.txt")
subject_train<-read.table("subject_train.txt")
data_test<-read.table("X_test.txt")
data_train<-read.table("X_train.txt")

### STEP 1 - merge data sets ###
data<-rbind(data_test,data_train)             #merge data
activities<-rbind(labels_test,labels_train)   #merge activity labels
subjects<-rbind(subject_test,subject_train)   #merge data subjects

### STEP 3 - Add activity labels and subjects to data ###
colnames(data)<-features[,2]                  #add data labels as column names
colnames(activities)<-"activity"              #name activity titles
data<-cbind(activities,data)                  #add activity numbers to data set
colnames(subjects)<-"subject"                 #name subject titles
data<-cbind(subjects,data)                    #add subject names to data set

### STEP 2 - select only mean and std variables ###
sub_mean<-grepl("mean",features[,2])          #find variables with "mean" in title
sub_std<-grepl("std",features[,2])            #find variables with "std" in title
sub_Mean<-grepl("Mean",features[,2])          #find variables with "Mean" in title
sub_char<-sub_mean+sub_std+sub_Mean           #combine all subsets
sub<-as.logical(sub_char)                     #convert sub_char to logical
data_sub<-data[sub]                           #create new variable with only mean and std data

### STEP 4 - add activity descriptive to data subset ###

data_sub$activity<-as.factor(data_sub$activity)  #convert activities to factors 
data_sub$activity<-factor(data_sub$activity,levels=labels_activity[,1],labels=labels_activity[,2])

### STEP 5 - create second data set with averages ###

datamelt<-melt(data_sub,id=c("subject","activity")) #melt subset data together
data2<-dcast(datamelt, subject ~ variable,mean)     #calculate variable means for each subject
write.table(data2,file="data.txt",row.names=TRUE)   #write output file