#!/bin/bash
GREEN='\033[1;32m'
NO_COLOR='\033[0m'

#경로에 맞게 수정
gravuty_dir=/home/vuno/gravuty
cxr_dir=/home/vuno/chest_xray
ba_dir=/home/vuno/boneage
fai_dir=/home/vuno/fundus
db_dir=/home/vuno/dist_db
dbad_dir=/home/vuno/dist_dbad
lct_dir=/home/vuno/dist_lct

# gravuty Data 삭제
if [ -d $gravuty_dir ]; then
	echo -e "\n${GREEN}Gravuty Data를 삭제합니다. ${NO_COLOR}"
	find $gravuty_dir/docker/volumes/scp_store_data/* -mtime +30 -exec rm -rf {} \;
            find $gravuty_dir/docker/volumes/dcmtk/spool/ -name '*' -mtime +7 -exec rm -rf {} \;
            find $gravuty_dir/docker/volumes/dcmtk/failed/ -name '*' -mtime +7 -exec rm -rf {} \;
fi

# chest_xray Data 삭제
if [ -d $cxr_dir ]; then
	echo -e "\n${GREEN}CXR Data를 삭제합니다.${NO_COLOR}"
	find $cxr_dir/volumes/resource/pacs/*  -mtime +7 -exec rm -rf {} \;
	find $cxr_dir/volumes/resource/heatmap/ -name '*.png' -mtime +7 -exec rm -rf {} \;
	find $cxr_dir/volumes/resource/upload/* -mtime +7 -exec rm -rf {} \;
	find $cxr_dir/volumes/static/ai_heatmap/ -name '*.png' -mtime +7 -exec rm -rf {} \;
	find $cxr_dir/volumes/static/ai_images/ -name '*.dcm' -mtime +7 -exec rm -rf {} \;
	find $cxr_dir/volumes/resource/histogram/ -name '*' -mtime +7 -exec rm -rf {} \;
fi

# Lung CT Data 삭제
if [ -d $lct_dir ]; then
	echo -e "\n${GREEN}Lung CT Data를 삭제합니다.${NO_COLOR}"
	find $lct_dir/api/volumes/images/uploads/ -name '*' -mtime +30 -exec rm -rf {} \;
	find $lct_dir/core/volumes/inference/ -name '*' -mtime +30 -exec rm -rf {} \;
fi

# DeepBrain Data 삭제
if [ -d $db_dir ]; then
	echo -e "\n${GREEN}DeepBrain Data를 삭제합니다.${NO_COLOR}"
	find $db_dir/api/volumes/static/upload/*  -mtime +7 -exec rm -rf {} \;
	find $db_dir/web/volumes/static/upload/*  -mtime +7 -exec rm -rf {} \;
fi

# BoneAge Data 삭제
if [ -d $ba_dir ]; then
	echo -e "\n${GREEN}BoneAge Data를 삭제합니다.${NO_COLOR}"
	find $ba_dir/docker/volumes/boneage/files/dicom/ -name '*' -mtime +7 -exec rm -rf {} \;
	find $ba_dir/docker/volumes/boneage/files/images/ -name '*' -mtime +7 -exec rm -rf {} \;
	find $ba_dir/docker/volumes/boneage/files/thumbnail/ -name '*' -mtime +7 -exec rm -rf {} \;
	find $ba_dir/docker/volumes/boneage/heatmap/ -name '*' -mtime +7 -exec rm -rf {} \;
fi

# Fundus AI Data 삭제
if [ -d $fai_dir ]; then
	echo -e "\n${GREEN}Fundus AI Data를 삭제합니다.${NO_COLOR}"
	find $fai_dir/static_volume/api/static/images/* -mtime +7 -exec rm -rf {} \;
            find $fai_dir/static_volume/ai/image/ -name '*.dcm' -mtime +7 -exec rm -rf {} \;
fi

# delete.sh log 삭제
if [ -d "/home/vuno/init/log" ]; then
	find /home/vuno/init/log/* -mtime +30 -exec rm -rf {} \;
fi
