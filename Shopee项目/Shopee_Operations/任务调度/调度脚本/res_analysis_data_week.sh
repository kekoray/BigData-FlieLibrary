#!/usr/bin/env bash

#########################################################
# Description :注册分析周维度统计,自然周，每周跑一次
# Script   :res_analysis_data_week.sh
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


#自然周开始和结束均加1天
#source /data/qbteescript/common/week_add.sh $pre_week_start $pre_week_end $bef_pre_week_start $bef_pre_week_end $monday $sunday


echo '上一周+1开始：' $pre_week_start 
echo '上一周+1结束：' $pre_week_end 
echo '上上周+1开始：' $bef_pre_week_start 
echo '上上周+1结束：' $bef_pre_week_end
echo '去年同周+1开始：' $monday
echo '去年同周+1结束：' $sunday

timest=${timest:0:4}-${timest:4:2}

sql="delete from res_analysis_data_week where date='${timest}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"



hql="
select
null as id
,type4_id as channel_id
,nvl(count(distinct case when dt>='${pre_week_start}' and dt<='${pre_week_end}' then uid end),0) as res_num
,nvl(count(distinct case when dt>='${bef_pre_week_start}' and dt<='${bef_pre_week_end}' then uid end),0) as past_res_num
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
t2.dt='${pre_week_end}'
where
t1.dt>='${bef_pre_week_start}'
and
t1.dt<='${pre_week_end}'
) as t1
where
event='register'
group by
type4_id
"

#ExportToMySQLByHQL "$hql" "${pre_week_end}" "res_analysis_data_week" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${pre_week_end}" "res_analysis_data_week" 

