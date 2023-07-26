################################################################
# 26 JULY 2023
# 
# R COURSE 3: PROGRAMMING ASSIGNMENT 1 (WEEK 4)
# CLEANING AND MERGING DATASETS
################################################################

#-------------------------------------------------------------------
# Read in the datasets. 
#-------------------------------------------------------------------
subject_train = read.table("subject_train.txt")
y_train = read.table("y_train.txt")
x_train = read.table("x_train.txt")

subject_test = read.table("subject_test.txt")
y_test = read.table("y_test.txt")
x_test = read.table("x_test.txt")

features = read.table("features.txt")
activity_labels = read.table("activity_labels.txt")
#-------------------------------------------------------------------
# Summary tables of the data
#-------------------------------------------------------------------

dim(subject_train)	# 7352  1
dim(y_train)		# 7352  1
dim(x_train)		# 7352  561

dim(subject_test)		# 2947  1
dim(y_test)			# 2947  1
dim(x_test)			# 2947  561

table(subject_train)
#   1   3   5   6   7   8  11  14  15  16  17  19
# 347 341 302 325 308 281 316 323 328 366 368 360

#  21  22  23  25  26  27  28  29  30 
# 408 321 372 409 392 376 382 344 383

table(y_train)
#    1    2    3    4    5    6 
# 1226 1073  986 1286 1374 1407

table(subject_test)
#   2   4   9  10  12  13  18  20  24 
# 302 317 288 294 320 327 364 354 381

table(y_test)
#    1    2    3    4    5    6 
#  496  471  420  491  532  537
#-------------------------------------------------------------------
# PART 1
# Merge the six datasets together, making one master original
# dataset with 10299 rows and 563 columns.
# Note that the first column is labeled V1, the second V1.1, and
# the third V1.2 before going back to V2, V3, ..., V561.
# Thus, the original first column from x_train and x_test, which
# was originally V1, is now V1.2.
#-------------------------------------------------------------------

Train = cbind(subject_train,y_train,x_train)
Test = cbind(subject_test,y_test,x_test)
Original = rbind(Train,Test)
dim(Original)	# 10299	563

# Order by subject number 1 - 30, which is the 1st column
# Then order by Y, which is the 2nd column
Original = Original[order(Original[,1],Original[,2]),]

