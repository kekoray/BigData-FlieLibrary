#!/usr/bin/env bash

#########################################################
# Description :复购月维度统计,自然月，每个月跑一次
# Script   :repurchase_analysis_data_month.sh
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
curdate=$DT

date=`date -d "-0 day $DT" +%Y-%m-%d`
#timest=`date -d "-0 day $date" +%Y%m`

echo '当前日期：' $DT


#计算上月 上上月 起止日期
dates=`date -d "+0 day $DT" +%Y-%m-01`


pre_mon_sdate=`date -d"$dates last month" +%Y-%m-%d` #上个月第一天
pre_mon_edate=`date -d"$dates last day" +%Y-%m-%d` #上个月最后一天

bef_pre_mon_edate=`date -d "$dates last month last day" +%Y-%m-%d` #上上个月最后一天
bef_pre_mon_sdate=`date -d "+0 day $bef_pre_mon_edate" +%Y-%m-01`  #上上个月第一天
echo '上月开始：' $pre_mon_sdate '上月结束：' $pre_mon_edate  
echo  '上上月开始：' $bef_pre_mon_sdate   '上上月结束：'  $bef_pre_mon_edate

#上一年同期月份
lastYearEnd=`date -d "1 year ago ${pre_mon_edate}" "+%Y-%m-%d"`
lastYearStart=`date -d "1 year ago ${pre_mon_sdate}" "+%Y-%m-%d"`

timest=`date -d "-0 day $pre_mon_sdate" +%Y-%m`




sql="delete from repurchase_analysis_data_month where date='${timest}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"

hql="
select
null
,t2.role_id
,t2.product_id
,nvl(count(distinct case when t1.dt>='${pre_mon_sdate}' and t1.dt<='${pre_mon_edate}' then t1.uid end),0) as repurchase_num
,nvl(count(distinct case when t1.dt>='${bef_pre_mon_sdate}' and t1.dt<='${bef_pre_mon_edate}' then t1.uid end),0) as past_repurchase_num
,nvl(sum(case when t1.dt>='${pre_mon_sdate}' and t1.dt<='${pre_mon_edate}' then t1.amount end),0) as gmv 
,nvl(sum(case when t1.dt>='${bef_pre_mon_sdate}' and t1.dt<='${bef_pre_mon_edate}' then t1.amount end),0) as past_gmv 
,nvl(count(distinct case when t1.dt>='${pre_mon_sdate}' and t1.dt<='${pre_mon_edate}' and t1.turn_type='1' then t1.uid end),0) as artificial_change
,nvl(count(distinct case when t1.dt>='${pre_mon_sdate}' and t1.dt<='${pre_mon_edate}' and t1.turn_type='0' then t1.uid end),0) as artificial_change
,'${timest}'
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
dt>='${bef_pre_mon_sdate}'
and
dt<='${pre_mon_edate}'
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
t2.dt='${pre_mon_edate}'
group by
t2.role_id
,t1.app_id
,t2.product_id
"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "repurchase_analysis_data_month" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "repurchase_analysis_data_month" 

