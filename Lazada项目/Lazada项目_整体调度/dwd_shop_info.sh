#!/usr/bin/env bash

#==============================================================
#   Description :  将ods层的shop表和shop_detail表合并成dwd_shop_info
#   FileName :  dwd_shop_info.sh
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
set hive.auto.convert.join=false;  
set hive.ignore.mapjoin.hint=false; 
alter table dwd_shop_info drop if exists PARTITION(dt='${DT[0]}');
insert overwrite table dwd_shop_info PARTITION(dt='${DT[0]}')
select
t1.shop_id,
t1.site_id,
t1.shop_name,
t1.cat_1d_name,
t1.sales_cat,
t1.follower_num,
t1.shop_type,
t1.praise_rate,
t2.item_count,
t2.review_count,
t2.negate_num,
t2.average_num,
t2.praise_num,
t1.cancel_rate,
t1.onTimeDelivery_rate,
t1.chatResp_rate,
t1.onTimeDelivery_AddRate,
t1.rate_level,
t1.create_time
from
tmp_etl_ods_shop t1
join
tmp_etl_ods_shop_detail t2
on t1.site_id = t2.site_id
and t1.shop_id = t2.shop_id
and t2.dt='${DT[0]}'
where
t1.dt='${DT[0]}'

"



#执行hql
ExecuteHQL "${hql}"


echo "          " 
echo "========== [ dwd_shop_info ] Completed Loading ... =========="
echo "          " 