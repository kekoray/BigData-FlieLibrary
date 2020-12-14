#!/usr/bin/env bash


#########################################################
# Description :同步sys_product_type,用于获取准确的product_id
# Script   :sys_product_type.sh
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





date=`date -d "+0 day $1" +%Y-%m-%d`

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
COSN_SYS_PRODUCT_TYPE_PATH=cosn://emr-1254463213/shopee_dw/operations_center/sys_product_type/
SYS_PRODUCT_TYPE_LOG_PATH=${COSN_SYS_PRODUCT_TYPE_PATH}${DT}/

echo " Hive Data Warehouse Path 
       ==>   [ ${SYS_PRODUCT_TYPE_LOG_PATH} ]   "
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
  --target-dir  ${SYS_PRODUCT_TYPE_LOG_PATH} \
  --direct --m 1 \
  --query "select
           app_id
           ,role_id
           ,role_name
           ,sys_role_id
           ,product_name
           ,product_id
           ,sys_product_id
           from
           sys_product_type where \$CONDITIONS"



echo "    "
echo "===================   The Sqoop--Import--Direct Task Has Been completed ...    ==================="
echo "    "
echo "    "
echo "===================   Data Loading Of Hive Data Warehouse  ==================="
echo "    "
           

#================== 映射hive表 ==========================================

hql="use shopee_operations;
alter table sys_product_type drop if exists partition(dt='$DT');
alter table sys_product_type add if not exists partition(dt='$DT')
location '${SYS_PRODUCT_TYPE_LOG_PATH}';"


echo " executing  ......  "
echo " ==>   [ ${hql} ]  "
${target_user} ${HIVE_PATH} -e "${hql}"



echo "    "
echo "===================   Completed Loading ...  ==================="
echo "    "


  