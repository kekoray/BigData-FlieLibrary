#!/usr/bin/env bash

#########################################################
# Description :近期复购统计
# Script   :repurchase_total.sh
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

sql="delete from repurchase_total where date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


hql="
select
null as id
,app_id
,bef_over_time
,nvl(count(distinct case when pay_date<=date_add(bef_over_time,6) and pay_date>=bef_over_time then uid end),0) as seven_day_num
,nvl(count(distinct case when pay_date<=date_add(bef_over_time,13) and pay_date>=bef_over_time then uid end),0) as fourteen_day_num
,nvl(count(distinct case when pay_date<=date_add(bef_over_time,29) and pay_date>=bef_over_time then uid end),0) as thirty_day_num
,'${DT[0]}'
from
(
select
t1.app_id
,t1.uid
,t1.bef_over_time
,t2.dt as pay_date
from
(
select
app_id
,uid
,bef_over_time
from
login_buy_overtime_change
where
dt>='${DT[29]}'
and
dt<='${DT[0]}'
and
bef_over_time>='${DT[29]}'
and
bef_over_time<='${DT[0]}'
group by
app_id
,uid
,bef_over_time
) as t1
join
(select
app_id
,uid
,dt
from
login_buy_detail
where
dt>='${DT[29]}'
and
dt<='${DT[0]}'
and
event='pay'
and
cast(pay_times as int)>1
and
cast(amount as int)>100
group by
app_id
,uid
,dt
) as t2
on
t1.app_id=t2.app_id
and
t1.uid=t2.uid
) as t3
group by
app_id
,bef_over_time
"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "repurchase_total" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "repurchase_total" 

