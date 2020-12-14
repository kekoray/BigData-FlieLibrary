#!/usr/bin/env bash

#########################################################
# Description :渠道转化统计周维度统计,自然周，每周跑一次
# Script   :channel_change_data_week.sh
# Version  :1.0
# Date     :2020-11-10
# Author   :koray
# Company  :menglar
#########################################################


################  函数脚本的引进  #################

source ./function_shopee.sh

#################################################

if [ $# -lt 1 ];then
 DT=$(date +%Y-%m-%d -d -0day)
else
 DT=$1
fi


date=`date -d "-0 day $DT" +%Y-%m-%d`
timest=`date -d "-1 day $date" +%Y%m%d`
nowdate=$date



#----------------------计算周-----------------------------

OFDAY=`date -d "$nowdate" +%u`
STEPOFDAY="`expr $OFDAY + 6`"
pre_week_start="`date -d '-'$STEPOFDAY' day '$nowdate'' "+%Y-%m-%d"`"
pre_week_end="`date -d '-'$OFDAY' day '$nowdate'' "+%Y-%m-%d"`"

bef_pre_week_start="`date -d '-7 day '$pre_week_start'' "+%Y-%m-%d"`"
bef_pre_week_end="`date -d '-7 day '$pre_week_end'' "+%Y-%m-%d"`"

echo '当前时间：' $nowdate
echo '上一周开始：' $pre_week_start 
echo '上一周结束：' $pre_week_end 
echo '上上周开始：' $bef_pre_week_start 
echo '上上周结束：' $bef_pre_week_end



#获取去年同周
source ./year_same_week_date.sh $pre_week_start




echo '上一周+1开始：' $pre_week_start 
echo '上一周+1结束：' $pre_week_end 
echo '上上周+1开始：' $bef_pre_week_start 
echo '上上周+1结束：' $bef_pre_week_end
echo '去年同周+1开始：' $monday
echo '去年同周+1结束：' $sunday

timest=${timest:0:4}-${timest:4:2}

######上周转化人数为上周购买的人数，上上周转化人数为上上周购买的人

sql="delete from channel_change_data_week where date='${timest}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


hql="
select
null as id
,channel_id
,product_id
,nvl(count(distinct case when dt>='${pre_week_start}' and dt<='${pre_week_end}' then uid end),0) as change_num
,nvl(count(distinct case when dt>='${bef_pre_week_start}' and dt<='${bef_pre_week_end}' then uid end),0) as past_change_num
,nvl(sum(case when dt>='${pre_week_start}' and dt<='${pre_week_end}' then amount end),0) as gmv
,nvl(sum(case when dt>='${bef_pre_week_start}' and dt<='${bef_pre_week_end}' then amount end),0) as past_gmv
,nvl(count(distinct case when dt>='${pre_week_start}' and dt<='${pre_week_end}' and turn_type='1' then uid end),0) as artificial_change
,nvl(count(distinct case when dt>='${pre_week_start}' and dt<='${pre_week_end}' and turn_type='0' then uid end),0) as natural_change
,nvl(sum(case when dt>='${pre_week_start}' and dt<='${pre_week_end}' and cast(pay_times as int)<=1 then amount end),0) as first_buy_gmv
,nvl(sum(case when dt>='${pre_week_start}' and dt<='${pre_week_end}' and cast(pay_times as int)>1 then amount end),0) as repetition_buy_gmv
,nvl(sum(case when dt>='${pre_week_start}' and dt<='${pre_week_end}' and turn_type='1' then amount end),0) as artificial_change_gmv
,nvl(sum(case when dt>='${pre_week_start}' and dt<='${pre_week_end}' and turn_type='0' then amount end),0) as natural_change_gmv
,'${timest}'
from
(
select
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
dt>='${bef_pre_week_start}'
and
dt<='${pre_week_end}'
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
,pay_times
,app_id
,channel_id
,dt
) as t1
group by
channel_id
,product_id
"

#ExportToMySQLByHQL "$hql" "${date}" "channel_change_data_week" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${date}" "channel_change_data_week" 

