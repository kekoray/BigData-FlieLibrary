#!/usr/bin/env bash

#==============================================================
#   Description :  函数脚本
#   FileName :  function_shopee.sh
#   Version  :  2.1
#   Author   :  Koray
#   Date     :  2020-11-12
#   Company  :  menglar
#   Precautions:
#         1.所有脚本的行尾序列必须是LF. 
#         2.mysql必须开启local_infile功能.才能使用sqoop导入数据. 
#==============================================================


#各组件的本地路径
HIVE_PATH=/usr/local/service/hive/bin/hive
HADOOP_PATH=/usr/local/service/hadoop/bin/hadoop
SQOOP_PATH=/usr/local/service/sqoop/bin/sqoop


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







#数据库连接 
MYSQL="time mysql  -h${MYSQL_IP} -P${MYSQL_PORT} -u${MYSQL_USER} -p${MYSQL_PWD} -D${MYSQL_DB} -N -e"



#MySQL sql的执行函数
function ExecuteMysql(){
    sql=$1
    ${target_user} $MYSQL "$sql"
    echo "completed ... [ $sql ]"
}



#Hive sql的执行函数
function ExecuteHQL(){
    hql=$1
    ${target_user} ${HIVE_PATH} -e "$hql"
    echo "completed ... [ $hql ]"
}







#========================== Sqoop-Export-Direct =======================================================
#mysql需要开启local_infile的参数.才能使用sqoop批量导入数据.



#缓存文件地址
data_dir='cosn://emr-1254463213/bigdata_export/'


echo "-------------------  正在执行Sqoop-Export-Direct任务  ----------------------------"


#直接direct方式入库
function SqoopDirectExportToMySQLByHQL(){
hive_db=$1
sql=$2
dir_dt=$3
mysql_table=$4

if [[ $1 == "" || $2 == "" || $3 == "" || $4 == "" ]];then
        echo "parameters are all required"
    exit
fi

echo "use ${hive_db};" "${sql}"
echo "数据路径：${data_dir}${hive_db}/${mysql_table}/${dir_dt}"

CreateFileStaData "${hive_db}" "${sql}" "${dir_dt}" "${mysql_table}"
StartInsertMysqlByDirect "${mysql_table}" "${dir_dt}" "${hive_db}"
RemoveCosnTmpFile "${mysql_table}" "${dir_dt}" "${hive_db}"
}



#--------------------------  子函数 --------------------------------------------------


#hive表导出的临时文件
function CreateFileStaData(){
  hive_db=$1
  sql=$2
  dir_dt=$3
  mysql_table=$4
  
  echo '----正在生成数据文件-----'
  if [[ $1 == "" || $2 == "" || $3 == "" || $4 == "" ]];then
          echo "parameters are all required"
      exit
  fi
  
  #echo "use ${hive_db};" "${sql}"
  #echo "数据路径：${data_dir}${hive_db}/${mysql_table}/${dir_dt}"
  
  ${target_user} ${HIVE_PATH} -e "use ${hive_db};
        set io.sort.mb=10; 
        set hive.auto.convert.join=false;
        set hive.ignore.mapjoin.hint=false;
        set hive.map.aggr=true; 
        set hive.groupby.skewindata=false;
        INSERT OVERWRITE DIRECTORY '${data_dir}${hive_db}/${mysql_table}/${dir_dt}'
        row format delimited
        fields terminated by '\001'
        lines terminated by '\n'
        ${sql};"
  
}



#清理导出的临时文件
function RemoveCosnTmpFile(){
  current_date=$(date "+%Y-%m-%d %H:%M:%S")
  echo '---当前日期是---' $current_date
  
  mysql_table=$1
  dir_dt=$2
  hive_db=$3
  
  echo '----正在执行临时数据清理任务-----'
  if [[ $1 == "" || $2 == "" || $3 == "" ]];then
          echo "parameters are all required"
      exit
  fi
  
  #判断文件存在
  COSN_TMP_DIR=${data_dir}${hive_db}/${mysql_table}/${dir_dt}
  ${target_user} $HADOOP_PATH fs -test -e  ${COSN_TMP_DIR}
  
  if [ $? -eq 0 ]; then
  
  echo "Directory is exists!  ${COSN_TMP_DIR}" 
  echo "---正在删除cos临时数据路径是-----" ${COSN_TMP_DIR}
  
  ${target_user} ${HADOOP_PATH} fs -rm -r ${COSN_TMP_DIR}
  echo " --------成功删除cosn临时数据-----------"
  fi
}




#sqoop--direct模式插入
function StartInsertMysqlByDirect(){
  mysql_table=$1
  dir_dt=$2
  hive_db=$3
  
  echo '----正在执行direct模式插入任务-----'
  if [[ $1 == "" || $2 == "" || $3 == "" ]];then
          echo "parameters are all required"
      exit
  fi
  
  echo "即将插入的库表：${MYSQL_IP}  --库--   ${MYSQL_DB} --表---  ${mysql_table} "
  echo "数据路径：${data_dir}${hive_db}/${mysql_table}/${dir_dt}"
  
  ${target_user} ${SQOOP_PATH}  export \
  --connect jdbc:mysql://${MYSQL_IP}:${MYSQL_PORT}/${MYSQL_DB}?useUnicode=true&characterEncoding=utf-8 \
  --username ${MYSQL_USER} \
  --password ${MYSQL_PWD} \
  --table ${mysql_table} \
  --fields-terminated-by '\001' \
  --lines-terminated-by '\n' \
  --export-dir ${data_dir}${hive_db}/${mysql_table}/${dir_dt} \
  --direct 
}


