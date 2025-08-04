#!/bin/sh
# This shell script runs freesurfer based preprocessing pipelines for all selected subjects using parallel processing
# Author: Deepak Sharma

cores=`nproc --all` # Count number of CPU cores available to check how many of them can be utilised for parallel processing
echo $cores cores are available # Print the number of cores available in your hardware
max_cores=`expr $cores - 4` # Leave 4 cores for system usage
n_job=0 # Initialize background jobs

list=`ls *.nii` # Select all files with .nii extension to process
# Display total number of .nii files present inside working directory
  for i in $list
  do
    n_job=`expr $n_job + 1`
  done
  echo "There are $n_job files"

# Run automated parallel processsing if total number of files present inside working directory is less than total processor cores
  if [ $n_job -lt $max_cores ];
  then
  SUBJECTS_DIR=`pwd`
  for i in $list
  do
    echo $i
    # Open a gnome terminal to process each individual .nii file with a dedicated core to implement parallel processing
    # Run FreeSurfer powered  recon-all processing in automated manner for all .nii files sequentially
    gnome-terminal -- bash -c "echo Subjects directory is : $SUBJECTS_DIR; echo Processing for : $i; recon-all -i $i -s `basename $i .nii` -autorecon1; recon-all -s `basename $i .nii` -autorecon2; recon-all -s `basename $i .nii` -autorecon3; recon-all -s `basename $i .nii` -qcache; exec bash"
  done
  fi
