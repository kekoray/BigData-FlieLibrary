#!/usr/bin/env bash

#############################
#从cosn云存储上面把数据同步映射到hive本地的映射表中
#获取用户浏览日志
#############################



################  函数脚本的引进  #################

source ./function_shopee.sh

#################################################


#云存储地址（cosn）
COSN_BURYING_POINT_LOG_PATH=cosn://app-log-1254463213/front-log


#if [ $# -lt 1 ];then
# date=$(date +%Y-%m-%d -d -1day)
# curdate=$(date +%Y-%m-%d -d -1day)
#else
# curdate=`date -d "-0 day $1" +%Y-%m-%d`
# date=`date -d "-1 day ${curdate}" +%Y-%m-%d`
#fi
 

if [ $# -lt 1 ];then
 date=$(date -d -0day +%Y-%m-%d)
else
 DT=$1
 date=`date -d "-0 day $DT" +%Y-%m-%d`
fi


echo " == 时间分区字段为: $date == "



##########################################################################

#日期 
BURYING_POINT_LOG_PATH=${COSN_BURYING_POINT_LOG_PATH}/${date}
#QBT3_ARTICE_SYS_LOG_LOG_PATH=cosn://log/less-log/qbt3_artice_sys_log/20200616/
#echo 'log路径:'  ${BURYING_POINT_LOG_PATH}


hql="use shopee_operations;
alter table burying_point_log drop if exists partition(dt='${date}');
alter table burying_point_log add if not exists partition(dt='${date}')
location '${BURYING_POINT_LOG_PATH}';"


ExecuteHQL "${hql}"

#echo "$hql"                                    