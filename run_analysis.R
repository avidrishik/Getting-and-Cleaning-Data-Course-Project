
library(dplyr)



# read train data

X_train = read.table("train/X_train.txt")

Y_train = read.table("train/Y_train.txt")

sub_train = read.table("train/subject_train.txt") 

#read test data

X_test = read.table("test/X_test.txt")

Y_test = read.table("test/Y_test.txt")

sub_test = read.table("test/subject_test.txt") 

X_train
Y_train
X_test
Y_test
sub_train
sub_test

mergedDT = merge(GDPrank, eduDT, by = 'CountryCode')

# read data description

variable_names = read.table("features.txt")
variable_names 


# read activity labels

activity_labels = read.table("activity_labels.txt")
activity_labels

#1.Merges the training and the test sets to create one data set.

X_bind=rbind(X_train,X_test)
Y_bind=rbind(Y_train,Y_test)
sub_bind=rbind(sub_train,sub_test)

X_bind
(Y_bind)
(sub_bind)
(activity_labels)
(variable_names)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 

selected_var = variable_names[grep("mean\\(\\)|std\\(\\)",variable_names[,2]),]
ls(selected_var)
?grep
a=selected_var[,1]
a
X_total = X_bind[,selected_var[,1]]


# name columns
colnames(X_bind)
selected_var[,2]
colnames(X_bind)   = selected_var[,2]
colnames(Y_bind)   = "activity"
colnames(sub_bind) = "subject"
nrow(Y_bind)
nrow(sub_bind)
nrow(X_bind)

# merge final dataset

total = cbind(sub_bind, Y_bind, X_bind)

# turn activities & subjects into factors 

total$activity = factor(total$activity, levels = activity_labels[,1], labels = activity_labels[,2]) 
total$subject  = as.factor(total$subject) 
?factor

 # create a summary independent tidy dataset from final dataset 
# with the average of each variable for each activity and each subject. 

final = total %>% group_by(activity, subject) %>% summarize_all(funs(mean)) 


# export summary dataset

write.table(final, file = "./tidydata.txt", row.names = FALSE, col.names = TRUE) 
result=read.table("tidydata.txt")
nrow(result)
ncol(result)
ls(result)
summary(result)
result
#colnames(result)
results[1,]