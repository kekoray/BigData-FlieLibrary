#!/usr/bin/env bash

#########################################################
# Description :过期复购统计
# Script   :repurchase_num.sh
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

sql="delete from repurchase_num where date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"



###############这个统计获取七天过期并且续费的用户分为两种情况，第一种为近七天过期，但是过期时间没变更，第二种为近七天过期，今天过期时间变更

hql="
select
null
,t2.app_id
,t2.over_time
,nvl(count(distinct t2.uid),0)  as repurchase_num
,'${DT[0]}'
from
(select
app_id
,uid
from
login_buy_detail
where
dt='${DT[0]}'
and
event='pay'
and
cast(pay_times as int)>1
and
cast(amount as int)>100
group by 
app_id
,uid
) as t1
join
(select
uid
,app_id
,aft_over_time as over_time
from
login_buy_overtime_change
where
dt='${DT[0]}'
and
aft_over_time>='${DT[6]}'
and
aft_over_time<='${DT[0]}'
group by
uid
,app_id
,aft_over_time
union all
select
uid
,app_id
,bef_over_time as over_time
from
login_buy_overtime_change
where
dt='${DT[0]}'
and
bef_over_time>='${DT[6]}'
and
bef_over_time<='${DT[0]}'
and
change_date='${DT[0]}'
group by
uid
,app_id
,bef_over_time
) as t2
on
t1.uid=t2.uid
and
t1.app_id=t2.app_id
group by 
t2.app_id
,t2.over_time
"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "repurchase_num" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "repurchase_num" 

