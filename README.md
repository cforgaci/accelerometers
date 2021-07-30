This dataset modifies the Human Activity Recognition Using Smartphones Dataset Version 1.0.

A full description of the original data set is available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data was obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The dataset includes the following files:
=========================================

- 'README.md'

- 'run_analysis.R'

- 'CodeBook.md'


The 'run_analysis.R' script does the following data processing steps:

1. Merges the training and test sets were merged.

2. Extracts only measurements on the mean and standard deviation.

3. Adds descriptive activity names.
  
4. Add descriptive variable names.

5. Cereates a tidy dataset with the average of each variable for each activity and each subject.

6. The tidy dataset is saved in CSV format.


The 'CodeBook.md' lists all the variables in the resulting tidy data set.

For more information about this dataset contact: email