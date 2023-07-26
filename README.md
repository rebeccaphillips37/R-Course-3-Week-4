# R-Course-3-Week-4
The script run_analysis.R takes the following eight datasets and merges six of them into one master original (raw) dataset.
The last two datasets are used to define variable names and activity labels.

1) subject_train.txt	This dataset contains 7352 subject numbers between 1 and 30 for the train data (some digits are contained in subject_test.txt).
2) y_train.txt		This dataset contains 7352 activity numbers between 1 and 6 for the train data.
3) X_train.txt		This dataset contains 7352 subjects and 561 variable measurements for the train data.
4) subject_test.txt	This dataset contains 2947 subject numbers between 1 and 30 for the test data (some digits are contained in subject_train.txt).
5) y_test.txt		This dataset contains 2947 activity numbers between 1 and 6 for the test data.
6) X_test.txt		This dataset contains 2947 subjects and 561 variable measurements for the test data.
7) features.txt		This dataset contains 561 variable measurement names used for both train and test data.
8) activity_labels.txt	This dataset contains activity names corresponding to numbers 1 to 6.


The datasets are merged, rearranged, and tidied in five major steps.

--------------------------------------------------------------------------------------------------------------------------------------------------------
PART 1
--------------------------------------------------------------------------------------------------------------------------------------------------------
The first six datasets are merged together, making one master original dataset with 10299 rows and 563 columns.

The Train dataset (7532 x 563) is created according to the following steps:
1) Column 1 is from subject_train.txt.
2) Column 2 is from y_train.txt.
3) Columns 3 - 563 are from X_train.txt.

The Test dataset (2947 x 563) is created according to the following steps:
1) Column 1 is from subject_test.txt.
2) Column 2 is from y_test.txt.
3) Columns 3 - 563 are from X_test.txt.

The Original dataset (10299 x 563) is created by stacking Train on top of Test.
Next, Original is ordered in ascending order by Column 1 and then Column 2 (so subjects ordered 1 - 30 and for each subject, activity ordered 1 - 6).
Note that the column headers are currently V1 for subject, V1.1 for activity, v1.2 for the first variable (originally called V1), and V2-V561 for
all remaining variables. These names will be changed in a later step.


--------------------------------------------------------------------------------------------------------------------------------------------------------
PART 2
--------------------------------------------------------------------------------------------------------------------------------------------------------
The columns for which a mean or standard deviation was computed are extracted, and the remaining columns are dropped. These columns occur at the
following column indices in features.txt, but note that these correspond to the original 1 - 561 columns of variables (before the extra two columns
were added in Part 1). There are 66 relevant columns. The resulting dataset, Dataset2, has 10299 rows and 68 columns.
The following lists contain the original column indices and the original variable names, which will be given more user friendly names later.

