#! bin/bash
#Author:Bruce http://www.heyuan110.com
#Update Date:2015.06.23

 echo "开始编译打包相关操作"
echo "编译中..."
 path=~/work/projectname/
 cd $path
 msg1=`cat README`
 export LANG=zh_CN.GB2312
 logDir=~/xcodebuild/logs/
 mkdir -pv $logDir
 sh $path/build.sh >> $logDir/bdpd_$(date +"%Y%m%d%H%M%S").log
 echo "操作完成"
echo "正在发送邮件通知相关人员..."
######################################发送邮件通知测试人员############################################################
date_Y_M_D_W_T()
{
DT="$(date +%Y-%m-%d) $(date "+%H:%M:%S")"
echo "$DT"
}
export LC_ALL=zh_CN.GB2312; #需要加上，否则邮件里msg为空
cd ~/xcodebuild/sendemail
msg2=`cat update.txt`
msg=${msg1}${msg2}
toEmailAddressFile="toEmailAddress" #要发送的人
toEmails=`cat $toEmailAddressFile | tr -d "\r" | tr -s "\n\r" ","`
python sendmail.py -t $toEmails -s "Test App Update" -m "$msg GMT+8 $(date_Y_M_D_W_T)"
echo "\n邮件已成功送达至\n$(cat $toEmailAddressFile)"


