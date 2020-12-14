#!/usr/bin/env bash

#==============================================================
#   Description :   sqoop-query模式的导出脚本
#   FileName :   
#   Version  :  2.0
#   Author   :  Koray
#   Date     :  2020-11-11
#   Company  :  menglar
#==============================================================



#=================  函数的加载  ================================

source ./function_lazada.sh

#==============================================================




#=================  配置信息  ================================

#各组件的本地路径
SQOOP_PATH=/usr/local/service/sqoop/bin/sqoop
HIVE_PATH=/usr/local/service/hive/bin/hive


#mysql的配置信息
MYSQL_IP="XX"       
MYSQL_PORT="XX"                                 
MYSQL_USER="XX"                            
MYSQL_PWD="XX"                       
MYSQL_DB="XX"  

#==============================================================




#----------------切换用户----------------#
if [ `whoami` = "hadoop" ];then
        echo "hadoop user"
        target_user=''
else
        echo "The user is not hadoop ！"
        target_user="sudo -u hadoop"
fi
#---------------------------------------#




#####################################################################################


if [ $# -lt 1 ];then
 date=$(date -d -0day +%Y-%m-%d)
else
 DT=$1
 date=`date -d "-0 day $DT" +%Y-%m-%d`
fi


echo " ===== 分区时间字段:  ${date}  ===== "
echo "    "





#========================== Sqoop-Import-Query ======================================

#根据指定的sql查询mysql表,将查询结果导入到hive中
#注:  --query对应的sql语句,要用""双引号括起整体,且要有where \$CONDITIONS    ---(单引号在调度环境下会没有数据)
#     里面属性用''分号括起,不能传参,不能有`飘号,可分多行写.  



#云存储地址（cosn）
COSN_表名_PATH=cosn://emr-1254463213/....
表名_PATH=${COSN_表名_PATH}${date}/

echo " Hive Data Warehouse Path 
       ==>   [ ${表名_PATH} ]   "
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
  --target-dir  ${表名_PATH} \
  --direct --m 1 \
  --query "select
           *
           from
           mysql-表名 
           where
           条件
           and \$CONDITIONS"



echo "    "
echo "===================   The Sqoop--Import--Direct Task Has Been completed ...    ==================="
echo "    "
echo "    "
echo "===================   Data Loading Of Hive Data Warehouse  ==================="
echo "    "



hql="use 库;
alter table 表 drop if exists partition(dt='$date');
alter table 表 add if not exists partition(dt='$date')
location '${表名_PATH}';"


echo " executing  ......  "
echo " ==>   [ ${hql} ]  "
${target_user} ${HIVE_PATH} -e "${hql}"



echo "    "
echo "===================   Completed Loading ...  ==================="
echo "    "




















################################  函数版本-不可用  #####################################################



function SqoopDirectImportToHiveBySQL(){
  #mysql_table=$1
  mysql_sql=$1
  hive_db=$2
  hive_table=$3
  cos_path=$4
  dir_dt=$5
  
  
  #导出的路径
  target_path=${cos_path}${dir_dt}
  
  
  echo "===================   Executing Sqoop--Import--Direct Mode Task   ==================="
  echo "    "
  
  
  if [[ $1 == "" || $2 == "" || $3 == "" || $4 == "" || $5 == ""  ]];then
          echo "-----  parameters are all required  -----"
      exit
  fi
  
  
  echo " Data Loading Of Hive Data Warehouse  ......
         ==>   [ Database : ${hive_db} ]    
         ==>   [ Table : ${hive_table} ]  "
  echo "    "

  echo " Hive Data Warehouse Path 
         ==>   [ ${target_path} ]   "
  echo "    "
  
  
 
#注:  --query对应的sql语句,要用""双引号括起整体,且要有where \$CONDITIONS
#     里面属性用''分号括起,不能传参,不能有`飘号,可分多行写.
 ${target_user} ${SQOOP_PATH}  import \
  --connect jdbc:mysql://${MYSQL_IP}:${MYSQL_PORT}/${MYSQL_DB} \
  --username ${MYSQL_USER} \
  --password ${MYSQL_PWD} \
  --fields-terminated-by '\t' \
  --lines-terminated-by '\n' \
  --delete-target-dir \
  --target-dir  ${target_path} \
  --direct --m 1 \
  --query  "SELECT * 
        FROM lz_site_info  
        where site_name_en = 'Vielnam' and  \$CONDITIONS"  
  




  echo "===================   Data Loading Of Hive  ==================="
  echo "    "
  
#================== 映射hive表 ==========================================

  #hive表加载数据
  hql="use ${hive_db};
       alter table ${hive_table} drop if exists partition(dt='${dir_dt}');
       alter table ${hive_table} add if not exists partition(dt='${dir_dt}')
       location '${target_path}';"
   
   ExecuteHQL "${hql}"
   
   
   echo "===================   The Sqoop--Import--Direct Task Has Been completed ...    ==================="
   echo "    "
   
}