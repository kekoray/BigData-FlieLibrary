#!/usr/bin/env bash

#==============================================================
#   Description :  从MySQL中映射ods_mysql_station
#   FileName :  ods_mysql_station.sh
#   Version  :  1.1
#   Author   :  Koray
#   Date     :  2020-11-14
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
COSN_ODS_MYSQL_STATION_PATH=cosn://emr-1254463213/lazada_dw/ods/ods_mysql_station/


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
target_path=${COSN_ODS_MYSQL_STATION_PATH}${date}


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
           id, 
           site_name,
           site_name_en ,
           language ,
           currency ,
           exchange_rate,
           domains,
           status,
           create_time,
           update_time 
           FROM lz_site_info  
           where \$CONDITIONS"  


echo "    "
echo "===================   The Sqoop--Import--Direct Task Has Been completed ...    ==================="
echo "    "
echo "===================   date Loading Of Hive date Warehouse  ==================="
echo "    "


#hive表加载数据
hql="use lazada_dw;
     alter table ods_mysql_station drop if exists partition(dt='${date}');
     alter table ods_mysql_station add if not exists partition(dt='${date}')
     location '${target_path}';"


echo " executing  ...  "
echo " ==>   [ ${hql} ]  "
${target_user} ${HIVE_PATH} -e "${hql}"



echo "    "
echo "===================   Completed Loading ...  ==================="
echo "    "
echo "========== [ ods_mysql_station ] Completed Loading ... =========="
echo "    "


