#!/usr/bin/env bash

#==============================================================
#   Description :  将ods层的item表和item_detail表合并成dwd_item_info
#   FileName :  dwd_item_info.sh
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
alter table dwd_item_info drop if exists PARTITION(dt='${DT[0]}');
insert overwrite table dwd_item_info PARTITION(dt='${DT[0]}')
select
t1.item_id,
t1.item_name,
t1.shop_id,
t1.shop_name,
t1.site_id,
t1.cat_id,
t1.brand_id,
t1.sku_id,
t1.original_price,
t1.sale_price,
t1.discount,
t1.review_count,
t2.textReview_count,
t2.sku_count,
t2.carriage,
t2.item_score,
t1.shop_address,
t2.one_star,
t2.two_star,
t2.three_star,
t2.four_star,
t2.five_star,
t2.cat_1d_name,
t2.cat_2d_name,
t2.cat_3d_name,
t2.cat_4d_name,
t2.cat_5d_name,
t2.cat_6d_name,
t2.cat_set,
t1.is_inventory,
t1.create_time
from
tmp_etl_ods_item t1
join
tmp_etl_ods_item_detail t2
on t1.site_id = t2.site_id
and  t1.item_id = t2.item_id
and t2.dt='${DT[0]}'
where
t1.dt='${DT[0]}';
"



#执行hql
ExecuteHQL "${hql}"


echo "          " 
echo "========== [ dwd_item_info ] Completed Loading ... =========="
echo "          " 