#!/bin/sh
 
# Copyright (c) 2010 codingstandards. All rights reserved.
# file: datetime.sh
# description: Bash中关于日期时间操作的常用自定义函数
# license: LGPL
# author: codingstandards
# email: codingstandards@gmail.com
# version: 1.0
# date: 2010.02.27
 
# usage: yesterday
# 昨天
# 比如今天是2010年2月27日，那么结果就是2010-02-26
yesterday()
{
    date --date='1 day ago' +%Y-%m-%d
}
 
# usage: today
# 今天
# 比如今天是2010年2月27日，那么结果就是2010-02-27
today()
{
    date +%Y-%m-%d
}
 
# usage: now
# 现在，包括日期和时间、纳秒
# 比如：2010-02-27 11:29:52.991774000
now()
{
    date "+%Y-%m-%d %H:%M:%S.%N"
}
 
# usage: curtime
# 当前时间，包括日期和时间
# 比如：2010-02-27 11:51:04
curtime()
{
    date '+%Y-%m-%d %H:%M:%S'
    # 也可写成：date '+%F %T'
}
 
# usage: last_month
# 取上个月的年月
# 比如：2010-01
last_month()
{
    date --date='1 month ago' '+%Y-%m'
}
 
# usage: last_month_packed
# 取上个月的年月
# 比如：201001
last_month_packed()
{
    date --date='1 month ago' '+%Y%m'
}
 
# usage: first_date_of_last_month
# 取上个月的第一天
# 比如本月是2010年2月，那么结果就是2010-01-01
first_date_of_last_month()
{
    date --date='1 month ago' '+%Y-%m-01'
}
 
# usage: last_date_of_last_month
# 取上个月的最后一天
# 比如当前是2010年2月，那么结果就是2010-01-31
last_date_of_last_month()
{
    date --date="$(date +%e) days ago" '+%Y-%m-%d'
}
 
# usage: day_of_week
# 今天的星期
# day of week (0..6);  0 represents Sunday
day_of_week()
{
    date +%w
}
 
# usage: last_hour
# 上个小时
# 比如：2010-02-27-10
# 适合处理log4j生成的日志文件名
last_hour()
{
    date --date='1 hour ago' +%Y-%m-%d-%H
}
 
# usage: the_hour
# 当前的小时，为方便算术比较，结果不以0开头
# 比如：12
the_hour()
{
    #date +%H   # hour (00..23)
    date +%k    # hour ( 0..23)
}
 
# usage: the_minute
# 当前的分钟，为方便算术比较，结果不以0开头
# 比如：
the_minute()
{
    MM=$(date +%M)  # minute (00..59)
    echo $[1$MM-100]
}
 
# usage: the_second
# 当前的秒数
# 比如：
the_second()
{
    SS=$(date +%S)  # second (00..60); the 60 is necessary to accommodate a leap  second
    echo $[1$SS-100]
}
 
# usage: the_year
# 当前的年份 year (1970...)
# 比如：2010
the_year()
{
    date +%Y
}
 
# usage: the_month
# 当前的月份，为方便算术比较，结果不以0开头
# 比如：2
the_month()
{
    M=$(date +%m) # month (01..12)
    echo $[1$M-100]
}
 
# usage: the_date
# 当前的日期，为方便算术比较，结果不以0开头
# 比如：27
the_date()
{
    date +%e    # day of month, blank padded ( 1..31)
}
 
# usage: days_ago
# 取n天前的日期
# 比如：days_ago 0就是今天，days_ago 1就是昨天，days_ago 2就是前天，days_ago -1就是明天
# 格式：2010-02-27
days_ago()
{
    date --date="$1 days ago" +%Y-%m-%d
}
 
# usage: chinese_date_and_week()
# 打印中文的日期和星期
# 比如：2月27日 星期六
chinese_date_and_week()
{
    WEEKDAYS=(星期日 星期一 星期二 星期三 星期四 星期五 星期六)
    WEEKDAY=$(date +%w)
    #DT="$(date +%Y年%m月%d日) ${WEEKDAYS[$WEEKDAY]}"
    MN=1$(date +%m)
    MN=$[MN-100]
    DN=1$(date +%d)
    DN=$[DN-100]
    DT="$MN月$DN日 ${WEEKDAYS[$WEEKDAY]}"
    echo "$DT"
}
 
