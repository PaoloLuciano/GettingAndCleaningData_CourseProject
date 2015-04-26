---
title: "README"
author: "Gianpaolo Luciano Rivera"
date: "April, 2015"
output: html_document
---

## General Information
This study was performed by a group of scientists to test and measure new wearable computing systems.

The study was carried out with a gruop of 30 volunteers (subjects from 1 to 30). 
Each one was told to perform 6 tasks while wearing a smartphone (Samsung Galaxy S II) on the waist. 

The tasks were the following:
* Lying
* Sitting
* Standing
* Walking
* Walking downstairs
* Walking upstairs

They recorded 561 variables of several observations on each activity for each participant.
Finally they separated the participants into 2 groups the train and test sets.

## Procedure
More detailed analysis can be seen directly on the run_analysis.R file

1. Getting data
2. Reading data
    + Measurments
    + Labels
3. Naming and merging the data sets
    + Naming the Y set (activities)
    + Naming the subject set (subjects)
    + Merging the activity ID with the descriptive Variable (both train and test)
    + Naming features (X sets)
    + Putting everything together (already with names)
4. Thinning data
    + Getting relevant "mean" and "std" columns
    + Ordering the data set
5. Summarising the final data set
    + Melting into long form
    + Getting the mean of each obersvation
    
## Notes/Disclaimer

* The final data set is a a tidy data set beacause each column represents only one variable. There is a big discussion of this beacuse it seems un-natural to have the subjects and activities repeated, but this is a LONG tidy data set. Each row represents one and only one specific combination of measurments. One for each subject-activity-measurment combination

* I did the steps slightly out of order becaused it seemed more natural (and easy) to name everything and then extract the columns than to do the former first.

* The comments on the run_analysis.R are way more detailed and complete

* The activities are in alphabetical order rather than the native id number. Still everything is in there

* Sorry for any typo.
    