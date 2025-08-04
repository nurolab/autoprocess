# This script opens brain images for reviewing of BET operation performed by mri watershed algorithm
# Date: 12 April 2021

total_files=0
for i in `ls -d *t1mprage*/`
do
	total_files=`expr $total_files + 1`
done

echo $total_files directories found
counter=0
for i in `ls -d *t1mprage*/`
do
	counter=`expr $counter + 1`
	echo Viewing directory no. $counter/$total_files $i
	cd $i
	# 2d brain visualization for inspection
	freeview mri/brain.mgz
	freeview -v \
	mri/T1.mgz \
	mri/wm.mgz \
	mri/brainmask.mgz \
	mri/aseg.mgz:colormap=lut:opacity=0.2 \
	-f surf/lh.white:edgecolor=blue \
	surf/lh.pial:edgecolor=red \
	surf/rh.white:edgecolor=blue \
	surf/rh.pial:edgecolor=red

	# 3d brain visualization for inspection
	freeview -f surf/lh.pial:annot=aparc.annot:name=pial_aparc:visible=0 \
	surf/lh.pial:annot=aparc.a2009s.annot:name=pial_aparc_des:visible=0 \
	surf/lh.inflated:overlay=lh.thickness:overlay_threshold=0.1,3::name=inflated_thickness:visible=0 \
	surf/lh.inflated:visible=0 \
	surf/lh.white:visible=0 \
	surf/lh.pial \
	--viewport 3d

	cd ..
	s_name=`basename $i /`
	file_name=BET_comments.txt
	echo $counter/$total_files $s_name >> $file_name
	nano $file_name
done
