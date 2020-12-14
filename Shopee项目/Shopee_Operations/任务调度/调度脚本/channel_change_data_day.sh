#!/usr/bin/env bash

#########################################################
# Description :渠道转化统计天维度统计
# Script   :channel_change_data_day.sh
# Version  :1.0
# Date     :2020-11-10
# Author   :koray
# Company  :menglar
#########################################################


HIVE_PATH=/usr/local/service/hive/bin/hive
HADOOP_PATH=/usr/local/service/hadoop/bin/hadoop


################  函数脚本的引进  #################

source ./function_shopee.sh

################################################# 




if [ $# -lt 1 ];then
 DT=$(date +%Y-%m-%d -d -0day)
else
 DT=$1
fi

DT=`date -d "-1 day $DT" +%Y-%m-%d`

for ((i= 1;i<=60;i++))
do
DT[$i]=$(date -d "${DT} -$i days" "+%Y-%m-%d")
done



######当天转化人为当天购买的人数。
#这里把结果存到中间表因为channel_change_details统计要用到

hql="
use shopee_operations;
insert overwrite table bs_channel_change_data_day partition(dt='${DT[0]}')
select
channel_id
,product_id
,count(distinct case when dt='${DT[0]}' then uid end) as change_num
,count(distinct case when dt='${DT[1]}' then uid end) as past_change_num
,sum(case when dt='${DT[0]}' then amount end) as gmv
,sum(case when dt='${DT[1]}' then amount end) as past_gmv
,count(distinct case when dt='${DT[0]}' and turn_type='1' then uid end) as artificial_change
,count(distinct case when dt='${DT[0]}' and turn_type='0' then uid end) as natural_change
,sum(case when dt='${DT[0]}' and cast(pay_times as int)<=1 then amount end) as first_buy_gmv
,sum(case when dt='${DT[0]}' and cast(pay_times as int)>1 then amount end) as repetition_buy_gmv
,sum(case when dt='${DT[0]}' and turn_type='1' then amount end) as artificial_change_gmv
,sum(case when dt='${DT[0]}' and turn_type='0' then amount end) as natural_change_gmv
from
(select
uid
,app_id
,channel_id
,member_type
,amount
,turn_type
,product_id
,pay_times
,dt
from
login_buy_real
where
dt>='${DT[1]}'
and
dt<='${DT[0]}'
and
event='pay'
and
cast(amount as int)>100
group by
uid
,member_type
,amount
,turn_type
,product_id
,app_id
,channel_id
,pay_times
,dt
) as t1
group by
channel_id
,product_id
"

ExecuteHQL "${hql}"  

sql="delete from channel_change_data_day where date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


#####入库
hql="
select
null as id
,channel_id
,product_id
,nvl(change_num,0)
,nvl(past_change_num,0)
,nvl(gmv,0)
,nvl(past_gmv,0)
,nvl(artificial_change,0)
,nvl(natural_change,0)
,nvl(first_buy_gmv,0)
,nvl(repetition_buy_gmv,0)
,nvl(artificial_change_gmv,0)
,nvl(natural_change_gmv,0)
,'${DT[0]}'
from
bs_channel_change_data_day
where
dt='${DT[0]}'
"


#ExportToMySQLByHQL "$hql" "${DT[0]}" "channel_change_data_day" "shopee_operations" 
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1      sql=$2    dir_dt=$3      mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "channel_change_data_day" 


