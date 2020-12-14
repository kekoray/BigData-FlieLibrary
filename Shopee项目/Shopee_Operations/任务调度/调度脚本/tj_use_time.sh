#!/usr/bin/env bash

########################################################################
# Description :埋点日志数据---运营后台-产品访问分析(数据保留近半年)
# Script   :tj_use_time.sh
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

#mysql数据库统计表---先删除后插入

sql="delete from tj_use_time where timest='${DT[180]}' or timest='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


################################################################################################
#埋点日志数据----运营后台(数据保留近半年)
hql="
select 
concat_ws('_',t1.si,t1.pi,'${DT[0]}') as id
,t1.si
,t3.sys_role_id
,t1.pi
,nvl(t2.sum_duration,0)
,nvl(t2.sum_duration/t1.uv,0)
,t1.uv
,'${DT[0]}'
from
(select
si
,pi
,count(distinct(uid)) as uv
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
group by
si
,pi
) as t1
left join
(select
si
,pi
,sum(duration) as sum_duration
from
(select
si
,pi
,et as atime
,lead(et) over (partition by uid order by et asc) as etime
,cast(lead(et) over (partition by uid order by et asc) as bigint)-cast(et as bigint) as duration
from
burying_point_log
where
dt='${DT[1]}'
and
pi!='NULL'
and
uid!='NULL'
and
pi!='0'
) as b
where
duration is not null
and duration<1800
group by
si
,pi
) as t2
on t1.si=t2.si
and t1.pi=t2.pi
join
sys_product_type as t3
on t1.si=t3.app_id
and t1.pi=t3.sys_product_id
and t3.dt='${DT[1]}'

"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "tj_use_time" "库"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "tj_use_time" 



#  echo "$hql"
