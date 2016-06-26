# Course project for the Getting and Cleaning Data course

It assumes that the current directory is the root directory of the unzipped data.

The R script, run_analysis.R, does the following:

1. Import the data from the text files into data frames
2. Combine the training  and test data into one dataframe
3. Extract columns that correspond to the mean and standard deviation from the previous combined data frame
4. Combine the previous dataframe with activity information
5. Merge the resulting dataframe in order to add the activity description
6. Add the subject information to the resulting data frame
7. Calculate the mean value of each variable for each subject and activity
8. Save the result to a text file named mean_subj_activity.txt
