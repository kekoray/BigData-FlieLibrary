#!/usr/bin/env bash



########################################################################
# Description :埋点日志数据---运营后台-(数据保留近半年)
# Script   :tj_use_time_analysis.sh
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

sql="delete from tj_use_time_analysis where timest='${DT[180]}' or timest='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


###############################################

#埋点日志数据----运营后台(数据保留近半年)
hql="
select 
concat_ws('_',c.si,c.solt_id,c.pi,'${DT[0]}') as id
,c.si
,c.solt_id
,t3.sys_role_id
,c.pi
,nvl(c.sum_length,0)
,nvl(c.sum_length/c.num,0)
,c.num
,'${DT[0]}'
from
(select
si
,pi
,solt_id
,sum(length) as sum_length
,count(*) as num
from
(select
si
,pi
,uid
,sum(duration) as length
,case when sum(duration)>=0 and sum(duration)<=180 then '1'
when sum(duration)>180 and sum(duration)<=600 then '2'
when sum(duration)>600 and sum(duration)<=1200 then '3'
when sum(duration)>1200 and sum(duration)<=1800 then '4'
when sum(duration)>1800 and sum(duration)<=3600 then '5'
when sum(duration)>3600 and sum(duration)<=7200 then '6'
else '7' end as solt_id
from
(select
si
,pi
,uid
,et as atime
,lead(et) over (partition by uid order by et asc) as etime
,cast(lead(et) over (partition by uid order by et asc) as bigint)-cast(et as bigint) as duration
from
burying_point_log
where
dt='${DT[1]}'
and
uid!='NULL'
and
pi!='NULL'
and
pi!='0'
) as a
where
duration is not null
and duration<1800
group by
si
,pi
,uid) b
group by
si
,pi
,solt_id) c
join
sys_product_type as t3
on c.si=t3.app_id
and c.pi=t3.sys_product_id
and t3.dt='${DT[1]}'

"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "tj_use_time_analysis" "库名"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "tj_use_time_analysis" 


#  echo "$hql"
