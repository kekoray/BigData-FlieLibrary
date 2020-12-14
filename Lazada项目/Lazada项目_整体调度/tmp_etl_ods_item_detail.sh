#!/usr/bin/env bash

#==============================================================
#   Description :  从ods层中TEL处理过后的tmp_etl_ods_item_detail
#   FileName :  tmp_etl_ods_item_detail.sh
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
alter table tmp_etl_ods_item_detail drop if exists PARTITION(dt='${DT[0]}');
insert overwrite table tmp_etl_ods_item_detail PARTITION(dt='${DT[0]}')
select
item_id,
item_name,
site_id,
cat_1d_name,
cat_2d_name,
cat_3d_name,
cat_4d_name,
cat_5d_name,
cat_6d_name,
cat_set,
case when review_count !='' and review_count !='NULL' and review_count is not null  then  review_count else 0 end as review_count,
case when textReview_count !='' and textReview_count !='NULL' and textReview_count is not null  then  textReview_count else 0 end as textReview_count,
case when carriage !='' and carriage !='NULL' and carriage is not null  then  carriage else 0 end as carriage,
case when item_score !='' and item_score !='NULL' and item_score is not null  then  item_score else 0 end as item_score,
case when one_star !='' and one_star !='NULL' and one_star is not null  then  one_star else 0 end as one_star,
case when two_star !='' and two_star !='NULL' and two_star is not null  then  two_star else 0 end as two_star,
case when three_star !='' and three_star !='NULL' and three_star is not null  then  three_star else 0 end as three_star,
case when four_star !='' and four_star !='NULL' and four_star is not null  then  four_star else 0 end as four_star,
case when five_star !='' and five_star !='NULL' and five_star is not null  then  five_star else 0 end as five_star,
case when sku_count !='' and sku_count !='NULL' and sku_count is not null  then  sku_count else 0 end as sku_count,
create_time
from
(
select
item_id,
item_name,
site_id,
cat_1d_name,
cat_2d_name,
cat_3d_name,
cat_4d_name,
cat_5d_name,
cat_6d_name,
cat_set,
review_count,
textReview_count,
carriage,
item_score,
one_star,
two_star,
three_star,
four_star,
five_star,
sku_count,
create_time,
row_number() over (partition by site_id,item_id order by create_time asc) num
from
ods_cos_item_detail
where
dt='${DT[0]}'
and (item_id REGEXP '[^0-9.]')=0
and item_name is not null
and item_name !='NULL'
and item_name !=''
) as t
where t.num=1;
"


#执行hql
ExecuteHQL "${hql}"


echo "          " 
echo "========== [ tmp_etl_ods_item_detail ] Completed Loading ... =========="
echo "          " 






