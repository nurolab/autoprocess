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
	bvec_file=`find . -name "*ep2ddiff*.bvec"`
	bval_file=`find . -name "*ep2ddiff*.bval"`
	brain_mask_file=`find . -name "nodif_brain_mask.nii.gz"`
	outfile=`find . -name "Subject_*.nii.gz"`
	save_dti_location=`pwd`/dti_`basename $i /`
	echo "\e[1;36mStep 5 - ($counter/$total_fols) - Doing DTIFIT for `basename $i /` \e[m"
	echo dtifit --data=$outfile --out=$save_dti_location --mask=$brain_mask_file --bvecs=$bvec_file --bvals=$bval_file
	dtifit --data=$outfile --out=$save_dti_location --mask=$brain_mask_file --bvecs=$bvec_file --bvals=$bval_file
	cd ..
done