# usage: rand_digit
# 随机数字，0-9
rand_digit()
{
    S="$(date +%N)"
    echo "${S:5:1}"
}
 
# usage: seconds_of_date [ [<time>]]
# 获取指定日期的秒数（自1970年）
# 比如：seconds_of_date "2010-02-27" 返回 1267200000
seconds_of_date()
{
 if [ "$1" ]; then
 date -d "$1 $2" +%s
 else
 date +%s
 fi
}
 
# usage: date_of_seconds
# 根据秒数（自1970年）得到日期
# 比如：date_of_seconds 1267200000 返回 2010-02-27
date_of_seconds()
{
 date -d "1970-01-01 UTC $1 seconds" "+%Y-%m-%d"
}
 
# usage: datetime_of_seconds
# 根据秒数（自1970年）得到日期时间
# 比如：datetime_of_seconds 1267257201 返回 2010-02-27 15:53:21
datetime_of_seconds()
{
 date -d "1970-01-01 UTC $1 seconds" "+%Y-%m-%d %H:%M:%S"
}
 
# usage: leap_year
# 判断是否闰年
# 如果yyyy是闰年，退出码为0；否则非0
# 典型示例如下：
# if leap_year 2010; then
# echo "2010 is leap year";
# fi
# if leap_year 2008; then
# echo "2008 is leap year";
# fi
# 摘自脚本：datetime_util.sh (2007.06.11)
# 注：这个脚本来自网络，略有修改（原脚本从标准输入获取年份，现改成通过参数指定）
# Shell program to read any year and find whether leap year or not
# -----------------------------------------------
# Copyright (c) 2005 nixCraft project
# This script is licensed under GNU GPL version 2.0 or above
# -------------------------------------------------------------------------
# This script is part of nixCraft shell script collection (NSSC)
# Visit http://bash.cyberciti.biz/ for more information.
# -------------------------------------------------------------------------
leap_year()
{
 # store year
 yy=$1
 isleap="false"
 
 #echo -n "Enter year (yyyy) : "
 #read yy
 
 # find out if it is a leap year or not
 
 if [ $((yy % 4)) -ne 0 ] ; then
 : # not a leap year : means do nothing and use old value of isleap
 elif [ $((yy % 400)) -eq 0 ] ; then
 # yes, it's a leap year
 isleap="true"
 elif [ $((yy % 100)) -eq 0 ] ; then
 : # not a leap year do nothing and use old value of isleap
 else
 # it is a leap year
 isleap="true"
 fi
 #echo $isleap
 if [ "$isleap" == "true" ]; then
 # echo "$yy is leap year"
 return 0
 else
 # echo "$yy is NOT leap year"
 return 1
 fi
}
 
