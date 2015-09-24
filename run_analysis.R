# 1. Merges the training and the test sets to create one data set.

  #First we merge the training and test sets
  
  subject_test <- read.table("test/subject_test.txt")
  subject_train <- read.table("train/subject_train.txt")
  subject <- rbind(subject_test, subject_train)
  
  y_test <- read.table("test/y_test.txt")
  y_train <- read.table("train/y_train.txt")
  y <- rbind(y_test, y_train)
    
  X_test <- read.table("test/X_test.txt")
  X_train <- read.table("train/X_train.txt")
  X <- rbind(X_test, X_train)
  
  #Combine all data
  data <- cbind(subject, y, X)
  
  #Label the data appropriately by using features.txt
  features <- read.table("features.txt")
  labels <- c("subject", "activity", as.character(features[,2]))
  names(data) <- labels
  
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  
  #First we find the indices of the labels with -mean() and -std() in them
  
  index <- grep("-mean\\(\\)|-std\\(\\)", names(data))
  
  #We then filter the data and store it in a new variable filteredData
  #We also remember to include the "activity" and "subject" columns
  
  filteredData <- data[,c(1, 2, index)]
  
#3. Uses descriptive activity names to name the activities in the data set
  
  #We import the activity labels and substitute the text labels into filteredData
  activity_labels <- read.table("activity_labels.txt")
  filteredData$activity <- activity_labels[filteredData$activity, 2]
  
#4. Appropriately labels the data set with descriptive variable names. 
  
  #We want to replace all dashes with underscores
  newNames <- gsub("-", "_", names(filteredData))
  
  #Also remove all parentheses
  newNames <- gsub("\\(|\\)", "", newNames)
  
  #relabel the data set
  names(filteredData) <- newNames
  
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  #First we define vectors for subjects and activities.
  subjectVector <- sort(unique(filteredData$subject))
  subjectLength <- length(subjectVector)
  
  activityVector <- unique(filteredData$activity)
  activityLength <- length(activityVector)

  #Place where the final data will be stored. Creates a dataframe with the right dimensions
  #also adds column labels
  tidyData <- data.frame(matrix(ncol = ncol(filteredData), nrow = subjectLength * activityLength))
  names(tidyData) <- names(filteredData)
  
  #Use for loop to loop through each subject and activity to calculate the means
  rowIndex <- 1
  
  for(subjectIndex in 1:subjectLength){
    for(activityIndex in 1: activityLength){
     
      #Insert values for this specific subject/activity combination
      tidyData[rowIndex, "subject"] <- subjectVector[subjectIndex]
      tidyData[rowIndex, "activity"] <- as.character(activityVector[activityIndex])
      
      #subset filteredData for values matching the specific subject and activity
      #e.g. all data for subject 1 while standing
      subsetData <- filteredData[(filteredData$subject == subjectVector[subjectIndex]) & (filteredData$activity == activityVector[activityIndex]),]
      
      #Take the column mean of subsetData, put it into tidyData
      tidyData[rowIndex, 3:ncol(filteredData)] <- colMeans(subsetData[,3:ncol(filteredData)])
      
      #increase row index
      rowIndex <- rowIndex + 1
    }
  }
  
  write.table(tidyData, "tidy_data_set.txt", row.names = FALSE)
  
  