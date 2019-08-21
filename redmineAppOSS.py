# -*- coding: utf-8 -*-

from __future__ import print_function

import logging
import oss2
import os, sys
import time

auth = oss2.Auth('xxxxx', 'xxxxxxx') #设置账?~O?key
endpoint = 'oss-cn-shenzhen-internal.aliyuncs.com'                                       #�置桶?~_~_?~P~M
service = oss2.Service(auth, endpoint)
bucketName = 'patpatredmine'                                                                    #设置?~J?| ?~H??~B?个bucket

toDayDate = time.strftime('%Y%m%d',time.localtime(time.time()))
appFileName = 'redmine3.1_'+toDayDate+'.tar'
appFilePath = '/usr/local/doc/redmine_bk/application_bk/'+appFileName
appCpCMD = 'tar -cvf '+appFilePath+' /var/www/redmine'

logging.basicConfig(filename='/usr/local/src/shell/log/redmine_app_to_oss'+toDayDate+'.log', level=logging.INFO)
logging.debug('debug message')
logging.info(endpoint)

print('Is the backup APP...>>:'+appCpCMD)
val = os.system(appCpCMD)
if val!=0:
        print('Backup App failed!')
else:
        print('Backup App success!')


bucket = oss2.Bucket(auth, endpoint, bucketName) #?~N??~O~V桶

def percentage(consumed_bytes, total_bytes):
    if total_bytes:
        rate = int(100 * (float(consumed_bytes) / float(total_bytes)))
        print('\rAre uploading:{0}%'.format(rate), end='')

        sys.stdout.flush()

#currentTime = time.strftime('%Y-%m-%d_%H:%M_timestamp:%s',time.localtime(time.time()))
#fileName = currentTime+'.sql'     #?~K??~N??~P~N?~@ 
#fileName = 'redmine_bk'+fileName     #?~K??~N??~I~M?~@
#fileName = 'sql/'+fileName
ossAppFilePath = 'application/'+appFileName
print(ossAppFilePath)

oss2.resumable_upload(bucket,
        ossAppFilePath,
        appFilePath,
        store=oss2.ResumableStore(root='/tmp'),
        multipart_threshold=100*1024,
        part_size=100*1024,
        num_threads=4,
        headers={"Content-Type":"application/octet-stream; charset=utf-8"},
        progress_callback=percentage)   #?~V??~B?续?| ?~J?| ?~V??~H?~L?~X?示?~[度
