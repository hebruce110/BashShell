# -*- coding: utf-8 -*-

from __future__ import print_function

import logging
import oss2
import os, sys
import time

auth = oss2.Auth('xxxxx', 'xxxxxxxxxxxxxxxxxxxx') #设置账号key
endpoint = 'oss-cn-shenzhen-internal.aliyuncs.com'					#设置桶域名
service = oss2.Service(auth, endpoint)
bucketName = 'patpatredmine'									#设置上传到那个bucket

toDayDate = time.strftime('%Y%m%d',time.localtime(time.time()))
sqlFileName = 'redmine_bk'+toDayDate+'.sql'
sqlFilePath = '/usr/local/doc/redmine_bk/mysql_bk/'+sqlFileName

logging.basicConfig(filename='/usr/local/src/shell/log/redmine_sql_to_oss'+toDayDate+'.log', level=logging.INFO)
logging.debug('debug message')
logging.info(endpoint)

sqldumpCMD = 'mysqldump -uredmine -pxxxxxxxxx redmine >'+sqlFilePath
val = os.system(sqldumpCMD)

if val!=0:
	print('Backup SQL failure!')
	logging.error('Backup SQL failure!')
else:
	print('Backup SQL success!')
	logging.critical('Uploaded to oss success^_^')

bucket = oss2.Bucket(auth, endpoint, bucketName) #获取桶

def percentage(consumed_bytes, total_bytes):
    if total_bytes:
        rate = int(100 * (float(consumed_bytes) / float(total_bytes)))
        print('\rAre uploading:{0}%'.format(rate), end='')

        sys.stdout.flush()

#currentTime = time.strftime('%Y-%m-%d_%H:%M_timestamp:%s',time.localtime(time.time()))
#fileName = currentTime+'.sql'     #拼接后缀 
#fileName = 'redmine_bk'+fileName     #拼接前缀
#fileName = 'sql/'+fileName
ossSqlFilePath = 'sql/'+sqlFileName
print(ossSqlFilePath)

oss2.resumable_upload(bucket,
			ossSqlFilePath,
			sqlFilePath,
			store=oss2.ResumableStore(root='/tmp'),
			multipart_threshold=100*1024,
			part_size=100*1024,
			num_threads=4,
			headers={"Content-Type":"application/octet-stream; charset=utf-8"},
			progress_callback=percentage) 
