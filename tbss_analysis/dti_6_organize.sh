#!/bin/sh
# FSL based DTI analysis batch processing pipeline

#--------------------------------------------------------------
# set working directory below this line
wd='/media/ubuntu/Data/Project_CD/DTI_analysis/Data'
#--------------------------------------------------------------

cd $wd
echo "Working directory is $wd, only folders for subject DTI data should be present in this directory" 

# Creating shell variables
fols=`ls -d */` # List of folders (Folder names)

mkdir ../Analysis 2>/dev/null
cd ../Analysis
analysis_dir=`pwd`
mkdir MD L1 L2 L3 V1 V2 V3 S0 MO FA 2>/dev/null

cd $wd
echo "\e[1;37mCopying each individual's DTI files (MD L1 L2 L3 V1 V2 V3 S0 MO FA ) in Analysis folder PATH = $analysis_dir \e[m"
for i in $fols
do
	cd $i
	cp `find . -name "dti_*_MD.nii.gz"` ../../Analysis/MD
	cp `find . -name "dti_*_L1.nii.gz"` ../../Analysis/L1
	cp `find . -name "dti_*_L2.nii.gz"` ../../Analysis/L2
	cp `find . -name "dti_*_L3.nii.gz"` ../../Analysis/L3
	cp `find . -name "dti_*_V1.nii.gz"` ../../Analysis/V1
	cp `find . -name "dti_*_V2.nii.gz"` ../../Analysis/V2
	cp `find . -name "dti_*_V3.nii.gz"` ../../Analysis/V3
	cp `find . -name "dti_*_S0.nii.gz"` ../../Analysis/S0
	cp `find . -name "dti_*_MO.nii.gz"` ../../Analysis/MO
	cp `find . -name "dti_*_FA.nii.gz"` ../../Analysis/FA
	cd ..
done
echo "Copying complete"
