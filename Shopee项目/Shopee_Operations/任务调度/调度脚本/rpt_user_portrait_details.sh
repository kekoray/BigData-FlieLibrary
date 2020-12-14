#!/usr/bin/env bash

#########################################################
# Description :知虾的用户肖像的数据统计脚本
# Script   :rpt_user_portrait_details.sh
# Version  :1.1
# Date     :2020-11-13
# Author   :koray
# Company  :menglar
#########################################################

################  函数脚本的引进  #################

source ./function_shopee.sh

#################################################

HIVE_PATH=/usr/local/service/hive/bin/hive
HADOOP_PATH=/usr/local/service/hadoop/bin/hadoop

#########################################################################


if [ $# -lt 1 ];then
 DT=$(date +%Y-%m-%d -d -0day)
else
 DT=$1
fi


for ((i= 1;i<=60;i++))
do
DT[$i]=$(date -d "${DT} -$i days" "+%Y-%m-%d")
done


#同步mysql数据库中知虾的支付表信息到hive外部表中
#sh ./sync_shopee_pd_order.sh  ${DT[0]}
#########################################################################
##########################################################################



#知虾各个服务版本下的用户数据---中间表数据
#
#2020-12-03修改: sync_product_type的字查询中添加dt='${DT[0]}'条件
#
hql="use shopee_operations;
insert overwrite table user_shopee_portrait_middle_data PARTITION (dt='${DT[0]}')
select
t1.app_id
,t1.role_id
,t1.role_name
,t1.sys_product_id
,t1.product_id
,t2.user_id
,t2.pay_mode
,t2.maturity_time
,t2.pay_time
from
(select
app_id
,role_id
,role_name
,sys_product_id
,product_id
from
sync_product_type
where
app_id='shopee'
and sys_product_id is not null
and sys_product_id!='NULL'
and dt='${DT[0]}'
) as t1
join
(select
user_id
,product_item_id
,pay_mode
,pay_time
,date_format(maturity_time,'yyyy-MM-dd') as maturity_time
from
(select
user_id
,product_item_id
,pay_mode
,pay_time
,maturity_time
,row_number() over (partition by user_id order by date_format(pay_time,'yyyy-MM-dd') desc) as rank
from
sync_shopee_pd_order
where
dt='${DT[0]}'
and pay_time!='NULL'
and product_item_id is not null
and product_item_id!='NULL'
and tenant_id=1
and order_status=1
) a where rank=1 ) as t2
on t1.sys_product_id=t2.product_item_id

"

ExecuteHQL "${hql}"

#############################################################################

#知虾各个服务版本下的用户第一次购买的用户数据---中间表数据
hql="use shopee_operations;
insert overwrite table user_shopee_portrait_first_repeat PARTITION (dt='${DT[0]}')
select
a.app_id
,a.role_id
,a.role_name
,a.sys_role_id
,a.user_id
,a.pay_mode
,a.maturity_time
,a.pay_time
,1 as type
from
(select
app_id
,role_id
,role_name
,sys_role_id
,user_id
,pay_mode
,date_format(maturity_time,'yyyy-MM-dd') as maturity_time
,pay_time
from
user_shopee_portrait_middle_data
where
dt='${DT[0]}'
and date_format(maturity_time,'yyyy-MM-dd')>='${DT[1]}') as a
join
(select
user_id
,count(*) user_num
from
sync_shopee_pd_order
where
dt='${DT[0]}'
group by
user_id
having
user_num=1) as b
on a.user_id=b.user_id

"

ExecuteHQL "${hql}"


#参谋各个服务版本下的用户重复多次购买的用户数据
hql="use shopee_operations;
insert into table user_shopee_portrait_first_repeat PARTITION (dt='${DT[0]}')
select
a.app_id
,a.role_id
,a.role_name
,a.sys_role_id
,a.user_id
,a.pay_mode
,a.maturity_time
,a.pay_time
,2 as type
from
(select
app_id
,role_id
,role_name
,sys_role_id
,user_id
,pay_mode
,date_format(maturity_time,'yyyy-MM-dd') as maturity_time
,pay_time
from
user_shopee_portrait_middle_data
where
dt='${DT[0]}'
and date_format(maturity_time,'yyyy-MM-dd')>='${DT[1]}') as a
join
(select
user_id
,count(*) user_num
from
sync_shopee_pd_order
where
dt='${DT[0]}'
group by
user_id
having
user_num>1) as b
on a.user_id=b.user_id

"

ExecuteHQL "${hql}"


#############################################################################



sql="delete from rpt_user_portrait_details where date='${DT[1]}'"

echo '-----------删除语句是'
echo ${sql}

ExecuteMysql "$sql"




#知虾用户的肖像数据---统计入库mysql
hql="
select 
concat_ws('_',t1.app_id,t1.role_id,t1.role_name,'${DT[0]}') as id
,t1.role_id
,coalesce(t1.user_num,0)
,coalesce(t9.yearday_user_num,0)
,coalesce(t2.first_pay_num,0)
,coalesce(t3.repeat_pay_num,0)
,coalesce(t10.people_num,0)
,coalesce(t4.yearday_people_num,0)
,coalesce(t5.invalid_num,0)
,coalesce(t6.year_invalid_num,0)
,coalesce(t7.natu_conver_num,0)
,coalesce(t8.arti_conver_num,0)
,'${DT[1]}'
from
(select
app_id
,role_id
,role_name
,count(*) user_num
from
user_shopee_portrait_middle_data
where
dt='${DT[0]}'
and
maturity_time>='${DT[1]}'
group by
app_id
,role_id
,role_name) as t1
left join
(select
app_id
,role_id
,role_name
,count(*) yearday_user_num
from
user_shopee_portrait_middle_data
where
dt='${DT[1]}'
and
maturity_time>='${DT[2]}'
group by
app_id
,role_id
,role_name) as t9
on (t1.role_id=t9.role_id)
left join
(select
role_id
,count(*) as first_pay_num
from
user_shopee_portrait_first_repeat
where
dt='${DT[0]}'
and
type=1
group by
role_id
) as t2
on (t1.role_id=t2.role_id)
left join
(select
role_id
,count(*) as repeat_pay_num
from
user_shopee_portrait_first_repeat
where
dt='${DT[0]}'
and
type=2
group by
role_id
) as t3
on (t1.role_id=t3.role_id)
left join
(select
role_id
,count(*) as people_num
from
user_shopee_portrait_middle_data
where
dt='${DT[0]}'
and date_format(pay_time,'yyyy-MM-dd')='${DT[1]}'
group by
role_id
) as t10
on (t1.role_id=t10.role_id)
left join
(select
role_id
,count(*) as yearday_people_num
from
user_shopee_portrait_middle_data
where
dt='${DT[0]}'
and date_format(pay_time,'yyyy-MM-dd')='${DT[2]}'
group by
role_id
) as t4
on (t1.role_id=t4.role_id)
left join
(select
role_id
,count(*) as invalid_num
from
user_shopee_portrait_middle_data
where
dt='${DT[0]}'
and maturity_time='${DT[1]}'
group by
role_id
) as t5
on (t1.role_id=t5.role_id)
left join
(select
role_id
,count(*) as year_invalid_num
from
user_shopee_portrait_middle_data
where
dt='${DT[1]}'
and maturity_time='${DT[2]}'
group by
role_id
) as t6
on (t1.role_id=t6.role_id)
left join
(select
role_id
,count(*) as natu_conver_num
from
user_shopee_portrait_middle_data
where
dt='${DT[0]}'
and date_format(maturity_time,'yyyy-MM-dd')>='${DT[1]}'
and pay_mode=0
group by
role_id
) as t7
on (t1.role_id=t7.role_id)
left join
(select
role_id
,count(*) as arti_conver_num
from
user_shopee_portrait_middle_data
where
dt='${DT[0]}'
and date_format(maturity_time,'yyyy-MM-dd')>='${DT[1]}'
and pay_mode=1
group by
role_id
) as t8
on (t1.role_id=t8.role_id)

"

#ExportToMySQLByHQL "$hql" "${DT[0]}" "rpt_user_portrait_details"
                  # hql=$1  dt=$2      mysql_table=$3       hive_database=$4

#sqoop方式hive导出到MySQL表
#SqoopDirectExportToMySQLByHQL  hive_db=$1 sql=$2 dir_dt=$3 mysql_table=$4
SqoopDirectExportToMySQLByHQL "shopee_operations" "$hql" "${DT[0]}" "rpt_user_portrait_details" 


#  echo "$hql"