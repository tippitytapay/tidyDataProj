# tidyDataProj
This repository contains an R script called run_analysis.R that is designed to
clean and transform a certain set of raw data, as well as codebook.txt that
describes the variables contained in the output of run_analysis.R.

The run_analysis.R script contains a function createTidyData that will combine
and clean several pieces of raw data from the (decompressed) folder

UCI HAR Dataset

This folder must be contained in the working directory and decompressed for the
script to run properly. createTidyData then averages ceratin variables in the
raw data by subject and activity and writes the restult to tidyMeansTable.txt
in the working directory. More information on the data and the varaibles is
available in codebook.txt.

The output, tidyMeansTable.txt, can easily be loaded into R with the command

read.table("tidyMeansTalbe.txt", header = TRUE)

if tidyMeansTable.txt is still in the working directory.