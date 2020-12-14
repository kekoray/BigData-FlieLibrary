#!/usr/bin/env bash

#==============================================================
#   Description :  从ods层中TEL处理过后的dwd_sku_info
#   FileName :  dwd_sku_info.sh
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
alter table dwd_sku_info drop if exists PARTITION(dt='${DT[0]}');
insert overwrite table lazada_dw.dwd_sku_info PARTITION(dt='${DT[0]}')
select
sku_id,
item_id,
site_id,
cat_id,
brand_id,
shop_id,
case when inventory_count !='' and inventory_count !='NULL' and inventory_count is not null then inventory_count else inventory_count end as inventory_count,
case when  original_price !='' and original_price !='NULL' and original_price is not null  then  original_price else sale_price end as original_price,
case when  sale_price !='' and sale_price !='NULL' and sale_price is not null  then  sale_price else 0 end as sale_price,
case when  discount !='' and discount !='NULL' and discount is not null  then  discount else '0%' end as discount,
case when  carriage !='' and carriage !='NULL' and carriage is not null  then  carriage else 0 end as carriage,
create_time
from
(
select
sku_id,
item_id,
site_id,
brand_id,
shop_id,
inventory_count,
original_price,
sale_price,
discount,
carriage,
cat_id,
create_time,
row_number() over(partition by site_id,sku_id order by create_time asc) num
from
lazada_dw.ods_cos_sku
where
dt='${DT[0]}'
and (sku_id REGEXP '[^0-9.]')=0
and sku_id is not null
and sku_id !='NULL'
and sku_id !=''
and sale_price !='NULL'
and sale_price is not null
and sale_price != 0
) as t
where t.num=1;
"


#执行hql
ExecuteHQL "${hql}"


echo "          " 
echo "========== [ dwd_sku_info ] Completed Loading ... =========="
echo "          " 






