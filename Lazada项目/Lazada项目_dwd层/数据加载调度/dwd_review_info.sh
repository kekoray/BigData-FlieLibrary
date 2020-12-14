#!/usr/bin/env bash

#==============================================================
#   Description :  从ods层中TEL处理过后的dwd_review_info
#   FileName :  dwd_review_info.sh
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
alter table lazada_dw.dwd_review_info drop if exists PARTITION(dt='${DT[0]}');
insert overwrite table lazada_dw.dwd_review_info PARTITION(dt='${DT[0]}')
select
review_id,
sku_id,
item_id,
site_id,
shop_id,
case when  star !='NULL' and star !='NULL' and star is not null  then  star else 0 end as star,
case when  like_count !='NULL' and like_count !='NULL' and like_count is not null  then  like_count else 0 end as like_count,
sku_info,
create_time
from
(
select
review_id,
sku_id,
item_id,
site_id,
shop_id,
star,
like_count,
sku_info,
create_time,
row_number() over(partition by site_id,review_id order by create_time asc) num
from
lazada_dw.ods_cos_review
where
dt='${DT[0]}'
and (review_id REGEXP '[^0-9.]') = 0
and review_id is not null
and review_id !='NULL'
and review_id !=''
) as t
where t.num=1;
"


#执行hql
ExecuteHQL "${hql}"


echo "          " 
echo "========== [ dwd_review_info ] Completed Loading ... =========="
echo "          " 






