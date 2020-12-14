#!/usr/bin/env bash


##########################
#传入的日期均+1
#此脚本仅供周维度使用
#因为当天的日志是凌晨拿回来的，所以计算的是昨天的销量，故要加1天
#例如：20200101——20200107这一自然周，数据对应表的日期是20200102-20200108
#参数：6个
#格式:yyyy-MM-dd
#参数必须传
##########################




#上一周开始：' $pre_week_start 
#上一周结束：' $pre_week_end 
#上上周开始：' $bef_pre_week_start 
#上上周结束：' $bef_pre_week_end

if [ x"$1" != x ]; then 
    pre_week_start=`date -d "+1 day $1" +%Y-%m-%d`
fi


if [ x"$2" != x ]; then 
   pre_week_end=`date -d "+1 day $2" +%Y-%m-%d`
fi


if [ x"$3" != x ]; then 
   bef_pre_week_start=`date -d "+1 day $3" +%Y-%m-%d`
fi


if [ x"$4" != x ]; then 
   bef_pre_week_end=`date -d "+1 day $4" +%Y-%m-%d`
fi



if [ x"$5" != x ]; then
   monday=`date -d "+1 day $5" +%Y-%m-%d`
fi


if [ x"$6" != x ]; then
   sunday=`date -d "+1 day $6" +%Y-%m-%d`
fi


#pre_week_start=`date -d "+1 day $1" +%Y-%m-%d`
#pre_week_end=`date -d "+1 day $2" +%Y-%m-%d`
#bef_pre_week_start=`date -d "+1 day $3" +%Y-%m-%d`
#bef_pre_week_end=`date -d "+1 day $4" +%Y-%m-%d`

echo '上一周+1开始：' $pre_week_start 
echo '上一周+1结束：' $pre_week_end 
echo '上上周+1开始(部分脚本用不到可不传)：' $bef_pre_week_start 
echo '上上周+1结束(部分脚本用不到可不传)：' $bef_pre_week_end
echo '去年同周+1开始(部分脚本用不到可不传)：' $monday
echo '去年同周+1结束(部分脚本用不到可不传)：' $sunday


