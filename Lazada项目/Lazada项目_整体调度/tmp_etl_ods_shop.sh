#!/usr/bin/env bash

#==============================================================
#   Description :  从ods层中TEL处理过后的tmp_etl_ods_shop
#   FileName :  tmp_etl_ods_shop.sh
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
alter table tmp_etl_ods_shop drop if exists PARTITION(dt='${DT[0]}');
insert overwrite table tmp_etl_ods_shop PARTITION(dt='${DT[0]}')
select
shop_id,
site_id,
shop_name,
cat_1d_name,
sales_cat,
case when  follower_num !='' and follower_num !='NULL' and follower_num is not null  then  follower_num else 0 end as follower_num,
case when shop_type = 'certified' or shop_type = 'official' then  2
when shop_type = 'seller' then 1
when shop_type = 'tbc' then 3
else -1 end
as shop_type ,
case when praise_rate !='' and praise_rate !='NULL' and praise_rate is not null  then  praise_rate else '0%' end as praise_rate,
case when cancel_rate !='' and cancel_rate !='NULL' and cancel_rate is not null  then  cancel_rate*100 else 0 end as cancel_rate,
case when onTimeDelivery_rate !='' and onTimeDelivery_rate !='NULL' and onTimeDelivery_rate is not null  then  onTimeDelivery_rate*100 else 0 end as onTimeDelivery_rate,
case when chatResp_rate !='' and chatResp_rate !='NULL' and chatResp_rate is not null  then  chatResp_rate else '0%' end as chatResp_rate,
case when onTimeDelivery_AddRate !='' and onTimeDelivery_AddRate !='NULL' and onTimeDelivery_AddRate is not null  then  onTimeDelivery_AddRate*100 else 0 end as onTimeDelivery_AddRate,
case when rate_level !='' and rate_level !='NULL' and rate_level is not null  then  rate_level else 0 end as rate_level,
create_time
from
(
select
shop_id,
site_id,
shop_name,
cat_1d_name,
sales_cat,
follower_num,
shop_type,
praise_rate,
cancel_rate,
onTimeDelivery_rate,
chatResp_rate,
onTimeDelivery_AddRate,
rate_level,
create_time,
row_number() over (partition by site_id,shop_id order by create_time asc) num
from
ods_cos_shop
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
echo "========== [ tmp_etl_ods_shop ] Completed Loading ... =========="
echo "          " 