#-------------------------------------------------------------------
# PART 2
# Extract the columns for which a mean or standard deviation was
# computed. These occur at the following columns:
# 
# 1 tBodyAcc-mean()-X
# 2 tBodyAcc-mean()-Y
# 3 tBodyAcc-mean()-Z
# 4 tBodyAcc-std()-X
# 5 tBodyAcc-std()-Y
# 6 tBodyAcc-std()-Z
# 41 tGravityAcc-mean()-X
# 42 tGravityAcc-mean()-Y
# 43 tGravityAcc-mean()-Z
# 44 tGravityAcc-std()-X
# 45 tGravityAcc-std()-Y
# 46 tGravityAcc-std()-Z
# 81 tBodyAccJerk-mean()-X
# 82 tBodyAccJerk-mean()-Y
# 83 tBodyAccJerk-mean()-Z
# 84 tBodyAccJerk-std()-X
# 85 tBodyAccJerk-std()-Y
# 86 tBodyAccJerk-std()-Z
# 121 tBodyGyro-mean()-X
# 122 tBodyGyro-mean()-Y
# 123 tBodyGyro-mean()-Z
# 124 tBodyGyro-std()-X
# 125 tBodyGyro-std()-Y
# 126 tBodyGyro-std()-Z
# 161 tBodyGyroJerk-mean()-X
# 162 tBodyGyroJerk-mean()-Y
# 163 tBodyGyroJerk-mean()-Z
# 164 tBodyGyroJerk-std()-X
# 165 tBodyGyroJerk-std()-Y
# 166 tBodyGyroJerk-std()-Z
# 201 tBodyAccMag-mean()
# 202 tBodyAccMag-std()
# 214 tGravityAccMag-mean()
# 215 tGravityAccMag-std()
# 227 tBodyAccJerkMag-mean()
# 228 tBodyAccJerkMag-std()
# 240 tBodyGyroMag-mean()
# 241 tBodyGyroMag-std()
# 253 tBodyGyroJerkMag-mean()
# 254 tBodyGyroJerkMag-std()
# 266 fBodyAcc-mean()-X
# 267 fBodyAcc-mean()-Y
# 268 fBodyAcc-mean()-Z
# 269 fBodyAcc-std()-X
# 270 fBodyAcc-std()-Y
# 271 fBodyAcc-std()-Z
# 345 fBodyAccJerk-mean()-X
# 346 fBodyAccJerk-mean()-Y
# 347 fBodyAccJerk-mean()-Z
# 348 fBodyAccJerk-std()-X
# 349 fBodyAccJerk-std()-Y
# 350 fBodyAccJerk-std()-Z
# 424 fBodyGyro-mean()-X
# 425 fBodyGyro-mean()-Y
# 426 fBodyGyro-mean()-Z
# 427 fBodyGyro-std()-X
# 428 fBodyGyro-std()-Y
# 429 fBodyGyro-std()-Z
# 503 fBodyAccMag-mean()
# 504 fBodyAccMag-std()
# 516 fBodyBodyAccJerkMag-mean()
# 517 fBodyBodyAccJerkMag-std()	
# 529 fBodyBodyGyroMag-mean()
# 530 fBodyBodyGyroMag-std()
# 542 fBodyBodyGyroJerkMag-mean()
# 543 fBodyBodyGyroJerkMag-std()
#-------------------------------------------------------------------
# Define the column indices at which a mean or sd is computed

ColumnIndex = c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,
	227,228,240,241,253,254,266:271,345:350,424:429,503,504,
	516,517,529,530,542,543)

# Add 2 to each entry in ColumnIndex to account for the extra
# two columns in the front of the Original dataset.
ColumnIndex2 = c(1,2,(ColumnIndex + 2))


# Extract the means and sds
Dataset2 = Original[,ColumnIndex2]
dim(Dataset2)	# 10299	68
#-------------------------------------------------------------------
# PART 3
# Use descriptive activity names to name the activities.
# V1                 V2
#  1            WALKING
#  2   WALKING_UPSTAIRS
#  3 WALKING_DOWNSTAIRS
#  4            SITTING
#  5           STANDING
#  6             LAYING
#-------------------------------------------------------------------

table(Dataset2[,2])
dim(activity_labels)
Activity = numeric(nrow(Dataset2))
for(i in 1:nrow(Dataset2)) {
	Activity[i] = activity_labels[Dataset2[i,2],2]
}

# Replace Column 2 (V1.1) with the Activity variable
Dataset3 = Dataset2
Dataset3[,2] = Activity
Dataset3[1:10,1:7]

#-------------------------------------------------------------------
# PART 4
# Appropriately label the dataset with descriptive variable names.
#-------------------------------------------------------------------

