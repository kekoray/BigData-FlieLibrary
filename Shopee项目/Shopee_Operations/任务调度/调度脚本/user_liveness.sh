#!/usr/bin/env bash

#########################################################
# Description :渠道转化计算，活跃统计
# Script   :user_liveness.sh
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

for ((i= 1;i<=60;i++))
do
DT[$i]=$(date -d "${DT} -$i days" "+%Y-%m-%d")
done

#####################################################################################

#统计表先删除后插入

sql="delete from user_liveness where login_date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


############用户活跃度等信息的统计#########################################################################

hql="
select
concat_ws('_',a.uid,a.app_id,'${DT[0]}') as id
,a.uid
,b.role_id
,'${DT[0]}'
,a.app_id
from
(select
uid
,app_id
,member_type
from
login_buy_detail
where
dt='${DT[0]}'
and
event='login'
and
uid!='NULL'
group by
uid
,app_id
,member_type) a
join
(select
app_id
,role_id
,sys_role_id
from
sys_product_type
where
dt='${DT[0]}'
group by
app_id
,role_id
,sys_role_id) b
on a.member_type=b.sys_role_id
and a.app_id=b.app_id
"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "user_liveness" "库名"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "user_liveness" 



#echo "$hql"

###################################################################################################################

#mysql统计表先删除后插入

sql="delete from user_liveness_data where login_date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


#######获取的用户活跃度分析数量数据等信息
hql="
select
concat_ws('_',app_id,'${DT[0]}') as id
,count(distinct case when dt='${DT[0]}' then uid end) as one_day_num
,count(distinct case when dt>='${DT[6]}' and dt<='${DT[0]}' then uid end) as seven_day_num
,count(distinct case when dt>='${DT[29]}' and dt<='${DT[0]}' then uid end) as thirty_day_num
,'${DT[0]}'
,app_id
from
(select
a.app_id
,a.uid
,a.dt
from
(select
app_id
,uid
,member_type
,dt
from
login_buy_detail
where
uid!='NULL'
and
dt>='${DT[29]}'
and
dt<='${DT[0]}'
and
event='login'
group by
app_id
,uid
,member_type
,dt) a
join
(select
app_id
,role_id
,sys_role_id
from
sys_product_type
where
dt='${DT[0]}'
group by
app_id
,role_id
,sys_role_id) b
on a.member_type=b.sys_role_id
and a.app_id=b.app_id
) c
group by app_id
"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "user_liveness_data" "库名"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "user_liveness_data" 




#echo "$hql"