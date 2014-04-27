Getting and Cleaning Data on Human Activity Recognition Using Smartphones Data Set
==================

The script ```run_analysis.R``` assumes that the source data is in a
subdirectory ```UCI HAR Dataset``` of the current directory. This is the normal
situation when you unzip the Dataset.zip file in the current directory.

Once executed, the script generates the tidy dataset and writes it into a file
tidyhar.txt in the current directory.

This file can be read into an R dataframe using ```read.table("tidyhar.txt")```

See the Coursera "Getting and Cleaning Data" [Project specification](https://class.coursera.org/getdata-002/human_grading/view/courses/972080/assessments/3/submissions) for more details on what this script does.

The original data used in this project comes from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) project.