# usage: validity_of_date<dd># 判断yyyy-mm-dd是否合法的日期
# 如果是，退出码为0；否则非0
# 典型示例如下：
# if validity_of_date 2007 02 03; then
# echo "2007 02 03 is valid date"
# fi
# if validity_of_date 2007 02 28; then
# echo "2007 02 28 is valid date"
# fi
# if validity_of_date 2007 02 29; then
# echo "2007 02 29 is valid date"
# fi
# if validity_of_date 2007 03 00; then
# echo "2007 03 00 is valid date"
# fi
# 摘自脚本：datetime_util.sh (2007.06.11)
# 注：这个脚本来自网络，略有修改（原脚本从标准输入获取年月日，现改成通过参数指定）
# Shell program to find the validity of a given date
# -----------------------------------------------
# Copyright (c) 2005 nixCraft project
# This script is licensed under GNU GPL version 2.0 or above
# -------------------------------------------------------------------------
# This script is part of nixCraft shell script collection (NSSC)
# Visit http://bash.cyberciti.biz/ for more information.
# -------------------------------------------------------------------------
validity_of_date()
{
 # store day, month and year
 yy=$1
 mm=$2
 dd=$3
 
 # store number of days in a month
 days=0
 
 # get day, month and year
 #echo -n "Enter day (dd) : "
 #read dd
 
 #echo -n "Enter month (mm) : "
 #read mm
 
 #echo -n "Enter year (yyyy) : "
 #read yy
 
 # if month is negative ( # then it is invalid month
 if [ $mm -le 0 -o $mm -gt 12 ]; then
 #echo "$mm is invalid month."
 return 1
 fi
 
 # Find out number of days in given month
 case $mm in
 1) days=31;;
 01) days=31;;
 2) days=28 ;;
 02) days=28 ;;
 3) days=31 ;;
 03) days=31 ;;
 4) days=30 ;;
 04) days=30 ;;
 5) days=31 ;;
 05) days=31 ;;
 6) days=30 ;;
 06) days=30 ;;
 7) days=31 ;;
 07) days=31 ;;
 8) days=31 ;;
 08) days=31 ;;
 9) days=30 ;;
 09) days=30 ;;
 10) days=31 ;;
 11) days=30 ;;
 12) days=31 ;;
 *) days=-1;;
 esac
 
 # find out if it is a leap year or not
 
 if [ $mm -eq 2 ]; then # if it is feb month then only check of leap year
 if [ $((yy % 4)) -ne 0 ] ; then
 : # not a leap year : means do nothing and use old value of days
 elif [ $((yy % 400)) -eq 0 ] ; then
 # yes, it's a leap year
 days=29
 elif [ $((yy % 100)) -eq 0 ] ; then
 : # not a leap year do nothing and use old value of days
 else
 # it is a leap year
 days=29
 fi
 fi
 
 #echo $days
 
 # if day is negative ( # that months days then day is invaild
 if [ $dd -le 0 -o $dd -gt $days ]; then
 #echo "$dd day is invalid"
 return 3
 fi
 
 # if no error that means date dd/mm/yyyy is valid one
 #echo "$dd/$mm/$yy is a vaild date"
 #echo "$yy-$mm-$dd is a valid date"
 #echo "valid"
 return 0
}
 
# usage: days_of_month
# 获取yyyy年mm月的天数，注意参数顺序
# 比如：days_of_month 2 2007 结果是28
days_of_month()
{
 # store day, month and year
 mm=$1
 yy=$2
 
 # store number of days in a month
 days=0
 
 # get day, month and year
 #echo -n "Enter day (dd) : "
 #read dd
 
 #echo -n "Enter month (mm) : "
 #read mm
 
 #echo -n "Enter year (yyyy) : "
 #read yy
 
 # if month is negative ( # then it is invalid month
 if [ $mm -le 0 -o $mm -gt 12 ]; then
 #echo "$mm is invalid month."
 echo -1
 return 1
 fi
 
 # Find out number of days in given month
 case $mm in
 1) days=31;;
 01) days=31;;
 2) days=28 ;;
 02) days=28 ;;
 3) days=31 ;;
 03) days=31 ;;
 4) days=30 ;;
 04) days=30 ;;
 5) days=31 ;;
 05) days=31 ;;
 6) days=30 ;;
 06) days=30 ;;
 7) days=31 ;;
 07) days=31 ;;
 8　) days=31 ;;#防止博客表情化，多加了一个空格
 08) days=31 ;;
 9) days=30 ;;
 09) days=30 ;;
 10) days=31 ;;
 11) days=30 ;;
 12) days=31 ;;
 *) days=-1;;
 esac
 
 # find out if it is a leap year or not
 
 if [ $mm -eq 2 ]; then # if it is feb month then only check of leap year
 if [ $((yy % 4)) -ne 0 ] ; then
 : # not a leap year : means do nothing and use old value of days
 elif [ $((yy % 400)) -eq 0 ] ; then
 # yes, it's a leap year
 days=29
 elif [ $((yy % 100)) -eq 0 ] ; then
 : # not a leap year do nothing and use old value of days
 else
 # it is a leap year
 days=29
 fi
 fi
 
 echo $days
}