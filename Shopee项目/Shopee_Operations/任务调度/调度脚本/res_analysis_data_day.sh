#!/usr/bin/env bash

#########################################################
# Description :注册人数统计天维度
# Script   :res_analysis_data_day.sh
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

sql="delete from res_analysis_data_day where date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


#######获取今天昨天的注册用户，关联获得真正的channel_id，分组算出今天每个渠道的注册人数
hql="
use shopee_operations;
insert overwrite table bs_res_analysis_data_day partition(dt='${DT[0]}')
select
type4_id as channel_id
,nvl(count(distinct case when dt='${DT[0]}' then uid end),0) as res_num
,nvl(count(distinct case when dt='${DT[1]}' then uid end),0) as past_res_num
from
(
select
t1.uid
,t2.type4_id
,t1.dt
from
(
select
uid
,app_id
,channel_id
,dt
from
login_buy_detail
where
dt>='${DT[1]}'
and
dt<='${DT[0]}'
and
event='register'
group by 
uid
,app_id
,channel_id
,dt
)as t1
join
sys_all_level_category as t2
on
t1.app_id=t2.type2_code
and
t1.channel_id=t2.type4_code
and
t2.dt='${DT[0]}'
) as t1
group by
type4_id
"
ExecuteHQL "${hql}"



hql="
select
null as id
,channel_id
,res_num
,past_res_num
,'${DT[0]}'
from
bs_res_analysis_data_day
where
dt='${DT[0]}'
"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "res_analysis_data_day" "shopee_operations"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "res_analysis_data_day" 

