#!/usr/bin/env bash

#########################################################
# Description :res_analysis_cumulative的统计
# Script   :res_analysis_cumulative.sh
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



##插入两者都有的,能关联上的，对累计进行更新
hql="
use shopee_operations;
insert overwrite table register_total partition(dt='${DT[0]}')
select
t1.channel_id
,t1.res_num+t2.res_num
from
register_total as t1
join
bs_res_analysis_data_day as t2
on
t1.channel_id=t2.channel_id
and
t2.dt='${DT[0]}'
where
t1.dt='${DT[1]}'
"

ExecuteHQL "${hql}"

##左关联插入login_buy_total独有的
hql="
use shopee_operations;
insert into table register_total partition(dt='${DT[0]}')
select
t1.channel_id
,t1.res_num
from
register_total as t1
left join
bs_res_analysis_data_day as t2
on
t1.channel_id=t2.channel_id
and
t2.dt='${DT[0]}'
where
t1.dt='${DT[1]}'
and
t2.channel_id is null
"

ExecuteHQL "${hql}"


##左关联插入bs_res_analysis_data_day独有的
hql="
use shopee_operations;
insert into table register_total partition(dt='${DT[0]}')
select
t1.channel_id
,t1.res_num
from
bs_res_analysis_data_day as t1
left join
register_total as t2
on
t1.channel_id=t2.channel_id
and
t2.dt='${DT[1]}'
where
t1.dt='${DT[0]}'
and
t2.channel_id is null
"

ExecuteHQL "${hql}"

sql="delete from res_analysis_cumulative where date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


hql="
select
null as id
,channel_id
,res_num
,'${DT[0]}'
from
register_total
where
dt='${DT[0]}'
"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "res_analysis_cumulative" "common_bus"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "res_analysis_cumulative"




