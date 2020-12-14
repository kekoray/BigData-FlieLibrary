#!/usr/bin/env bash

#==============================================================
#   Description :  从MySQL中映射ods_mysql_monitor_relation
#   FileName :  ods_mysql_monitor_relation.sh
#   Version  :  1.0
#   Author   :  Koray
#   Date     :  2020-12-04
#   Company  :  menglar
#==============================================================



#=================  函数的加载  ================================

source ./function_lazada.sh

#==============================================================



#-----------------  配置信息  -------------------------------

#各组件的本地路径
HIVE_PATH=/usr/local/service/hive/bin/hive
SQOOP_PATH=/usr/local/service/sqoop/bin/sqoop

#mysql的配置信息
MYSQL_IP="10.0.16.14"       
MYSQL_PORT="3306"                                 
MYSQL_USER="lazada_dev"
MYSQL_PWD="v0ZsvowM6JzTNoSw"                        
MYSQL_DB="lazada_base"

#--------------------------------------------------------------


#--------------  切换用户  -------------- 
if [ `whoami` = "hadoop" ];then
    echo "hadoop user"
    target_user=''
else
    echo "The user is not hadoop ！"
    target_user="sudo -u hadoop"
fi
#--------------------------------------- 



#cos存储地址,末尾带"/"
COSN_ODS_MYSQL_MONITOR_RELATION_PATH=cosn://emr-1254463213/lazada_dw/ods/ods_mysql_monitor_relation/


#一级分区的日期,格式:yyyy-MM-dd
if [ $# -lt 1 ];then  
    #不传参
    date=$(date -d -0day +%Y-%m-%d)   
else
    #传参
    DT=$1    
    date=`date -d "-0 day $DT" +%Y-%m-%d`
fi

echo " 一级分区的日期: [ $date ] "
echo "          "





#========================  Sqoop-Import-Query  ======================================


#mysql表导出的路径
target_path=${COSN_ODS_MYSQL_MONITOR_RELATION_PATH}${date}


echo "===================   Executing Sqoop--Import--Direct Mode Task   ==================="
echo "    "
echo " Hive date Warehouse Path 
       ==>   [ ${target_path} ]   "
echo "    "



#Sqoop--Import--Direct模式
${target_user} ${SQOOP_PATH}  import \
  --connect jdbc:mysql://${MYSQL_IP}:${MYSQL_PORT}/${MYSQL_DB} \
  --username ${MYSQL_USER} \
  --password ${MYSQL_PWD} \
  --fields-terminated-by '\t' \
  --lines-terminated-by '\n' \
  --delete-target-dir \
  --target-dir  ${target_path} \
  --direct --m 1 \
  --query "SELECT
           site_id,
           user_id,
           group_id,
           target_type,
           target_id,
           gmt_create,
           gmt_modified
           FROM lz_monitor_subject
           where \$CONDITIONS" 


echo "    "
echo "===================   The Sqoop--Import--Direct Task Has Been completed ...    ==================="
echo "    "
echo "===================   date Loading Of Hive date Warehouse  ==================="
echo "    "


#hive表加载数据
hql="use lazada_dw;
     alter table ods_mysql_monitor_relation drop if exists partition(dt='${date}');
     alter table ods_mysql_monitor_relation add if not exists partition(dt='${date}')
     location '${target_path}';"


echo " executing  ...  "
echo " ==>   [ ${hql} ]  "
${target_user} ${HIVE_PATH} -e "${hql}"



echo "    "
echo "===================   Completed Loading ...  ==================="
echo "    "
echo "========== [ ods_mysql_monitor_relation ] Completed Loading ... =========="
echo "    "





#====================================================================================
#============================  dwd层的数据入库  ======================================
#====================================================================================


#日期选择
DT=`date -d "-0 day $date" +%Y-%m-%d`

for ((i= 1;i<=60;i++))
do
DT[$i]=$(date -d "${DT} -$i days" "+%Y-%m-%d")
done

echo " 分区字段为: [ ${DT[0]} ] " 
echo "          "



#====================  dwd_monitor_item的数据加载  ====================
echo " 操作的表名为: [ dwd_monitor_item ] " 
echo "          "


#hive表数据加载
hql="use lazada_dw;
set io.sort.mb=10;
set io.sort.factor=100;
alter table dwd_monitor_item drop if exists PARTITION(dt='${DT[0]}');
insert overwrite table dwd_monitor_item PARTITION(dt='${DT[0]}')
select
site_id,
user_id,
target_id as item_id,
create_time,
modified_time
from
ods_mysql_monitor_relation
where
target_type = 1
and
dt='${DT[0]}';
"

#执行hql
ExecuteHQL "${hql}"
echo "          " 
echo "========== [ dwd_monitor_item ] Completed Loading ... =========="
echo "          " 





#====================  dwd_monitor_shop的数据加载  ====================
echo " 操作的表名为: [ dwd_monitor_shop ] " 
echo "          "


#hive表数据加载
hql="use lazada_dw;
set io.sort.mb=10;
set io.sort.factor=100;
alter table dwd_monitor_shop drop if exists PARTITION(dt='${DT[0]}');
insert overwrite table dwd_monitor_shop PARTITION(dt='${DT[0]}')
select
site_id,
user_id,
target_id as shop_id,
create_time,
modified_time
from
ods_mysql_monitor_relation
where
target_type = 2
and
dt='${DT[0]}';
"

#执行hql
ExecuteHQL "${hql}"

echo "          " 
echo "========== [ dwd_monitor_shop ] Completed Loading ... =========="
echo "          " 




