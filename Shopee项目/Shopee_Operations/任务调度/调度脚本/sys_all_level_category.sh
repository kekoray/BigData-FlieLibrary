#!/usr/bin/env bash

#########################################################
# Description :同步sys_category把级别打横,该表用于获取准确的channel_id
# Script   :sys_all_level_category.sh
# Version  :1.0
# Date     :2020-11-10
# Author   :koray
# Company  :menglar
#########################################################



#各组件的本地路径
SQOOP_PATH=/usr/local/service/sqoop/bin/sqoop
HIVE_PATH=/usr/local/service/hive/bin/hive


#mysql连接信息 -- mengla_crm
MYSQL_IP="10.168.0.12"   
MYSQL_PORT="3306"                              
MYSQL_USER="crm_dev"                            
MYSQL_PWD="EPvFqqcIUQCFzxuT"                    
MYSQL_DB="mengla_crm"         


#----------------切换用户----------------#
if [ `whoami` = "hadoop" ];then
        echo "hadoop user"
        target_user=''
else
        echo "The user is not hadoop ！"
        target_user="sudo -u hadoop"
fi
#---------------------------------------#





date=`date -d "-0 day $1" +%Y-%m-%d`

if [ $# -lt 1 ];then
 DT=$(date +%Y-%m-%d -d -0day)
else
 DT=$1
fi

DT=`date -d "-1 day $DT" +%Y-%m-%d`


for ((i= 1;i<=30;i++))
do
DT[$i]=$(date -d "${DT} -$i days" "+%Y-%m-%d")
done


echo " ===== 分区时间字段:  ${DT}  ===== "
echo "    "



#####################################################################################
#========================  sqoop方式MySQL导入hive  =====================================


echo "===================   Executing Sqoop--Import--Direct Mode Task   ==================="
echo "    "


#日期
DT=$DT


#云存储地址（cosn）
COSN_SYS_ALL_LEVEL_CATEGORY_PATH=cosn://emr-1254463213/shopee_dw/operations_center/sys_all_level_category/
SYS_ALL_LEVEL_CATEGORY_LOG_PATH=${COSN_SYS_ALL_LEVEL_CATEGORY_PATH}${DT}/


echo " Hive Data Warehouse Path 
       ==>   [ ${SYS_ALL_LEVEL_CATEGORY_LOG_PATH} ]   "
echo "    "


echo "===================   Executing Sqoop--Import--Direct Mode Task   ==================="
echo "    "


#Sqoop--Import--Direct模式
${target_user} ${SQOOP_PATH}  import \
  --connect jdbc:mysql://${MYSQL_IP}:${MYSQL_PORT}/${MYSQL_DB} \
  --username ${MYSQL_USER} \
  --password ${MYSQL_PWD} \
  --fields-terminated-by '\t' \
  --lines-terminated-by '\n' \
  --delete-target-dir \
  --target-dir  ${SYS_ALL_LEVEL_CATEGORY_LOG_PATH} \
  --direct --m 1 \
  --query "select
           t1.name as type1_name
           ,t1.id as type1_id
           ,t1.code as type1_code
           ,t2.name as type2_name
           ,t2.id as type2_id
           ,t2.code as type2_code
           ,t3.name as type3_name
           ,t3.id as type3_id
           ,t3.code as type3_code
           ,t4.name as type4_name
           ,t4.id as type4_id
           ,t4.code as type4_code
           from 
           sys_category t1
           join sys_category t2
           on (t1.id=t2.pid)
           join sys_category t3
           on (t2.id=t3.pid)
           left join sys_category t4 
           on (t3.id=t4.pid)
           where
           t1.code='syslog' and \$CONDITIONS"



echo "    "
echo "===================   The Sqoop--Import--Direct Task Has Been completed ...    ==================="
echo "    "
echo "    "
echo "===================   Data Loading Of Hive Data Warehouse  ==================="
echo "    "


#================== 映射hive表 ==========================================
hql="use shopee_operations;
alter table sys_all_level_category drop if exists partition(dt='$DT');
alter table sys_all_level_category add if not exists partition(dt='$DT')
location '${SYS_ALL_LEVEL_CATEGORY_LOG_PATH}';"


echo " executing  ......  "
echo " ==>   [ ${hql} ]  "
${target_user} ${HIVE_PATH} -e "${hql}"



echo "    "
echo "===================   Completed Loading ...  ==================="
echo "    "





