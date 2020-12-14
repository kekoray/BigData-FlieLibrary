#!/usr/bin/env bash


#仅供周维度使用
#计算传入日期的去年同期周数的起止日期
#参数：1个
#格式 yyyy-MM-dd

if [ $# -lt 1 ];then
 DT=$(date +%Y-%m-%d -d -0day)
else
 DT=$1
echo '传入的日期：' $DT
fi
curdate=$DT




# 给一个日期参数算周一
first_day_of_week(){
  b_diff=$((`date -d "${1}" +%u`-1))
  echo `date -d "${1} -${b_diff}days" "+%Y-%m-%d"`
}

# 算年周
yyyyww(){
  ww=`date -d "${1}" "+%V"`
  if [[ $((10#$ww)) -ge $((10#52)) ]]; then
    #statements
    yyyy=`date -d "${1} -7days" "+%Y"`
    yyyy_ww=${yyyy}${ww}
  elif [[ $((10#$ww)) -eq $((10#01)) ]]; then
      #statements
      yyyy=`date -d "${1} +7days" "+%Y"`
      yyyy_ww=${yyyy}${ww}
      else
        yyyy=`date -d "${1}" "+%Y"`
        yyyy_ww=${yyyy}${ww}
  fi
  echo $yyyy_ww
}

  # 所在年周
  yyyy_ww=`yyyyww ${1}`

# 所在年的第一天
  DT=${yyyy_ww:0:4}-01-01
  # 所在周的第一天
  fst_wk_d=`first_day_of_week ${1}`

  #echo 'fst_wk_d------' $fst_wk_d

if [[ `date -d "${DT}" "+%V"` == 01 ]]; then
    # 如果1月1号是第1周则上周周数就是上一年的周数
    week_nums=`date -d "${DT} -7day" "+%V"`
  else
    # 否则1月1号的周数就是上一年的周数
    week_nums=`date -d "${DT}" "+%V"`
  fi
  # 根据去年周数算和去年同期日期相隔的天数
  datediff=$(($week_nums*7))
  # 算同期周日期
  tb_date=`date -d "${1} -${datediff}day" "+%Y-%m-%d"`
  echo '去年同期日期tb：' $tb_date




v=`date -d "${1}" "+%V"`
echo '当前周数——' $v
past_week=`date -d "${tb_date}" "+%V"`
monday=`first_day_of_week ${tb_date}`
cur_year=`date -d "${DT}" "+%Y"`
 
#判断不相等的周次
#if [[ $v == $past_week ]];then
#echo '周次相等的====='
#else
#echo '不相等'
#past_week=`date -d "${monday} -7day" "+%V"`
#echo '最新周' $past_week
#monday=`date -d "${monday} -7day" "+%Y-%m-%d"`
#echo '最新日期=='$monday
#fi



echo '去年周数——'$past_week 
timest=$cur_year$v
echo '账期：'$timest
echo '去年同周开始日期(周一)：'$monday
sunday=`date -d "+6 day $monday" +%Y-%m-%d`

echo '去年同周结束日期(周日)：'$sunday



