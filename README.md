# Getting-and-Cleaning-data
In this project, I used Samsung data to create independent tidy data set with the average of each mean and standard deviation of each measurement, for each activity and each subject.
The whole job will be done with one R script. [run_analysis.R](https://github.com/gsheasha/Getting-and-Cleaning-data/blob/master/run_analysis.R)
The steps were as follows:
###I. Reading the data files
I assumed that all the individual files are present in your working directory.
Then, reading in all the train and test dataset using *read.table()*
###II. Merges the training and the test sets to create one data set.
We bind the data sets so that
* The first variable refers to the subject.
* The second one refers to the activities.
* The remaining columns refer to the variables measured.

Three steps of code are used to merge all the datasets
1. Mering all the train datasets using *cbnind()*
2. Merging all the test datasets using *cbind()*
3. Merging train and test datasets (from steps 1 and 2) using *rbind()* in one dataset called "all"

###III. Extracts only the measurements on the mean and standard deviation for each measurement
This major step was done in two mini-steps
####1.Name the variables
1. Read the features.txt using *read.table()*
2. Name the first two variables in the data set and save it in a data frame,"features1" and change the name of its column to "V2" so it can be merged with the rest of features' names
3. Merge the two data frames using *rbind()*
4. Finally, name the variables in "all" using *colnames(all)*

####2. Extracting the measurements on the mean and standard deviations for each measurement.
1. load necessary library, dplyr
2. Prepare variable names using *make.names()* so no duplicate columns will be found when using "select"function
3. Extract subject, activity and all measurements on the mean and standard deviations using *dplyr::select()*

###IV. Uses descriptive activity names to name the activities in the data set
1. Read the activity data file
2. Prepare "Activity" colnames so it can be joined to the "all"
3. Load library(tidyr) to use *left_join()* function
4. Remove the redundant first variable "all$Activity"
5. Make the name of the first variable in "all"

###V. Appropriately labels the data set with descriptive variable names
In this step, I lower all the caps, remove all the periods form the names and checking the classes of the variables

1. Lower all the capital letter using *tolower()*
2. Remove all the periods from the names using *gsub()*
3. Check the class of the variables using *str()* and convert the class of the "all$subject" from num to factor.

###VI. Creating a second, independent tidy data set with the average of each variable for each activity and each subject

This is done in two steps
1. Using *dplyr::group_by()* and *dplyr::summarize_each(funs(mean))*, the dataset"ALL" was developed.
2. Using *write.table()", "ALL" were stored in "tidydata.txt" formate

Then the I write down the [codebook](https://github.com/gsheasha/Getting-and-Cleaning-data/blob/master/codebook) for the "tidydata.txt"
