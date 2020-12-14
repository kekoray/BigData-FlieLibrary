#!/usr/bin/env bash


#########################################################################
#sync_product_type.sh
#传参数量：1，不传，默认当天
#参数格式：yyyy-MM-dd
#同步方式：每天全量
# Date     :2020-11-10
# Author   :koray
# Company  :menglar
#########################################################################


#各组件的本地路径
SQOOP_PATH=/usr/local/service/sqoop/bin/sqoop
HIVE_PATH=/usr/local/service/hive/bin/hive



#mysql连接信息
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



#parameter_date=$1
#ate=`date -d "+0 day ${parameter_date}" +%Y-%m-%d`
#echo $date


if [ $# -lt 1 ];then
 date=$(date -d -0day +%Y-%m-%d)
else
 DT=$1
 date=`date -d "-0 day $DT" +%Y-%m-%d`
fi


echo " ===== 分区时间字段:  ${date}  ===== "
echo "    "




#####################################################################################
#========================  sqoop方式MySQL导入hive  =====================================



#云存储地址（cosn）
COSN_MALL_GOODS_TEMP_PATH=cosn://emr-1254463213/shopee_dw/operations_center/sync_product_type/
MALL_GOODS_TEMP_LOG_PATH=${COSN_MALL_GOODS_TEMP_PATH}${date}/

echo " Hive Data Warehouse Path 
       ==>   [ ${MALL_GOODS_TEMP_LOG_PATH} ]   "
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
  --target-dir  ${MALL_GOODS_TEMP_LOG_PATH} \
  --direct --m 1 \
  --query "select
           id
           ,app_id
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
alter table sync_product_type drop if exists partition(dt='$date');
alter table sync_product_type add if not exists partition(dt='$date')
location '${MALL_GOODS_TEMP_LOG_PATH}';"



echo " executing  ......  "
echo " ==>   [ ${hql} ]  "
${target_user} ${HIVE_PATH} -e "${hql}"



echo "    "
echo "===================   Completed Loading ...  ==================="
echo "    "
