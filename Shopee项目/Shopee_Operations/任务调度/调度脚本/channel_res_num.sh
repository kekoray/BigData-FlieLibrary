#!/usr/bin/env bash

#########################################################
# Description :渠道转化计算，没有套餐id,按渠道统计
# Script   :channel_res_num.sh
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

sql="delete from channel_res_num where date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


#######获取今天的注册用户，关联获得真正的channel_id，分组算出今天每个渠道的注册人数
hql="
select
null as id
,type4_id as channel_id
,nvl(count(distinct uid),0) as res_num
,'${DT[0]}'
from
(
select
t1.uid
,t2.type4_id
,t1.event
from
login_buy_detail as t1
join
sys_all_level_category as t2
on
t1.app_id=t2.type2_code
and
t1.channel_id=t2.type4_code
and
t2.dt='${DT[0]}'
where
t1.dt='${DT[0]}'
) as t1
where
event='register'
group by
type4_id
"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "channel_res_num" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "channel_res_num" 