1   tBodyAcc-mean()-X			125 tBodyGyro-std()-Y			270 fBodyAcc-std()-Y
2   tBodyAcc-mean()-Y			126 tBodyGyro-std()-Z			271 fBodyAcc-std()-Z
3   tBodyAcc-mean()-Z			161 tBodyGyroJerk-mean()-X		345 fBodyAccJerk-mean()-X
4   tBodyAcc-std()-X			162 tBodyGyroJerk-mean()-Y		346 fBodyAccJerk-mean()-Y
5   tBodyAcc-std()-Y			163 tBodyGyroJerk-mean()-Z		347 fBodyAccJerk-mean()-Z
6   tBodyAcc-std()-Z			164 tBodyGyroJerk-std()-X		348 fBodyAccJerk-std()-X
41  tGravityAcc-mean()-X		165 tBodyGyroJerk-std()-Y		349 fBodyAccJerk-std()-Y
42  tGravityAcc-mean()-Y		166 tBodyGyroJerk-std()-Z		350 fBodyAccJerk-std()-Z
43  tGravityAcc-mean()-Z		201 tBodyAccMag-mean()			424 fBodyGyro-mean()-X
44  tGravityAcc-std()-X			202 tBodyAccMag-std()			425 fBodyGyro-mean()-Y
45  tGravityAcc-std()-Y			214 tGravityAccMag-mean()		426 fBodyGyro-mean()-Z
46  tGravityAcc-std()-Z			215 tGravityAccMag-std()		427 fBodyGyro-std()-X
81  tBodyAccJerk-mean()-X		227 tBodyAccJerkMag-mean()		428 fBodyGyro-std()-Y
82  tBodyAccJerk-mean()-Y		228 tBodyAccJerkMag-std()		429 fBodyGyro-std()-Z
83  tBodyAccJerk-mean()-Z		240 tBodyGyroMag-mean()			503 fBodyAccMag-mean()
84  tBodyAccJerk-std()-X		241 tBodyGyroMag-std()			504 fBodyAccMag-std()
85  tBodyAccJerk-std()-Y		253 tBodyGyroJerkMag-mean()		516 fBodyBodyAccJerkMag-mean()
86  tBodyAccJerk-std()-Z		254 tBodyGyroJerkMag-std()		517 fBodyBodyAccJerkMag-std()
121 tBodyGyro-mean()-X			266 fBodyAcc-mean()-X			529 fBodyBodyGyroMag-mean()
122 tBodyGyro-mean()-Y			267 fBodyAcc-mean()-Y			530 fBodyBodyGyroMag-std()
123 tBodyGyro-mean()-Z			268 fBodyAcc-mean()-Z			542 fBodyBodyGyroJerkMag-mean()
124 tBodyGyro-std()-X			269 fBodyAcc-std()-X			543 fBodyBodyGyroJerkMag-std()


--------------------------------------------------------------------------------------------------------------------------------------------------------
PART 3
--------------------------------------------------------------------------------------------------------------------------------------------------------
Use descriptive activity names to name the activities. Here Column 2, which currently has numbers 1 to 6, is replaced with the activity names from
activity_labels.txt according to the following labels. The resulting dataset, Dataset3, has 10299 rows and 68 columns.

1            WALKING
2   WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4            SITTING
5           STANDING
6             LAYING


--------------------------------------------------------------------------------------------------------------------------------------------------------
PART 4
--------------------------------------------------------------------------------------------------------------------------------------------------------
Appropriately label the dataset with descriptive variable names. The resulting dataset, Dataset4, has 10299 rows and 68 columns.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Each of the following sets of four entries contain the column number, the original index number, the original variable name, the new user-friendly
variable name, and a brief description of the variable.

1	NA	subject_train & subject_test	subject
		Subject number 1 - 30
