#!/usr/bin/env bash

 
########################################################################
# Description :埋点日志数据---运营后台-事件分析(数据保留近半年)
# Script   :tj_track_event.sh
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

###############################################################################################


#mysql数据库统计表----先删除后插入
sql="delete from tj_track_event where timest='${DT[180]}' or timest='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


################################################################################################
#埋点日志数据----运营后台-事件分析(数据保留近半年)
hql="
select 
null as id
,t2.si
,t2.eplabel
,t2.epaction
,t2.epcategory
,t3.sys_role_id
,t1.pi
,t2.all_event_count
,t1.event_count
,t2.all_uid_count
,t1.uniq_event_count
,'${DT[0]}'
from
(select
si
,eplabel
,epaction
,epcategory
,pi
,count(*) as event_count
,count(distinct(uid)) as uniq_event_count
from
burying_point_log
where
dt='${DT[1]}'
and
eplabel!='NULL'
and
uid!='NULL'
and
pi!='NULL'
and
pi!='0'
group by
si
,eplabel
,epaction
,epcategory
,pi) as t1
join
(select
si
,eplabel
,epaction
,epcategory
,count(*) as all_event_count
,count(distinct(uid)) as all_uid_count
from
burying_point_log
where
dt='${DT[1]}'
and
eplabel!='NULL'
and
uid!='NULL'
and
pi!='NULL'
and
pi!='0'
group by
si
,eplabel
,epaction
,epcategory) as t2
on t1.si=t2.si
and t1.eplabel=t2.eplabel
and t1.epaction=t2.epaction
and t1.epcategory=t2.epcategory
join
sys_product_type as t3
on t1.si=t3.app_id
and t1.pi=t3.sys_product_id
and t3.dt='${DT[1]}'

"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "tj_track_event" "库名"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "tj_track_event" 



#  echo "$hql"