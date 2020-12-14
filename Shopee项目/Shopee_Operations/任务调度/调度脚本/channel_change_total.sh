#!/usr/bin/env bash

#########################################################
# Description :channel_change_total的统计
# Script   :channel_change_total.sh
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


sql="delete from channel_change_total where date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


#######该统计是统计近三十天每一天注册日期近七天、14天、30天的转化人数，首先获取近三十天每一天注册的用户，关联上近三十天每一天的购买人数，获取近三十天类用户的注册日期和购买日期，在通过注册日期和购买日期比较，算出七天、14天、30天的转化人数,然后分组
hql="
select
null as id
,t4.type4_id as channel_id
,t3.reg_date
,nvl(count(distinct case when t3.pay_date<=date_add(t3.reg_date,6) then uid end),0) as seven_day_num
,nvl(count(distinct case when t3.pay_date<=date_add(t3.reg_date,13) then uid end),0) as fourteen_day_num
,nvl(count(distinct case when t3.pay_date<=date_add(t3.reg_date,29) then uid end),0) as thirty_day_num
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
,t1.dt as reg_date
,t2.dt as pay_date
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
dt>='${DT[29]}'
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
,member_type
,amount
,app_id
,channel_id
,turn_type
,product_type
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
cast(amount as int)>100
group by
uid
,member_type
,amount
,turn_type
,product_type
,app_id
,channel_id
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
,t3.reg_date
"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "channel_change_total" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "channel_change_total" 


