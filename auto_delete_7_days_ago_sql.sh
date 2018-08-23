#!/bin/sh
files=`find /usr/local/doc/db-dbackup/ -mtime +7 -name "*.sql"`
find /usr/local/doc/db-dbackup/ -mtime +7 -name "*.sql" -exec rm -rf {} \;

date_Y_M_D_W_T()
{
    WEEKDAYS=(星期日 星期一 星期二 星期三 星期四 星期五 星期六)
    WEEKDAY=$(date +%w)
    DT="$(date +%Y年%m月%d日) ${WEEKDAYS[$WEEKDAY]} $(date "+%H:%M:%S")"
    echo "$DT"
}

echo "auto delete fiels $files at $(date_Y_M_D_W_T)"