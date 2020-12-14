#!/usr/bin/env bash


#########################################################
# Description :有关mysql知虾支付记录表----同步到hive本地
# Script   :sync_shopee_pd_order.sh
# Version  :1.0
# Date     :2020-11-10
# Author   :koray
# Company  :menglar
#########################################################

HIVE_PATH=/usr/local/service/hive/bin/hive
HADOOP_PATH=/usr/local/service/hadoop/bin/hadoop
SQOOP_PATH=/usr/local/service/sqoop/bin/sqoop



#mysql连接信息 -- mengla_product
MYSQL_IP="10.168.0.12"   
MYSQL_PORT="3306"                              
MYSQL_USER="crm_dev"                            
MYSQL_PWD="EPvFqqcIUQCFzxuT"                    
MYSQL_DB="mengla_product" 



#----------------切换用户----------------#
if [ `whoami` = "hadoop" ];then
        echo "hadoop user"
        target_user=''
else
        echo "The user is not hadoop ！"
        target_user="sudo -u hadoop"
fi
#---------------------------------------#




if [ $# -lt 1 ];then
 date=$(date -d -0day +%Y-%m-%d)
else
 DT=$1
 date=`date -d "-0 day $DT" +%Y-%m-%d`
fi


echo " == 分区时间字段:  ${date}  == "



#####################################################################################
#========================  sqoop方式MySQL导入hive  ================================== 



#云存储地址（cosn）
COSN_MALL_GOODS_TEMP_PATH=cosn://emr-1254463213/shopee_dw/operations_center/sync_shopee_pd_order/
MALL_GOODS_TEMP_LOG_PATH=${COSN_MALL_GOODS_TEMP_PATH}${date}/


echo " Hive Data Warehouse Path 
       ==>   [ ${MALL_GOODS_TEMP_LOG_PATH} ]   "
echo "    "



echo "===================   Executing Sqoop--Import--Direct Mode Task   ==================="
echo "    "

#Sqoop--Import--Direct模式
#注:  --query对应的sql语句,要用""双引号括起整体,且要有where \$CONDITIONS
#     里面属性用''分号括起,不能传参,不能有`飘号,可分多行写.
${target_user}  ${SQOOP_PATH}  import \
  --connect jdbc:mysql://${MYSQL_IP}:${MYSQL_PORT}/${MYSQL_DB} \
  --username ${MYSQL_USER} \
  --password ${MYSQL_PWD} \
  --fields-terminated-by '\t' \
  --lines-terminated-by '\n' \
  --delete-target-dir \
  --target-dir  ${MALL_GOODS_TEMP_LOG_PATH} \
  --direct --m 1 \
  --query "select
           ID
           ,ORDER_NO
           ,USER_ID
           ,CHARGE_ID
           ,PRODUCT_ID
           ,PRODUCT_ITEM_ID
           ,AMOUNT
           ,PRICE
           ,DISCOUNT
           ,DISCOUNT_PRICE
           ,DISCOUNT_CODE_ID
           ,PAY_MODE
           ,PAY_TIME
           ,MATURITY_TIME
           ,ONLINE_PAY_TYPE
           ,OFFLINE_PAY_TYPE
           ,ORDER_STATUS
           ,GATEWAY_CODE
           ,GATEWAY_CALLBACK_TIME
           ,RAM_CODE
           ,RAM_CALL_TIME
           ,CREATE_TIME
           ,OPERATOR
           ,REMARK
           ,tenant_id
           from
           pd_order 
           where
           date_format(create_time,'%Y-%m-%d')<'$date' and \$CONDITIONS"



echo "    "
echo "===================   The Sqoop--Import--Direct Task Has Been completed ...    ==================="
echo "    "
echo "    "
echo "===================   Data Loading Of Hive Data Warehouse  ==================="
echo "    "


hql="use shopee_operations;
alter table sync_shopee_pd_order drop if exists partition(dt='$date');
alter table sync_shopee_pd_order add if not exists partition(dt='$date')
location '${MALL_GOODS_TEMP_LOG_PATH}';"

echo " executing  ......  "
echo " ==>   [ ${hql} ]  "
${target_user} ${HIVE_PATH} -e "${hql}"


echo "    "
echo "===================   Completed Loading ...  ==================="
echo "    "



 
