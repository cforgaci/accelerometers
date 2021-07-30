# Load packages ----
library(dplyr)

# Download and read data ----
## Download data
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!dir.exists("data")) {
  dir.create("data")
}

if (!file.exists("data/wearables.zip")) {
  download.file(URL, destfile = "./data/wearables.zip", method = "curl")
  dateDownloaded <- date()
  unzip("./data/wearables.zip", exdir = "data")  
}

## Read data
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
features <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE)
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE)

# 1. Merge the training and test sets ----
X_merged <- rbind(X_test, X_train)
y_merged <- rbind(y_test, y_train)
subject_merged <- rbind(subject_test, subject_train)
X_y_subject_merged <- cbind(X_merged, y_merged, subject_merged)

# 2. Extract only measurements on the mean and standard deviation ----
X_y_subject_merged_mean_std <- X_y_subject_merged[, grepl("-mean()", features[, 2]) | 
                                                    grepl("-std()", features[, 2])]

# 3. Add descriptive activity names ----
X_y_subject_merged_mean_std[,length(names(X_y_subject_merged_mean_std)) - 1] <- 
  factor(X_y_subject_merged_mean_std[,length(names(X_y_subject_merged_mean_std)) - 1],
         labels = activity_labels[, 2])
  
# 4. Add descriptive variable names ----
names(X_y_subject_merged_mean_std) <- c(features[, 2][grepl("-mean()", features[, 2]) | 
                                                      grepl("-std()", features[, 2])], 
                                "activity", "subject")

# 5. Tidy dataset ----
tidy_dataset <- X_y_subject_merged_mean_std %>% 
  group_by(subject, activity) %>% 
  summarise_at(vars(-group_cols()), mean)
