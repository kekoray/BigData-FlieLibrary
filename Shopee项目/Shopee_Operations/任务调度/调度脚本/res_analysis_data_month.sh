#!/usr/bin/env bash

#########################################################
# Description :注册分析月维度统计
# Script   :res_analysis_data_month.sh
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



sql="delete from res_analysis_data_month where date='${timest}'"

echo '-----------删除语句是---------------'
echo ${sql}

ExecuteMysql "$sql"



hql="
select
null as id
,type4_id as channel_id
,nvl(count(distinct case when dt>='${pre_mon_sdate}' and dt<='${pre_mon_edate}' then uid end),0) as res_num
,nvl(count(distinct case when dt>='${bef_pre_mon_sdate}' and dt<='${bef_pre_mon_edate}' then uid end),0) as past_res_num
,'${timest}'
from
(
select
t1.uid
,t2.type4_id
,t1.event
,t1.dt
from
login_buy_detail as t1
join
sys_all_level_category as t2
on
t1.app_id=t2.type2_code
and
t1.channel_id=t2.type4_code
and
t2.dt='${pre_mon_edate}'
where
t1.dt>='${bef_pre_mon_sdate}'
and
t1.dt<='${pre_mon_edate}'
) as t1
where
event='register'
group by
type4_id
"

#ExportToMySQLByHQL "$hql" "${pre_mon_edate}" "res_analysis_data_month" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${pre_mon_edate}" "res_analysis_data_month"

