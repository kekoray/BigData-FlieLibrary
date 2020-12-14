#!/usr/bin/env bash

#MR程序需要用hadoop用户执行,且命令的路径都是指向hdfs上


#--------------  切换用户  --------------#
if [ `whoami` = "hadoop" ];then
    echo "hadoop user..."
    target_user=''
else
    echo "The user is not hadoop ！"
    target_user="su hadoop"
fi
#---------------------------------------#


${target_user} 
/usr/local/service/hadoop/bin/hadoop jar /usr/local/service/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.5.jar wordcount /user/hadoop/azkaban_test/wordcount/input  /user/hadoop/azkaban_test/wordcount/output

echo "======================  mr over  ============================= "


