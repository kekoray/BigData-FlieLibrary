#!/usr/bin/env bash

#==============================================================
#   Description :  从ods层中TEL处理过后的tmp_etl_ods_item
#   FileName :  tmp_etl_ods_item.sh
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
alter table tmp_etl_ods_item drop if exists PARTITION(dt='${DT[0]}');
insert overwrite table tmp_etl_ods_item PARTITION(dt='${DT[0]}')
select
item_id,
item_name,
shop_id,
shop_name,
site_id,
cat_id,
brand_id,
sku_id,
case when  original_price !='' and original_price !='NULL' and original_price is not null  then  original_price else sale_price end as original_price,
case when  sale_price !='' and sale_price !='NULL' and sale_price is not null  then  sale_price else 0 end as sale_price,
case when  discount !='' and discount !='NULL' and discount is not null  then  discount else '0%' end as discount,
case when  review_count !='' and review_count !='NULL' and review_count is not null  then  review_count else 0 end as review_count,
case when  item_score !='' and item_score !='NULL' and item_score is not null  then  item_score else 0 end as item_score,
location as shop_address,
inventory as is_inventory,
create_time
from
(
select
item_id,
item_name,
shop_id,
shop_name,
site_id,
cat_id,
brand_id,
sku_id,
original_price,
sale_price,
discount,
review_count,
item_score,
location,
inventory,
create_time,
row_number() over (partition by site_id,item_id order by create_time asc) num
from
ods_cos_item
where
dt='${DT[0]}'
and (item_id REGEXP '[^0-9.]')=0
and item_name is not null
and item_name !='NULL'
and item_name !=''
and cat_id > 0
) as t
where t.num=1;
"


#执行hql
ExecuteHQL "${hql}"


echo "          " 
echo "========== [ tmp_etl_ods_item ] Completed Loading ... =========="
echo "          " 






