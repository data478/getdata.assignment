# assuming that Dataset.zip was unzipped in the current directory
# creating subdirectory UCI HAR Dataset

# feature records
test_set  <- read.table(file="UCI HAR Dataset/test/X_test.txt", header=F)
train_set  <- read.table(file="UCI HAR Dataset/train/X_train.txt", header=F)

# activity type - one per feature record
test_act <- read.table(file="UCI HAR Dataset/test/y_test.txt", header=F)
train_act <- read.table(file="UCI HAR Dataset/train/y_train.txt", header=F)

# subject - one per feature record
test_subj <- read.table(file="UCI HAR Dataset/test/subject_test.txt", header=F)
train_subj <- read.table(file="UCI HAR Dataset/train/subject_train.txt", header=F)

# activity labels (for decoding test_act & train_act)
act_lab <- read.table(file="UCI HAR Dataset/activity_labels.txt", header=F)
names(act_lab) <- c("col.idx", "act.label")

# columns names for feature tables test_set and train_set
feat_lab <- read.table(file="UCI HAR Dataset/features.txt", header=F)
names(feat_lab) <- c("col.idx", "var.name")

#==============================================================================

# retain only variables with main() or std()

# filter down to variables on interest
feat_lab <- feat_lab[grep("(mean|std)\\(\\)", feat_lab$var.name),]
# make variable names synactically valid for R
feat_lab$var.name <- sub("\\(\\)", "", feat_lab$var.name)
feat_lab$var.name <- gsub("-", ".", feat_lab$var.name)

# select subset of columns corresponding to above
test_set <- subset(test_set, select = feat_lab$col.idx)
train_set <- subset(train_set, select = feat_lab$col.idx)

names(test_set) <- feat_lab$var.name
names(train_set) <- feat_lab$var.name

#==============================================================================

# join subject and activity information with feature records

test_set <-  cbind(test_subj,  test_act, test_set)
names(test_set)[c(1,2)] <- c("subject", "activity")
train_set <- cbind(train_subj, train_act, train_set)
names(train_set)[c(1,2)] <- c("subject", "activity")

# convert activity to factor
test_set$activity <-  factor(test_act$V1,  levels=act_lab$col.idx, labels=act_lab$act.label)
train_set$activity <- factor(train_act$V1, levels=act_lab$col.idx, labels=act_lab$act.label)

#==============================================================================

# finally, join the two sets

har <- rbind(test_set,train_set)

#==============================================================================

# producing the tidy data set: mean of all of the feature variables by subject and activity

library(plyr)
tidy.har <- ddply(har, .(subject,activity), colwise(mean))

#==============================================================================

# write data as a text file

write.table(tidy.har, file="tidyhar.txt")
