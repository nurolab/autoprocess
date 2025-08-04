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

# Batch processing of DTI data - Step 1 fslroi
for i in $fols
do
  counter=`expr $counter + 1`
  cd $i
  ifile=`find . -name "*ep2ddiff*.nii"` # Find diffusion weighted image (Input image)
  nd_of=nodif.nii # Nodiffusion outout file
  echo "\e[1;33mStep 1 - ($counter/$total_fols) - Extracting First DTI volume (No diffusion) from $ifile for `basename $i /`\e[m" 
  echo fslroi $ifile $nd_of 0 1 # Displaying the upcoming command
  fslroi $ifile $nd_of 0 1
  cd ..
done
