#!/bin/sh
# FSL based DTI analysis batch processing pipeline

#--------------------------------------------------------------
# set working directory below this line
wd='/media/ubuntu/Data/Project_CD/DTI_analysis/Data'
#--------------------------------------------------------------

cd $wd
echo "Working directory is $wd, only folders for subject DTI data should be present in this directory" 

# Creating shell variables
total_fols=0 # total folder to be processed
counter=0 # No. of processed folders
fols=`ls -d */` # List of folders (Folder names)

# This for loop calculates number of folders
for j in $fols
do
	total_fols=`expr $total_fols + 1`
done

# Batch processing of DTI data
for i in $fols
do
	counter=`expr $counter + 1`
	cd $i
	echo "\e[1;34mStep 2 - ($counter/$total_fols) - Performing BET for `basename $i /` \e[m"
	echo bet nodif.nii.gz nodif_brain.nii.gz -c `awk NR==$counter ../../center_coordinates.txt` -f 0.15 -m # Read brain-center coordinates from center_coordinates.txt file for each subject
	bet nodif.nii.gz nodif_brain.nii.gz -c `awk NR==$counter ../../center_coordinates.txt` -f 0.15 -m # Set threshold to be 0.15 and generate brain mask as well
	cd ..
done
