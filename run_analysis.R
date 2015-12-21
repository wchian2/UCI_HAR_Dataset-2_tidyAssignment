# William W. Chiang
# Data Wrangling Project, Springboard 2015


# Load dplyr library
library(dplyr)

# Read and load dataset into R

x_test <- read.table("./UCI HAR Dataset-2/test/X_test.txt", header=FALSE)
x_train <- read.table("./UCI HAR Dataset-2/train/X_train.txt", header=FALSE)

y_test <- read.table("./UCI HAR Dataset-2/test/y_test.txt", header=FALSE)
y_train <- read.table("./UCI HAR Dataset-2/train/y_train.txt", header=FALSE)

subject_test <- read.table("./UCI HAR Dataset-2/test/subject_test.txt", header=FALSE)
subject_train <- read.table("./UCI HAR Dataset-2/train/subject_train.txt", header=FALSE)

activity_labels <- read.table("./UCI HAR Dataset-2/activity_labels.txt", header=FALSE)
features <- read.table("./UCI HAR Dataset-2/features.txt", header=FALSE)

# Provide column names for x, y, and subject datasets

x_data <- rbind(x_test, x_train)
featureLabels <- features$V2
colnames(x_data) <- featureLabels

y_data <- rbind(y_test, y_train)
colnames(y_data) <- "activity_id"
colnames(activity_labels) <- c("activity_id", "activity_type")
y_data_labeled <- merge(x = y_data, y = activity_labels, by = "activity_id", all.x = TRUE)

subject_data <- rbind(subject_test, subject_train)
colnames(subject_data) <- "subject"

# Merge test and training sets to create one dataset
merged_data <- cbind(subject_data, y_data_labeled, x_data)

# Select columns containing mean and standard deviation for each measurement

merged_data_removedDuplicateColumns <- merged_data[ , !duplicated(colnames(merged_data))]
merged_data_filteredOut <- merged_data_removedDuplicateColumns %>%
  select(matches("subject|activity_type|mean()|std()")) %>%
  select(-matches("meanFreq|AccMean|JerkMean|gravityMean"))

# Create independent tidy dataset with the average of each variable for each activity and each subject

tidy_data <- merged_data_filteredOut %>%
  group_by(subject, activity_type) %>%
  summarise_each(funs(mean))

# Write results into a file named "tidy_data.txt"
write.table(tidy_data, file="tidy_data.txt", row.names = FALSE)