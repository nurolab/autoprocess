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
	echo fslmaths data.eddy_outlier_free_data.nii.gz -mul nodif_brain_mask.nii.gz Subject_`basename $i /`
	fslmaths data.eddy_outlier_free_data.nii.gz -mul nodif_brain_mask.nii.gz Subject_`basename $i /`
	cd ..
done
