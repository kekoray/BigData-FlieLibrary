#!/usr/bin/env bash

#==============================================================
#   Description :  从ods层中TEL处理过后的dwd_sku_pattern
#   FileName :  dwd_sku_pattern.sh
#   Version  :  1.0
#   Author   :  Koray
#   Date     :  2020-12-01
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
alter table dwd_sku_pattern drop if exists PARTITION(dt='${DT[0]}');
insert overwrite table dwd_sku_pattern PARTITION(dt='${DT[0]}')
select
item_id,
site_id,
sku_id,
sku_key_id,
sku_key_name,
sku_value_id,
sku_value_name,
create_time
from
(
select
item_id,
site_id,
sku_id,
sku_key_id,
sku_key_name,
sku_value_id,
sku_value_name,
create_time,
row_number() over(partition by site_id,item_id,sku_id,sku_key_id order by create_time asc) num
from
ods_sku_pattern
where
dt='${DT[0]}'
and (item_id REGEXP '[^0-9.]')=0
and item_id is not null
and item_id !='NULL'
and item_id !=''
) as t
where t.num=1;
"


#执行hql
ExecuteHQL "${hql}"


echo "          " 
echo "========== [ dwd_sku_pattern ] Completed Loading ... =========="
echo "          " 






