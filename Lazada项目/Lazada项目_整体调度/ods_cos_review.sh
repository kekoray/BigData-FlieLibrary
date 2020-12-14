#!/usr/bin/env bash

#==============================================================
#   Description :  从cos中映射ods_cos_review
#   FileName :  ods_cos_review.sh
#   Version  :  1.0
#   Author   :  Koray
#   Date     :  2020-11-23
#   Company  :  menglar
#==============================================================



#=================  函数的加载  ================================

source ./function_lazada.sh

#==============================================================



#cos存储地址,末尾带"/"
COSN_ODS_COS_REVIEW_PATH=cosn://spider-log-1254463213/lzd_reviews_csv/


#一级分区的日期,格式:yyyy-MM-dd
if [ $# -lt 1 ];then  
    #不传参
    date=$(date -d -0day +%Y-%m-%d)   
else
    #传参
    DT=$1    
    date=`date -d "-0 day $DT" +%Y-%m-%d`
fi

echo " 一级分区的日期: [ $date ] "
echo "          "


#二级分区的小时
arr=(00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23)
echo " 二级分区的时间段如下：[ ${arr[@]} ] " 
echo "          "



#====================  数据映射  ====================

for var in ${arr[@]}
do

#分区字段
echo " 分区字段为: [ ${date} - ${var} ] " 
echo "          " 


#映射文件的路径                                             
ODS_COS_REVIEW_PATH=${COSN_ODS_COS_REVIEW_PATH}${date}/${var}/             
echo " 映射文件的路径: [ ${ODS_COS_REVIEW_PATH} ] " 
echo "          "   


#hive表数据加载
hql="use lazada_dw;
alter table ods_cos_review drop if exists partition(dt='${date}',hr='${var}');
alter table ods_cos_review add if not exists partition(dt='${date}',hr='${var}')
location '${ODS_COS_REVIEW_PATH}';"


#执行hql
ExecuteHQL "${hql}"

done


echo "          " 
echo "========== [ ods_cos_review ] Completed Loading ... =========="
echo "          " 
