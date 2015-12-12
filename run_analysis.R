# Load dplyr library
library(dplyr)

# Read and combine x, y, and subject data

x_train <- read.table("./UCI HAR Dataset-2/train/X_train.txt", header=FALSE)
x_test <- read.table("./UCI HAR Dataset-2/test/X_test.txt", header=FALSE)
x_data <- rbind(x_train, x_test)

y_train <- read.table("./UCI HAR Dataset-2/train/y_train.txt", header=FALSE)
y_test <- read.table("./UCI HAR Dataset-2/test/y_test.txt", header=FALSE)
y_data <- rbind(y_train, y_test)

subject_train <- read.table("./UCI HAR Dataset-2/train/subject_train.txt", header=FALSE)
subject_test <- read.table("./UCI HAR Dataset-2/test/subject_test.txt", header=FALSE)
subject_data <- rbind(subject_train, subject_test)

# to be continued ...
