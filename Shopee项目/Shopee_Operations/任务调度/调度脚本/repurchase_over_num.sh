#!/usr/bin/env bash

#########################################################
# Description :过期复购统计
# Script   :repurchase_over_num.sh
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

sql="delete from repurchase_over_num where date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"

########过期时间分为两种情况,一种是今天过期并且今天过期时间没有变更的,第二种是今天过期，但是过期时间变更的
hql="
select
null
,app_id
,nvl(count(distinct uid),0) as over_num
,'${DT[0]}'
from
(
select
app_id
,uid
from
login_buy_overtime_change
where
dt='${DT[0]}'
and
aft_over_time='${DT[0]}'
union all
select
app_id
,uid
from
login_buy_overtime_change
where
dt='${DT[0]}'
and
bef_over_time='${DT[0]}'
and
change_date='${DT[0]}'
) as t
group by
app_id
"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "repurchase_over_num" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "repurchase_over_num" 

