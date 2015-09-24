# CodeBook

##Data set for part 1

The script merges data from these files

  * test/subject_test.txt
  * train/subject_train.txt
  
  * test/y_test.txt
  * train/y_train.txt
  
  * test/X_test.txt
  * train/X_train.txt

and stores them into the variable *data*. The first 2 files indicate subject identification, the next 2 indicate activity (e.g. walking, but represented by numbers 1-6) done by the subject and the last 2 indicate accelerometer measurements. Labels for the measurements were extracted from features.txt.

##Part 2

The script then uses the grep function to filter out measurements on the mean and standard deviation for each measurement, by searching for the keywords "-std()" and "-mean()". This data is then stored in the variable *filteredData*

##Part 3

The activity labels were extracted from activity_labels.txt and substituted in the 'activity column'

##Part 4

The script replaces all dashes with underscores and removes parentheses so that the variable names are compatible with R

##Part 5

The average of each variable for each activity and each subject was calculated via nested for-loops and the resulting data is saved in tidy_data_set.txt.
