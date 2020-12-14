#!/usr/bin/env bash

#########################################################
# Description :复购统计天维度统计
# Script   :repurchase_analysis_data_day.sh
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

for ((i= 1;i<=30;i++))
do
DT[$i]=$(date -d "${DT} -$i days" "+%Y-%m-%d")
done

sql="delete from repurchase_analysis_data_day where date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"

hql="
select
null
,t2.role_id
,t2.product_id
,nvl(count(distinct case when t1.dt='${DT[0]}' then t1.uid end),0) as repurchase_num
,nvl(count(distinct case when t1.dt='${DT[1]}' then t1.uid end),0) as past_repurchase_num
,nvl(sum(case when t1.dt='${DT[0]}' then t1.amount end),0) as gmv 
,nvl(sum(case when t1.dt='${DT[1]}' then t1.amount end),0) as past_gmv 
,nvl(count(distinct case when t1.dt='${DT[0]}' and t1.turn_type='1' then t1.uid end),0) as artificial_change
,nvl(count(distinct case when t1.dt='${DT[0]}' and t1.turn_type='0' then t1.uid end),0) as artificial_change
,'${DT[0]}'
from
(
select
member_type
,product_type
,uid
,app_id
,amount
,turn_type
,dt
from
login_buy_detail
where
dt>='${DT[1]}'
and
dt<='${DT[0]}'
and
event='pay'
and
cast(pay_times as int)>1
and
cast(amount as int)>100
group by
member_type
,product_type
,uid
,app_id
,amount
,turn_type
,dt
) as t1
join
sys_product_type as t2
on
t1.member_type=t2.sys_role_id
and
case when t1.product_type is null then 'NULL' else t1.product_type end =t2.sys_product_id
and
t2.dt='${DT[0]}'
group by
t2.role_id
,t1.app_id
,t2.product_id
"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "repurchase_analysis_data_day" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "repurchase_analysis_data_day" 





