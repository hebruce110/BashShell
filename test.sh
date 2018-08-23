
date_Y_M_D_W_T()
{
    DT="$(date +%Y-%m-%d) $(date "+%H:%M:%S")"
    echo "$DT"
}

#默认
#python sendmail.py

#指定邮件内容和收件方
#python sendmail.py -t 1436032584@qq.com -s "fy" -m "tell me your num" -f "/tmp/病毒文件"

#可以同时发送给多人，用，或；分开
# python sendmail.py -t "1436032584@qq.com,i@heyuan110.com" -s "粉粉社区打包更新啦..." -m "已经更新了哦"

#可以同时发送给多人，用，或；分开
#toEmails="1436032584@qq.com,i@heyuan110.com,heyuan@ffrj.net,yuan@fullteem.com"
toEmails="heyuan@ffrj.net,1436032584@qq.com"


###############生成html下载页面
contentmsg="小\r五义d\n\rdddddd\nddd\ndsdfasdfds\nsdad\n下载地址:http://www.cnblogs.com/xiaowuyi"
echo $contentmsg

python sendmail.py -t $toEmails -s "Test" -m $contentmsg