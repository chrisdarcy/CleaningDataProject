# CleaningDataProject
Getting And Cleaning Data Project


Sorry ran out of time and memory

This version only processes 300 lines

##The Steps

1. Limited run to only to 300 rows of each input file
2. Create a data frame with column numbers and titles for means & std. I extracted from Features.txt only those columns with mean & std values. I never got round to extracting this info as part of the script.
      Example
        |column,description|
        |------------------|
        |1,tBodyAcc-mean-X|
        |2,tBodyAcc-mean-Y|
        |3,tBodyAcc-mean-Z|
        |4,tBodyAcc-std-X|
        |5,tBodyAcc-std-Y|
        |6,tBodyAcc-std-Z|
        |41,tGravityAcc-mean-X|
        |------------------|
  
3.     Set Set.ID to indicate which set of data we are using i.e. "Train" or "Test"
4.     Create a directory vector to make read commands a bit easier to read
5.     Read x_test.txt file (only 300 lines) all 561 columns into dataframe df
6     Weed out all those columns that are not mean or std. store in df.mas
7     Set the column names in df.mas to meaninful values.
8     Create dataframe with all Subject data from subject_test.txt (only 300 lines)
9     Set the column names in subject dataframe to meaninful values.
8     Create dataframe with all Activity data from y_test.txt (only 300 lines)
9     Set the column names in Activity dataframe to meaninful values.
10    Replace INT values with descriptive Activity names
11    Add columns to df.mas for activity, subject and set.ID
12    Clean up temporary vectors and dataframes

13    Repeat 3 through 11 for Train set

14    Merge Train set and Test set into data frame dfDataSets

15    Create data frame for step 5. Store averages for activity & subject. store in dfx
16    write dfx to txt file


