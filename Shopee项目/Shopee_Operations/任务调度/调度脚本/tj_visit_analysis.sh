#!/usr/bin/env bash


########################################################################
# Description :埋点日志数据---运营后台-产品访问分析(数据保留近半年)
# Script   :tj_visit_analysis.sh
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


for ((i= 1;i<=180;i++))
do
DT[$i]=$(date -d "${DT} -$i days" "+%Y-%m-%d")
done

#############埋点日志数据的同步 ###############################################################

#sh ./burying_point_log.sh ${DT[0]}

#############################################################################


#MySQL统计表插入数据之前先删除当前要跑数据的分区数据---先删后插

sql="delete from tj_visit_analysis where timest='${DT[180]}' or timest='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


################################################################################################
#埋点日志数据----运营后台-产品访问分析(数据保留近半年)
hql="
select 
concat_ws('_',a.si,'${DT[0]}') as id
,a.si
,a.pv
,a.uv
,a.ip_num
,c.sum_duration/a.uv
,'${DT[0]}'
from
(select
si
,count(*) as pv
,count(distinct(uid)) as uv
,count(distinct(ip)) as ip_num
from
burying_point_log
where
dt='${DT[1]}'
and
uid!='NULL'
group by si) as a
left join
(select
si
,sum(duration) as sum_duration
from
(select
si
,uid
,ip
,et as atime
,lead(et) over (partition by uid order by et asc) as etime
,cast(lead(et) over (partition by uid order by et asc) as bigint)-cast(et as bigint) as duration
from
burying_point_log
where
dt='${DT[1]}'
and
uid!='NULL') as b
where
duration is not null
and duration<1800
group by si) as c
on (a.si=c.si)
"




#ExportToMySQLByHQL "$hql" "${DT[0]}" "tj_visit_analysis" "库名"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "tj_visit_analysis" 


#  echo "$hql"