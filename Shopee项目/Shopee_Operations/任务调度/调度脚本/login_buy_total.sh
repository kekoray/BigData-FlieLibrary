#!/usr/bin/env bash

#########################################################
# Description :渠道转化统计累计统计
# Script   :login_buy_total.sh
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

##插入两者都有的,能关联上的，对累计进行更新
hql="
use shopee_operations;
insert overwrite table login_buy_total partition(dt='${DT[0]}')
select
t1.channel_id
,t1.product_id
,t1.total_change_num+t2.change_num as total_change_num
,t1.total_gmv+t2.gmv as total_gmv
,t1.total_artificial_change+t2.artificial_change as total_artificial_change
,t1.total_natural_change+t2.natural_change as total_natural_change
from
login_buy_total as t1
join
( 
select
channel_id
,product_id
,count(distinct uid) as change_num
,sum(amount) as gmv
,count(distinct case when turn_type='1' then uid end) as artificial_change
,count(distinct case when turn_type='0' then uid end) as natural_change
from
(
select
uid
,product_id
,channel_id
,amount
,turn_type
from
login_buy_real
where
dt='${DT[0]}'
and
event='pay'
and
cast(amount as int)>100
group by
uid
,product_id
,channel_id
,amount
,turn_type
) as t3
group by
channel_id
,product_id
) as t2
on
t1.channel_id=t2.channel_id
and
t1.product_id=t2.product_id
where
t1.dt='${DT[1]}'
"

ExecuteHQL "${hql}"

##左关联插入login_buy_total独有的
hql="
use shopee_operations;
insert into table login_buy_total partition(dt='${DT[0]}')
select
t1.channel_id
,t1.product_id
,t1.total_change_num
,t1.total_gmv
,t1.total_artificial_change
,t1.total_natural_change
from
login_buy_total as t1
left join
( 
select
channel_id
,product_id
,count(distinct uid) as change_num
,sum(amount) as gmv
,count(distinct case when turn_type='1' then uid end) as artificial_change
,count(distinct case when turn_type='0' then uid end) as natural_change
from
(
select
uid
,product_id
,channel_id
,amount
,turn_type
from
login_buy_real
where
dt='${DT[0]}'
and
event='pay'
and
cast(amount as int)>100
group by
uid
,product_id
,channel_id
,amount
,turn_type
) as t3
group by
channel_id
,product_id
) as t2
on
t1.channel_id=t2.channel_id
and
t1.product_id=t2.product_id
where
t1.dt='${DT[1]}'
and
t2.channel_id is null
and
t2.product_id is null
"

ExecuteHQL "${hql}"



##插入login_buy_real独有的
hql="
use shopee_operations;
insert into table login_buy_total partition(dt='${DT[0]}')
select
t1.channel_id
,t1.product_id
,t1.change_num
,t1.gmv
,t1.artificial_change
,t1.natural_change
from
( 
select
channel_id
,product_id
,count(distinct uid) as change_num
,sum(amount) as gmv
,count(distinct case when turn_type='1' then uid end) as artificial_change
,count(distinct case when turn_type='0' then uid end) as natural_change
from
(
select
uid
,product_id
,channel_id
,amount
,turn_type
from
login_buy_real
where
dt='${DT[0]}'
and
event='pay'
and
cast(amount as int)>100
group by
uid
,product_id
,channel_id
,amount
,turn_type
) as t3
group by
channel_id
,product_id
) as t1
left join
login_buy_total as t2
on
t1.channel_id=t2.channel_id
and
t1.product_id=t2.product_id
and
t2.dt='${DT[1]}'
where
t2.channel_id is null
and
t2.product_id is null
"

ExecuteHQL "${hql}"


sql="delete from channel_change_details where res_date='${DT[0]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"


hql="
select
null as id
,'${DT[0]}' as res_date
,t1.channel_id
,t1.product_id
,nvl(t2.change_num,0)
,nvl(t2.past_change_num,0)
,nvl(t2.gmv,0)
,nvl(t2.past_gmv,0)
,nvl(t1.total_change_num,0)
,nvl(t1.total_gmv,0)
from
login_buy_total as t1
left  join
bs_channel_change_data_day as t2 
on
t1.channel_id=t2.channel_id
and
t1.product_id=t2.product_id
and
t2.dt='${DT[0]}'
where
t1.dt='${DT[0]}'
"


#ExportToMySQLByHQL "$hql" "${DT[0]}" "channel_change_details" "shopee_operations"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "channel_change_details" 




###############下面开始维护用户过期时间######################

#########获取当天每个产品每个用户的最小最大过期时间
hql="
use shopee_operations;
insert overwrite table tmp_login_buy_overtime_range
select
uid
,app_id
,min(date_format(over_time,'yyyy-MM-dd')) as min_over_time
,max(date_format(over_time,'yyyy-MM-dd')) as max_over_time 
from
login_buy_detail
where
dt='${DT[0]}'
and
over_time is not null
and
!(member_type='7' and product_type='16')
group by
uid
,app_id
"

ExecuteHQL "${hql}"


##########更新login_buy_overtime_change和login_buy_detail共有的，如果能关联上，就把今天最大的的过期时间作为aft_over_time更新到login_buy_overtime_change中，其中变更日期为当天
hql="
use shopee_operations;
insert overwrite table login_buy_overtime_change partition(dt='${DT[0]}')
select
t1.uid
,t1.app_id
,case when t1.max_over_time!=t2.aft_over_time then t2.aft_over_time else t2.bef_over_time end as bef_over_time
,case when t1.max_over_time!=t2.aft_over_time then t1.max_over_time else t2.aft_over_time end as aft_over_time
,case when t1.max_over_time!=t2.aft_over_time then '${DT[0]}' else t2.change_date end  as change_date
from
tmp_login_buy_overtime_range as t1
join
login_buy_overtime_change as t2
on
t1.uid=t2.uid
and 
t1.app_id=t2.app_id
and
t2.dt='${DT[1]}'
where
nvl(cast(t2.uid as decimal(20)),0)>0
"

ExecuteHQL "${hql}"





##########插入tmp_login_buy_overtime_range独有的,如果最小过期时间等于最大过期时间,说明只要一种过期时间，所以把bef_over_time置为null，如果不一样,则把最小的过期时间置为bef_over_time,最大置为aft_over_time
hql="
use shopee_operations;
insert into table login_buy_overtime_change partition(dt='${DT[0]}')
select
t1.uid
,t1.app_id
,case when t1.min_over_time=t1.max_over_time then null else min_over_time end as bef_over_time
,t1.max_over_time as aft_over_time
,'${DT[0]}' as change_date
from
tmp_login_buy_overtime_range as t1
left join
login_buy_overtime_change as t2
on
t1.uid=t2.uid
and 
t1.app_id=t2.app_id
and
t2.dt='${DT[1]}'
where
nvl(cast(t1.uid as decimal(20)),0)>0
and
t2.uid is null 
"

ExecuteHQL "${hql}"




########插入login_buy_overtime_change独有的,直接插入关联不上的就行
hql="
use shopee_operations;
insert into table login_buy_overtime_change partition(dt='${DT[0]}')
select
t1.uid
,t1.app_id
,t1.bef_over_time
,t1.aft_over_time
,t1.change_date
from
login_buy_overtime_change as t1
left join
tmp_login_buy_overtime_range as t2
on
t1.uid=t2.uid
and 
t1.app_id=t2.app_id
where
nvl(cast(t1.uid as decimal(20)),0)>0
and
t1.dt='${DT[1]}' 
and
t2.uid is null 
"

ExecuteHQL "${hql}"