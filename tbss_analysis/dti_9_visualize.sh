#!/bin/bash

# Details of group 
High= # Number of participants in one group
Low=  # Number of participants in other group
# To generate group test based design matrix either you can use ttest based design matrix (simple & easy) or Glm command based design matrix (complex and powerful) design matrix
design_ttest2 design $High $Low
#To generate uncorrected (unthresholded or raw) tstat images you can choose to perform basic ttest using following command
randomise -i all_FA_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500
#To generate TFCE (Threshold-Free Cluster Enhancement) corrected (FSL' recommended method) tstat images you can run randomise command with --T2 option
randomise -i all_FA_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500 --T2

# Contrast 1 is control>patient test and contrast 2 is control<patient test. The raw (unthresholded) tstat images are tbss_tstat1 and tbss_tstat2 respectively. The TFCE (Threshold-Free Cluster Enhancement) p-value images (fully corrected for multiple comparisons across space) are tbss_tfce_corrp_tstat1 and tbss_tfce_corrp_tstat2 (note, these are actually 1-p for convenience of display, so thresholding at .95 gives significant clusters).

# To visualize tracts based differences using FSL we chose to overlay mean FA skeleton image on standard MNI152 T1 image. Skeleton was shown in Green color with display range (0.2-0.8) tstat1 was shown with Red-Yellow colormap with display range (3-6) and tstat2 image was shown in Blue-Lightblue colormap with same display range (3-6). Green for skeleton Red for 
 
fsleyes $FSLDIR/data/standard/MNI152_T1_1mm mean_FA_skeleton -cm Green -dr 0.2 0.8 tbss_tstat1 -cm Red-Yellow -dr 3 6 tbss_tstat2 -cm Blue-Lightblue -dr 3 6

# If you are using 'fslview' choose command given below
fslview $FSLDIR/data/standard/MNI152_T1_1mm mean_FA_skeleton -l Green -b 0.2,0.7 tbss_tfce_corrp_tstat1 -l Red-Yellow -b 0.95,1
# If you are using 'fsleyes' choose command given below for only first contrast (tstat1) display range is (0.95-1) since it is 1-p image to see significant differences
fsleyes $FSLDIR/data/standard/MNI152_T1_1mm mean_FA_skeleton -cm Green -dr 0.2 0.7 tbss_tfce_corrp_tstat1 -cm Red-Yellow -dr 0.95 1
# If you are using 'fsleyes' choose command given below for both contrast (tstat1 & tstat2)
fsleyes $FSLDIR/data/standard/MNI152_T1_1mm mean_FA_skeleton -cm Green -dr 0.2 0.7 tbss_tfce_corrp_tstat1 -cm Red-Yellow -dr 0.95 1 tbss_tfce_corrp_tstat2 -cm Blue-Lightblue -dr 0.95 1


