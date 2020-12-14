#!/usr/bin/env bash


########################################################################
# Description :埋点日志数据---运营后台分析(数据保留近半年)
# Script   :tj_page_count.sh
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


#mysql统计表的先删除后插入
sql="delete from tj_page_count where timest='${DT[180]}' or timest='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


################################################################################################
#埋点日志数据----运营后台-(数据保留近半年)
hql="
select 
concat_ws('_',t1.si,t1.pct,'${DT[0]}') as id
,t1.si
,substr(t1.pct,0,INSTR(t1.pct,'*')-1) as pct_id
,substr(t1.pct,INSTR(t1.pct,'*')+1,length(t1.pct)) as pct_name
,nvl(t1.uv,0)
,nvl(t1.day_uv_rato,0)
,nvl(t1.pv,0)
,nvl(t2.sum_duration,0)
,nvl(t2.sum_duration/t1.uv,0)
,'${DT[0]}'
from
(select
a.si
,a.pct
,a.uv
,(a.uv-b.uv)/b.uv*10000 as day_uv_rato
,a.pv
from
(select
si
,pct
,count(*) as pv
,count(distinct(uid)) as uv
from
burying_point_log
where
dt='${DT[1]}'
and
uid!='NULL'
and
pct!='NULL'
group by
si
,pct
) as a
left join
(select
si
,pct
,count(*) as pv
,count(distinct(uid)) as uv
from
burying_point_log
where
dt='${DT[2]}'
and
uid!='NULL'
and
pct!='NULL'
group by
si
,pct
) as b
on a.si=b.si
and a.pct=b.pct
) as t1
left join
(select
si
,pct
,sum(duration) as sum_duration
from
(select
si
,pct
,et as atime
,lead(et) over (partition by uid order by et asc) as etime
,cast(lead(et) over (partition by uid order by et asc) as bigint)-cast(et as bigint) as duration
from
burying_point_log
where
dt='${DT[1]}'
and
pct!='NULL'
and
uid!='NULL'
) as b
where
duration is not null
and duration<1800
group by
si
,pct
) as t2
on t1.si=t2.si
and t1.pct=t2.pct


"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "tj_page_count" "库名"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "tj_page_count" 


#  echo "$hql"