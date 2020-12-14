#!/usr/bin/env bash

#########################################################
# Description :渠道转化统计,映射原始日志,处理json串，关联sys_cateogry和sys_product_type获取准确的channel_id和product_id
# Script   :login_buy_log.sh
# Version  :1.0
# Date     :2020-11-10
# Author   :koray
# Company  :menglar
#########################################################



#各组件的本地路径
SQOOP_PATH=/usr/local/service/sqoop/bin/sqoop
HIVE_PATH=/usr/local/service/hive/bin/hive



################  函数脚本的引进  #################

source ./function_shopee.sh

################################################# 


if [ $# -lt 1 ];then
 DT=$(date +%Y-%m-%d -d -0day)
else
 DT=$1
fi

DT=`date -d "-1 day $DT" +%Y-%m-%d`

for ((i= 1;i<=70;i++))
do
DT[$i]=$(date -d "${DT} -$i days" "+%Y-%m-%d")
done
 
 
#---------------后端类目-关键词原始日志----------#
#云存储地址（cosn）  
COSN_LOGIN_BUY_LOG_PATH=cosn://app-log-1254463213/background-log




#获取昨天日志 
LOGIN_BUY_LOG_PATH=${COSN_LOGIN_BUY_LOG_PATH}/${DT[0]}/
echo 'login_buy_log的log路径:'  ${LOGIN_BUY_LOG_PATH}

hql="use shopee_operations;
alter table login_buy_log drop if exists partition(dt='${DT[0]}');
alter table login_buy_log add if not exists partition(dt='${DT[0]}')
location '${LOGIN_BUY_LOG_PATH}';"



#执行hql
ExecuteHQL "${hql}"



######解析json的全字段表
hql="use shopee_operations;
insert overwrite table login_buy_detail partition(dt='${DT[0]}')
select
id
,event
,app_id
,channel_id
,turn_type
,t2.pay_times
,ua
,device_id
,device_type
,uid
,ip
,path
,trigger_time
,province
,city
,create_time
,status
,comment
,reg_time
,t1.mobile
,t1.over_time
,t1.member_type
,t1.user_name
,t1.pay_date
,t1.member_months
,t1.product_type
,t1.amount
FROM login_buy_log as t2
lateral view json_tuple(data,'qq','mobile','overTime','memberType','userName','payDate','payTimes','memberMonths','productType','amount') t1 as qq, mobile, over_time,member_type, user_name,pay_date,pay_times,member_months,product_type,amount
where
dt='${DT[0]}';"

ExecuteHQL "${hql}"


#####关联sys_category和sys_product_type获取最准确的channel_id和product_id


hql="
use shopee_operations;
insert overwrite table login_buy_real partition(dt='${DT[0]}')
select
t1.id
,t1.event
,t1.app_id
,t2.type4_id
,t1.turn_type
,t1.pay_times
,t1.ua
,t1.device_id
,t1.device_type
,t1.uid
,t1.ip
,t1.path
,t1.trigger_time
,t1.province
,t1.city
,t1.create_time
,t1.status
,t1.comment
,t1.reg_time
,t1.mobile
,t1.over_time
,t1.member_type
,t1.user_name
,t1.pay_date
,t1.member_months
,t3.product_id
,t1.amount
from
login_buy_detail as t1
join
sys_all_level_category as t2
on
t1.app_id=t2.type2_code
and
t1.channel_id=t2.type4_code
and
t2.dt='${DT[0]}'
join
sys_product_type as t3
on
t1.member_type=t3.sys_role_id
and
case when t1.product_type is null then 'NULL' else t1.product_type end =t3.sys_product_id
and
t3.dt='${DT[0]}'
where
t1.dt='${DT[0]}'
"

ExecuteHQL "${hql}"



