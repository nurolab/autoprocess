tbss_1_preproc *.nii.gz
tbss_2_reg -T
tbss_3_postreg -S
#cd stats
#fsleyes all_FA -dr 0 0.8 mean_FA_skeleton -dr 0.2 0.8 -cm Green
#cd ..
tbss_4_prestats 0.2
cd stats
randomise -i all_FA_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500 --T2
randomise -i all_FA_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500
