#!/usr/bin/env bash

#########################################################
# Description :channel_change_num统计
# Script   :channel_change_num.sh
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


sql="delete from channel_change_num where date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"



#######该统计只有渠道ID没有套餐ID,该统计是统计近七天注册的用户在今天购买的人数，也就是每个渠道ID有七天数据，首先获取近七天的注册用户id和注册日期，再关联今天的购买用户,获得近七天每一天注册并且在今天购买的用户，再通过关联sys_all_level_category获取真实的channel_id,再分组计算。

hql="
select
null as id
,t3.dt
,t4.type4_id
,nvl(count(distinct uid),0) as change_num
,'${DT[0]}'
from
(
select
t1.uid
,t1.app_id
,t1.channel_id
,t1.reg_time
,t2.amount
,t2.turn_type
,t2.product_type
,t2.member_type
,t1.dt
from
(
select
uid
,app_id
,channel_id
,reg_time
,dt
from
login_buy_detail
where
dt>='${DT[6]}'
and
dt<='${DT[0]}'
and
event='register'
group by
uid
,app_id
,channel_id
,reg_time
,dt
)as t1
join
(
select
uid
,app_id
,channel_id
,member_type
,amount
,turn_type
,product_type
,dt
from
login_buy_detail
where
dt='${DT[0]}'
and
event='pay'
and
cast(amount as int)>100
group by
uid
,member_type
,amount
,turn_type
,app_id
,channel_id
,product_type
,dt
) as t2
on
t1.uid=t2.uid
and
t1.app_id=t2.app_id
and
t1.channel_id=t2.channel_id
) as t3
join
sys_all_level_category as t4
on
t3.app_id=t4.type2_code
and
t3.channel_id=t4.type4_code
and
t4.dt='${DT[0]}'
group by
t4.type4_id
,t3.dt
"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "channel_change_num" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "channel_change_num" 


