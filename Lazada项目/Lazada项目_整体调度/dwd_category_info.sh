#!/usr/bin/env bash

#==============================================================
#   Description :  从ods层中TEL处理过后的dwd_category_info
#   FileName :  dwd_category_info.sh
#   Version  :  1.1
#   Author   :  Koray
#   Date     :  2020-11-25
#   Company  :  menglar
#==============================================================



#=================  函数的加载  ================================

source ./function_lazada.sh

#==============================================================



#一级分区的日期,格式:yyyy-MM-dd
if [ $# -lt 1 ];then
    #不传参
    date=$(date -d -0day +%Y-%m-%d)
else
    #传参
    DT=$1
    date=`date -d "-0 day ${DT}" +%Y-%m-%d`
fi

echo " 一级分区的日期: [ $date ] "
echo "          "

DT=`date -d "-0 day $date" +%Y-%m-%d`

#日期选择
for ((i= 1;i<=60;i++))
do
DT[$i]=$(date -d "${DT} -$i days" "+%Y-%m-%d")
done


echo " 分区字段为: [ ${DT[0]} ] " 
echo "          "



#====================  数据加载  ====================


#hive表数据加载
hql="use lazada_dw;
set io.sort.mb=10;
set io.sort.factor=100;
alter table dwd_category_info drop if exists PARTITION(dt='${DT[0]}');
insert overwrite table dwd_category_info PARTITION(dt='${DT[0]}')
select
cat_id,
site_id,
cat_1d_id,
cat_2d_id,
cat_3d_id,
cat_4d_id,
cat_5d_id,
cat_6d_id,
cat_name,
cat_name_cn,
cat_name_en,
parent_id,
cat_level,
create_time,
modified_time
from
(
select
cat_id,
site_id,
cat_1d_id,
cat_2d_id,
cat_3d_id,
cat_4d_id,
cat_5d_id,
cat_6d_id,
cat_name,
cat_name_cn,
cat_name_en,
parent_id,
cat_level,
create_time,
modified_time,
row_number() over(partition by site_id,cat_id order by create_time asc) num
from
ods_mysql_category
where
dt='${DT[0]}'
and (cat_id REGEXP '[^0-9.]') = 0
and cat_name is not null
and cat_name !='NULL'
and cat_name !=''
) as t
where t.num=1;
"


#执行hql
ExecuteHQL "${hql}"


echo "          " 
echo "========== [ dwd_category_info ] Completed Loading ... =========="
echo "          " 






