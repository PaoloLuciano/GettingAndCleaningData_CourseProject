---
title: "CodeBook"
author: "Gianpaolo Luciano Rivera"
date: "April 2015"
output: html_document
---

* **subject**
    All of the participants from the study, integers from 1 to 30 each one representing all the subjects.

* **activity**
    Factor variable naming the six activities performed by the participants. (In alphabetical order)
    + Lying
    + Sitting
    + Standing
    + Walking
    + Walking downstairs
    + Walking upstairs

* **variable**
    Factor variable naming the features measured by the smartphones, all of them contain the string "mean" and "std".

* **mean_features**
    Mean of each one of the variables performed by the participants. Since each activity was performed several times it would be natural to have a mean  for each one of them.