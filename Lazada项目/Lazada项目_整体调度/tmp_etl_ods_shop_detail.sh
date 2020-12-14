#!/usr/bin/env bash

#==============================================================
#   Description :  从ods层中TEL处理过后的tmp_etl_ods_shop_detail
#   FileName :  tmp_etl_ods_shop_detail.sh
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
alter table tmp_etl_ods_shop_detail drop if exists PARTITION(dt='${DT[0]}');
insert overwrite table tmp_etl_ods_shop_detail PARTITION(dt='${DT[0]}')
select
shop_id,
site_id,
shop_name,
case when item_count !='' and item_count !='NULL' and item_count is not null  then  item_count else 0 end as item_count,
case when review_count !='' and review_count !='NULL' and review_count is not null  then  review_count else 0 end as review_count,
case when negate_num !='' and negate_num !='NULL' and negate_num is not null  then  negate_num else 0 end as negate_num,
case when average_num !='' and average_num !='NULL' and average_num is not null  then  average_num else 0 end as average_num,
case when praise_num !='' and praise_num !='NULL' and praise_num is not null  then  praise_num else 0 end as praise_num,
create_time
from
(
select
shop_id,
site_id,
shop_name,
item_count,
review_count,
negate_num,
average_num,
praise_num,
create_time,
row_number() over (partition by site_id,shop_id order by create_time asc) num
from
ods_cos_shop_detail
where
dt='${DT[0]}'
and (shop_id REGEXP '[^0-9.]')=0
and shop_name is not null
and shop_name !='NULL'
and shop_name !=''
) as t
where t.num=1;
"


#执行hql
ExecuteHQL "${hql}"


echo "          " 
echo "========== [ tmp_etl_ods_shop_detail ] Completed Loading ... =========="
echo "          " 






