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
	ifile=`find . -name "*ep2ddiff*.nii"` # Find diffusion weighted image (Input image)
	bvec_file=`find . -name "*ep2ddiff*.bvec"`
	bval_file=`find . -name "*ep2ddiff*.bval"`
	brain_mask_file=`find . -name "nodif_brain_mask.nii.gz"`
	Acq_param_file=../../Acquisition_parameter.txt
	index_file=../../index.txt
	save_location=`pwd`/data # Prefix for ECC files
	# eddy_openmp for parallel computing of each subject files
	echo eddy_openmp --imain=$ifile --mask=$brain_mask_file --bvals=$bval_file --bvecs=$bvec_file --acqp=$Acq_param_file --index=$index_file --out=$save_location --ref_scan_no=0 --ol_nstd=4 --verbose --repol
	eddy_openmp --imain=$ifile --mask=$brain_mask_file --bvals=$bval_file --bvecs=$bvec_file --acqp=$Acq_param_file --index=$index_file --out=$save_location --ref_scan_no=0 --ol_nstd=4 --verbose --repol
	cd ..
done
