# I. Reading the data files
##Train data
subjecttrain=read.table("subject_train.txt")
xtrain=read.table("X_train.txt")
ytrain=read.table("y_train.txt")
##Test data
subjecttest=read.table("subject_test.txt")
xtest=read.table("X_test.txt")
ytest=read.table("y_test.txt")
#II. Merges the training and the test sets to create one data set.
##Bind train data files together
train=cbind(subjecttrain,ytrain,xtrain)
## Bind test data files
test=cbind(subjecttest,ytest,xtest)
##Bind the two data sets togehter
all=rbind(train,test)
#III. Extracts only the measurements on the mean and standard deviation for each measurement
##Name the variables
features1=read.table("features.txt")[2] #Read the features names using read table
features2=as.data.frame(c("Subject","Activity")) #Name the first two variables in the data set and save it in a data frame
names(features2)=c("V2") #change the name of "features2"so it can be merged with features1
features=rbind(features2,features1)#Merge the two data frames
colnames(all)=features$V2 #Name the varialbes
## Extract Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr) #Load "dplyr" to use select functions
validnames <- make.names(names=names(all), unique=TRUE, allow_ = TRUE)#Prepare variable names so no duplicate 
names(all) <- validnames
all=all %>%
select(Activity,Subject,contains("mean"),contains("std")) #Extract subject, activity and all measurements 
                                                          #on the mean and standard deviations
#IV. Uses descriptive activity names to name the activities in the data set
Activity=read.table("activity_labels.txt")#Read the activity data file
colnames(Activity)=c("Activity","Activity2")#Prepare "Activity" varialbe neames so it can be joined to the "all"
library(tidyr)#load library(tidyr) to use left_join function
all=left_join(Activity,all,by="Activity")#Join the "all"data file with the names of activities "Activity"
all$Activity=NULL#Remove the redundant first variable "all$Activity"
colnames(all)[1]=c("Activity")#Make the name of the first variable
#V. Appropriately labels the data set with descriptive variable names
names(all)=tolower(names(all)) ## to lower all the capital 
names(all)=gsub("\\.","",names(all),)##Remove all the periods from the names
str(all)##check for the class of the variables
all$subject=as.factor(all$subject)##convert the class of subject into factor
#VI. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
library(dplyr)
ALL=all %>%
group_by(subject,activity) %>%
summarise_each(funs(mean))## Build the tidy data file
write.table(ALL,"tidydata.txt",row.name=F)## write it in .txt formate

