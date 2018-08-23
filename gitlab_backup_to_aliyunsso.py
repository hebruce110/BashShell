# -*- coding: utf-8 -*-

from __future__ import print_function

import logging
import oss2
import os, sys
import time

auth = oss2.Auth('xxxxxx', 'xxxxxxxxxxxxxxxx')
endpoint = 'oss-cn-shenzhen-internal.aliyuncs.com'                                 
service = oss2.Service(auth, endpoint)
bucketName = 'xxxx'                                                                


os.system('rm -rf /var/opt/gitlab/backups/*')
os.system('/opt/gitlab/bin/gitlab-rake gitlab:backup:create')

def file_name(file_dir):   
    L=[]   
    for root, dirs, files in os.walk(file_dir):  
        for file in files:  
            if os.path.splitext(file)[1] == '.tar':  
                L.append(os.path.join(root, file))  
    return L

gitlabBkFiles = file_name('/var/opt/gitlab/backups/')

gitlabBkFilePath = gitlabBkFiles[0]

print (gitlabBkFilePath)

toDayDate = time.strftime('%Y%m%d',time.localtime(time.time()))
gitlabCodeFileName = 'gitlab_backup_'+toDayDate+'.tar'

logging.basicConfig(filename='/usr/local/src/shell/log/gitlab_code_to_oss'+toDayDate+'.log', level=logging.INFO)
logging.info(endpoint)

bucket = oss2.Bucket(auth, endpoint, bucketName)

def percentage(consumed_bytes, total_bytes):
    if total_bytes:
        rate = int(100 * (float(consumed_bytes) / float(total_bytes)))
        print('\rAre uploading:{0}%'.format(rate), end='')

        sys.stdout.flush()

ossGitlabCodeFilePath = 'gitlabCode/'+gitlabCodeFileName
print(ossGitlabCodeFilePath)

oss2.resumable_upload(bucket,
        ossGitlabCodeFilePath,
        gitlabBkFilePath,
        store=oss2.ResumableStore(root='/tmp'),
        multipart_threshold=100*1024,
        part_size=100*1024,
        num_threads=4,
        headers={"Content-Type":"application/octet-stream; charset=utf-8"},
        progress_callback=percentage)