2	NA	y_train & y_test		activity
		Activity label (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
3	1	tBodyAcc-mean()-X		timeBodyAccelerationX_mean
		Time domain signal separated into body acceleration signal in the X direction, mean.
4	2	tBodyAcc-mean()-Y		timeBodyAccelerationY_mean
		Time domain signal separated into body acceleration signal in the Y direction, mean.
5	3	tBodyAcc-mean()-Z		timeBodyAccelerationZ_mean
		Time domain signal separated into body acceleration signal in the Z direction, mean.
6	4	tBodyAcc-std()-X		timeBodyAccelerationX_sd
		Time domain signal separated into body acceleration signal in the X direction, standard deviation.
7	5	tBodyAcc-std()-Y		timeBodyAccelerationY_sd
		Time domain signal separated into body acceleration signal in the Y direction, standard deviation.
8	6	tBodyAcc-std()-Z		timeBodyAccelerationZ_sd
		Time domain signal separated into body acceleration signal in the Z direction, standard deviation.
9	41	tGravityAcc-mean()-X		timeGravityAccelerationX_mean
		Time domain signal separated into gravity acceleration signal in the X direction, mean.
10	42	tGravityAcc-mean()-Y		timeGravityAccelerationY_mean
		Time domain signal separated into gravity acceleration signal in the Y direction, mean.
11	43	tGravityAcc-mean()-Z		timeGravityAccelerationZ_mean
		Time domain signal separated into gravity acceleration signal in the Z direction, mean.
12	44	tGravityAcc-std()-X		timeGravityAccelerationX_sd
		Time domain signal separated into gravity acceleration signal in the X direction, standard deviation.
13	45	tGravityAcc-std()-Y		timeGravityAccelerationY_sd
		Time domain signal separated into gravity acceleration signal in the Y direction, standard deviation.
14	46	tGravityAcc-std()-Z		timeGravityAccelerationZ_sd
		Time domain signal separated into gravity acceleration signal in the Z direction, standard deviation.
15	81	tBodyAccJerk-mean()-X		timeBodyAccelerationJerkX_mean
		Time domain signal separated into body linear acceleration Jerk signal in the X direction, mean.
16	82	tBodyAccJerk-mean()-Y		timeBodyAccelerationJerkY_mean
		Time domain signal separated into body linear acceleration Jerk signal in the Y direction, mean.
17	83	tBodyAccJerk-mean()-Z		timeBodyAccelerationJerkZ_mean
		Time domain signal separated into body linear acceleration Jerk signal in the Z direction, mean.
18	84	tBodyAccJerk-std()-X		timeBodyAccelerationJerkX_sd
		Time domain signal separated into body linear acceleration Jerk signal in the X direction, standard deviation.
19	85	tBodyAccJerk-std()-Y		timeBodyAccelerationJerkY_sd
		Time domain signal separated into body linear acceleration Jerk signal in the Y direction, standard deviation.
20	86	tBodyAccJerk-std()-Z		timeBodyAccelerationJerkZ_sd
		Time domain signal separated into body linear acceleration Jerk signal in the Z direction, standard deviation.
21	121	tBodyGyro-mean()-X		timeBodyAngularX_mean
		Time domain signal separated into body angular velocity signal in the X direction, mean.
22	122	tBodyGyro-mean()-Y		timeBodyAngularY_mean
		Time domain signal separated into body angular velocity signal in the Y direction, mean.
23	123	tBodyGyro-mean()-Z		timeBodyAngularZ_mean
		Time domain signal separated into body angular velocity signal in the Z direction, mean.
24	124	tBodyGyro-std()-X		timeBodyAngularX_sd
		Time domain signal separated into body angular velocity signal in the X direction, standard deviation.
25	125	tBodyGyro-std()-Y		timeBodyAngularY_sd
		Time domain signal separated into body angular velocity signal in the Y direction, standard deviation.
26	126	tBodyGyro-std()-Z		timeBodyAngularZ_sd
		Time domain signal separated into body angular velocity signal in the Z direction, standard deviation.
27	161	tBodyGyroJerk-mean()-X		timeBodyAngularJerkX_mean
		Time domain signal separated into body angular velocity Jerk signal in the X direction, mean.
28	162	tBodyGyroJerk-mean()-Y		timeBodyAngularJerkY_mean
		Time domain signal separated into body angular velocity Jerk signal in the Y direction, mean.
29	163	tBodyGyroJerk-mean()-Z		timeBodyAngularJerkZ_mean
		Time domain signal separated into body angular velocity Jerk signal in the Z direction, mean.
30	164	tBodyGyroJerk-std()-X		timeBodyAngularJerkX_sd
		Time domain signal separated into body angular velocity Jerk signal in the X direction, standard deviation.
31	165	tBodyGyroJerk-std()-Y		timeBodyAngularJerkY_sd
		Time domain signal separated into body angular velocity Jerk signal in the Y direction, standard deviation.
32	166	tBodyGyroJerk-std()-Z		timeBodyAngularJerkZ_sd
		Time domain signal separated into body angular velocity Jerk signal in the Z direction, standard deviation.
33	201	tBodyAccMag-mean()		timeBodyAccelerationMagnitude_mean
		Magnitude (in Euclidean norm) of time domain signal separated into body acceleration signal, mean.
34	202	tBodyAccMag-std()		timeBodyAccelerationMagnitude_sd
		Magnitude (in Euclidean norm) of time domain signal separated into body acceleration signal, standard deviation.
35	214	tGravityAccMag-mean()		timeGravityAccelerationMagnitude_mean
		Magnitude (in Euclidean norm) of time domain signal separated into gravity acceleration signal, mean.
36	215	tGravityAccMag-std()		timeGravityAccelerationMagnitude_sd
		Magnitude (in Euclidean norm) of time domain signal separated into gravity acceleration signal, standard deviation.
37	227	tBodyAccJerkMag-mean()		timeBodyAccelerationJerkMagnitude_mean
		Magnitude (in Euclidean norm) of time domain signal separated into body linear acceleration Jerk signal, mean.
38	228	tBodyAccJerkMag-std()		timeBodyAccelerationJerkMagnitude_sd
		Magnitude (in Euclidean norm) of time domain signal separated into body linear acceleration Jerk signal, standard deviation.
39	240	tBodyGyroMag-mean()		timeBodyAngularMagnitude_mean
		Magnitude (in Euclidean norm) of time domain signal separated into body angular velocity signal, mean.
40	241	tBodyGyroMag-std()		timeBodyAngularMagnitude_sd
		Magnitude (in Euclidean norm) of time domain signal separated into body angular velocity signal, standard deviation.
41	253	tBodyGyroJerkMag-mean()		timeBodyAngularJerkMagnitude_mean
		Magnitude (in Euclidean norm) of time domain signal separated into body angular velocity Jerk signal, mean.
42	254	tBodyGyroJerkMag-std()		timeBodyAngularJerkMagnitude_sd
		Magnitude (in Euclidean norm) of time domain signal separated into body angular velocity Jerk signal, standard deviation.
43	266	fBodyAcc-mean()-X		fftBodyAccelerationX_mean
		Frequency domain signal separated into body acceleration signal in the X direction, mean.
44	267	fBodyAcc-mean()-Y		fftBodyAccelerationY_mean
		Frequency domain signal separated into body acceleration signal in the Y direction, mean.
45	268	fBodyAcc-mean()-Z		fftBodyAccelerationZ_mean
		Frequency domain signal separated into body acceleration signal in the Z direction, mean.
46	269	fBodyAcc-std()-X		fftBodyAccelerationX_sd
		Frequency domain signal separated into body acceleration signal in the X direction, standard deviation.
47	270	fBodyAcc-std()-Y		fftBodyAccelerationY_sd
		Frequency domain signal separated into body acceleration signal in the Y direction, standard deviation.
48	271	fBodyAcc-std()-Z		fftBodyAccelerationZ_sd
		Frequency domain signal separated into body acceleration signal in the Z direction, standard deviation.
49	345	fBodyAccJerk-mean()-X		fftBodyAccelerationJerkX_mean
		Frequency domain signal separated into body linear acceleration Jerk signal in the X direction, mean.
50	346	fBodyAccJerk-mean()-Y		fftBodyAccelerationJerkY_mean
		Frequency domain signal separated into body linear acceleration Jerk signal in the Y direction, mean.
51	347	fBodyAccJerk-mean()-Z		fftBodyAccelerationJerkZ_mean
		Frequency domain signal separated into body linear acceleration Jerk signal in the Z direction, mean.
52	348	fBodyAccJerk-std()-X		fftBodyAccelerationJerkX_sd
		Frequency domain signal separated into body linear acceleration Jerk signal in the X direction, standard deviation.
53	349	fBodyAccJerk-std()-Y		fftBodyAccelerationJerkY_sd
		Frequency domain signal separated into body linear acceleration Jerk signal in the Y direction, standard deviation.
54	350	fBodyAccJerk-std()-Z		fftBodyAccelerationJerkZ_sd
		Frequency domain signal separated into body linear acceleration Jerk signal in the Z direction, standard deviation.
55	424	fBodyGyro-mean()-X		fftBodyAngularX_mean
		Frequency domain signal separated into body angular velocity signal in the X direction, mean.
56	425	fBodyGyro-mean()-Y		fftBodyAngularY_mean
		Frequency domain signal separated into body angular velocity signal in the Y direction, mean.
57	426	fBodyGyro-mean()-Z		fftBodyAngularZ_mean
		Frequency domain signal separated into body angular velocity signal in the Z direction, mean.
58	427	fBodyGyro-std()-X		fftBodyAngularX_sd
		Frequency domain signal separated into body angular velocity signal in the X direction, standard deviation.
59	428	fBodyGyro-std()-Y		fftBodyAngularY_sd
		Frequency domain signal separated into body angular velocity signal in the Y direction, standard deviation.
60	429	fBodyGyro-std()-Z		fftBodyAngularZ_sd
		Frequency domain signal separated into body angular velocity signal in the Z direction, standard deviation.
61	503	fBodyAccMag-mean()		fftBodyAccelerationMagnitude_mean
		Magnitude (in Euclidean norm) of frequency domain signal separated into body acceleration signal, mean.
62	504	fBodyAccMag-std()		fftBodyAccelerationMagnitude_sd
		Magnitude (in Euclidean norm) of frequency domain signal separated into body acceleration signal, standard deviation.
63	516	fBodyBodyAccJerkMag-mean()	fftBodyAccelerationJerkMagnitude_mean
		Magnitude (in Euclidean norm) of frequency domain signal separated into body linear acceleration Jerk signal, mean.
64	517	fBodyBodyAccJerkMag-std()	fftBodyAccelerationJerkMagnitude_sd
		Magnitude (in Euclidean norm) of frequency domain signal separated into body linear acceleration Jerk signal, standard deviation.
65	529	fBodyBodyGyroMag-mean()		fftBodyAngularMagnitude_mean
		Magnitude (in Euclidean norm) of frequency domain signal separated into body angular velocity signal, mean.
66	530	fBodyBodyGyroMag-std()		fftBodyAngularMagnitude_sd
		Magnitude (in Euclidean norm) of frequency domain signal separated into body angular velocity signal, standard deviation.
67	542	fBodyBodyGyroJerkMag-mean()	fftBodyAngularJerkMagnitude_mean
		Magnitude (in Euclidean norm) of frequency domain signal separated into body angular velocity Jerk signal, mean.
68	543	fBodyBodyGyroJerkMag-std()	fftBodyAngularJerkMagnitude_sd
		Magnitude (in Euclidean norm) of frequency domain signal separated into body angular velocity Jerk signal, standard deviation.


--------------------------------------------------------------------------------------------------------------------------------------------------------
PART 5
--------------------------------------------------------------------------------------------------------------------------------------------------------
From Part 4, create a second, independent tidy dataset with the average of each variable for each activity and each subject. There are 30 subjects, 6 activities, and 66 variables. The result will be a 180 x 68 dataset, saved as TidyDataset.
The dataset was already ordered in Part 1 by subject (1-30) and then by activity (1-6 at the time, now replaced with categories).
The first 18 rows and first 4 columns are shown below as an example of what this tidy dataset looks like.

subject           activity timeBodyAccelerationX_mean timeBodyAccelerationY_mean
      1            WALKING                  0.2773308               -0.017383819
      1   WALKING_UPSTAIRS                  0.2554617               -0.023953149
      1 WALKING_DOWNSTAIRS                  0.2891883               -0.009918505
      1            SITTING                  0.2612376               -0.001308288
      1           STANDING                  0.2789176               -0.016137590
      1             LAYING                  0.2215982               -0.040513953
      2            WALKING                  0.2773308               -0.017383819
      2   WALKING_UPSTAIRS                  0.2554617               -0.023953149
      2 WALKING_DOWNSTAIRS                  0.2891883               -0.009918505
      2            SITTING                  0.2612376               -0.001308288
      2           STANDING                  0.2789176               -0.016137590
      2             LAYING                  0.2215982               -0.040513953
      3            WALKING                  0.2773308               -0.017383819
      3   WALKING_UPSTAIRS                  0.2554617               -0.023953149
      3 WALKING_DOWNSTAIRS                  0.2891883               -0.009918505
      3            SITTING                  0.2612376               -0.001308288
      3           STANDING                  0.2789176               -0.016137590
      3             LAYING                  0.2215982               -0.040513953