VariableNames = c("subject","activity",
	"timeBodyAccelerationX_mean","timeBodyAccelerationY_mean",
	"timeBodyAccelerationZ_mean","timeBodyAccelerationX_sd",
	"timeBodyAccelerationY_sd","timeBodyAccelerationZ_sd",
	"timeGravityAccelerationX_mean","timeGravityAccelerationY_mean",
	"timeGravityAccelerationZ_mean","timeGravityAccelerationX_sd",
	"timeGravityAccelerationY_sd","timeGravityAccelerationZ_sd",
	"timeBodyAccelerationJerkX_mean","timeBodyAccelerationJerkY_mean",
	"timeBodyAccelerationJerkZ_mean","timeBodyAccelerationJerkX_sd",
	"timeBodyAccelerationJerkY_sd","timeBodyAccelerationJerkZ_sd",
	"timeBodyAngularX_mean","timeBodyAngularY_mean",
	"timeBodyAngularZ_mean","timeBodyAngularX_sd",
	"timeBodyAngularY_sd","timeBodyAngularZ_sd",
	"timeBodyAngularJerkX_mean","timeBodyAngularJerkY_mean",
	"timeBodyAngularJerkZ_mean","timeBodyAngularJerkX_sd",
	"timeBodyAngularJerkY_sd","timeBodyAngularJerkZ_sd",
	"timeBodyAccelerationMagnitude_mean","timeBodyAccelerationMagnitude_sd",
	"timeGravityAccelerationMagnitude_mean","timeGravityAccelerationMagnitude_sd",
	"timeBodyAccelerationJerkMagnitude_mean","timeBodyAccelerationJerkMagnitude_sd",
	"timeBodyAngularMagnitude_mean","timeBodyAngularMagnitude_sd",
	"timeBodyAngularJerkMagnitude_mean","timeBodyAngularJerkMagnitude_sd",
	"fftBodyAccelerationX_mean","fftBodyAccelerationY_mean",
	"fftBodyAccelerationZ_mean","fftBodyAccelerationX_sd",
	"fftBodyAccelerationY_sd","fftBodyAccelerationZ_sd",
	"fftBodyAccelerationJerkX_mean","fftBodyAccelerationJerkY_mean",
	"fftBodyAccelerationJerkZ_mean","fftBodyAccelerationJerkX_sd",
	"fftBodyAccelerationJerkY_sd","fftBodyAccelerationJerkZ_sd",
	"fftBodyAngularX_mean","fftBodyAngularY_mean",
	"fftBodyAngularZ_mean","fftBodyAngularX_sd",
	"fftBodyAngularY_sd","fftBodyAngularZ_sd",
	"fftBodyAccelerationMagnitude_mean","fftBodyAccelerationMagnitude_sd",
	"fftBodyAccelerationJerkMagnitude_mean","fftBodyAccelerationJerkMagnitude_sd",
	"fftBodyAngularMagnitude_mean","fftBodyAngularMagnitude_sd",
	"fftBodyAngularJerkMagnitude_mean","fftBodyAngularJerkMagnitude_sd")

Dataset4 = Dataset3
colnames(Dataset4) = VariableNames
#-------------------------------------------------------------------
# PART 5
# From Dataset4, create a second, independent tidy dataset with the
# average of each variable for each activity and each subject.
# There are 30 subjects, 6 activities, and 66 variables.
# The result will be a 180 x 68 dataset.
# The dataset was already ordered in Part 1 by subject (1-30)
# and then by activity (1-6 at the time, now replaced with
# categories).
#-------------------------------------------------------------------

TidyDataset = matrix(0,nrow=30*6,ncol=68)
TidyDataset[,1] = sort(rep(1:30,6))
TidyDataset[,2] = rep(activity_labels[,2],30)


# Since quotes have been introduced, need to remove them.
TidyDataset = as.data.frame(TidyDataset)
colnames(TidyDataset) = VariableNames
TidyDataset[1:18,1:4]


# Now compute averages per subject per activity per variable.
Subject = Dataset4[,1]
Activity = Dataset4[,2]
for(r in 1:180) {
	for(c in 3:68) {
		temp = Dataset4[,c]
		TidyDataset[r,c] = mean(temp[Subject == TidyDataset[r,1] & 
			Activity == TidyDataset[r,2]])
	}
}


# Make sure everything except 2nd column is numeric, then 
# save tidy dataset.
TidyDataset[,1] = as.numeric(TidyDataset[,1])
for(c in 3:68) {
	TidyDataset[,c] = as.numeric(TidyDataset[,c])
}

TidyDataset[1:18,1:4]
write.table(TidyDataset,"Tidy_Dataset.txt",row.name=FALSE)
