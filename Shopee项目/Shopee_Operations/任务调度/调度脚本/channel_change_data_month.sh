#!/usr/bin/env bash

#########################################################
# Description :渠道转化统计月维度统计,自然月，每个月跑一次
# Script   :channel_change_data_month.sh
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




#月开始结束均+1
#source /data/qbteescript/common/month_add.sh $pre_mon_sdate $pre_mon_edate $bef_pre_mon_sdate $bef_pre_mon_edate $lastYearStart $lastYearEnd  

sql="delete from channel_change_data_month where date='${timest}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


######上个月转化人数为上个月购买的人数，上上个月转化人数为上上个月购买的人数
hql="
select
null as id
,channel_id
,product_id
,nvl(count(distinct case when dt>='${pre_mon_sdate}' and dt<='${pre_mon_edate}' then uid end),0) as change_num
,nvl(count(distinct case when dt>='${bef_pre_mon_sdate}' and dt<='${bef_pre_mon_edate}' then uid end),0) as past_change_num
,nvl(sum(case when dt>='${pre_mon_sdate}' and dt<='${pre_mon_edate}' then amount end),0) as gmv
,nvl(sum(case when dt>='${bef_pre_mon_sdate}' and dt<='${bef_pre_mon_edate}' then amount end),0) as past_gmv
,nvl(count(distinct case when dt>='${pre_mon_sdate}' and dt<='${pre_mon_edate}' and turn_type='1' then uid end),0) as artificial_change
,nvl(count(distinct case when dt>='${pre_mon_sdate}' and dt<='${pre_mon_edate}' and turn_type='0' then uid end),0) as natural_change
,nvl(sum(case when dt>='${pre_mon_sdate}' and dt<='${pre_mon_edate}' and cast(pay_times as int)<=1 then amount end),0) as first_buy_gmv
,nvl(sum(case when dt>='${pre_mon_sdate}' and dt<='${pre_mon_edate}' and cast(pay_times as int)>1 then amount end),0) as repetition_buy_gmv
,nvl(sum(case when dt>='${pre_mon_sdate}' and dt<='${pre_mon_edate}' and turn_type='1' then amount end),0) as artificial_change_gmv
,nvl(sum(case when dt>='${pre_mon_sdate}' and dt<='${pre_mon_edate}' and turn_type='0' then amount end),0) as natural_change_gmv
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
dt>='${bef_pre_mon_sdate}'
and
dt<='${pre_mon_edate}'
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
,app_id
,channel_id
,pay_times
,dt
) as t1
group by
channel_id
,product_id
"

#ExportToMySQLByHQL "$hql" "${date}" "channel_change_data_month" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${date}" "channel_change_data_month" 

