#!/bin/sh
# FSL based DTI analysis batch processing pipeline

#--------------------------------------------------------------
# set working directory below this line
wd='/media/ubuntu/Data/DTI_analysis/Data'
analysis_dir='/media/ubuntu/Data/DTI_analysis/Analysis'
#--------------------------------------------------------------

cd $analysis_dir
echo "Working directory is $wd" 
echo "Analysis directory is $analysis_dir" 

# Creating shell variables
cd FA
files=`ls` # List of files
counter=0

# This for loop calculates number of folders
for j in $total_files
do
  total_files=`expr $total_files + 1`
done

# Batch processing of DTI data
for i in $files
do
  counter=`expr $counter + 1`
  echo "$counter/$total_files processed"
  echo mv $i `awk NR==$counter ../eft_cat.txt`_$i
  mv $i `awk NR==$counter ../eft_cat.txt`_$i
done
