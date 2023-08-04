#!/bin/bash
#
# Gravuty에 Fail 리스트가 있으면 vn-m-04_core-api_1 컨테이너를 재시작 하고 Fail건은 valid상태로 업데이트.
# /home/vuno/init/log 폴더가 있어야 하고 log 폴더에 log파일이 남습니다.
# Select 구문과 Update 구문은 사이트에 맞게 수정해서 사용하세요.

Today=$(date +%Y%m%d)
Now=$(date +%T)
Logdir=/home/vuno/init/log
Logfile=${Logdir}/watcher_${Today}.log

Select="select count(*) from request_object where status_id='8' and created_at > now()+'9 hour' - interval '30 minute' and number_of_images < 600;"
Update="update request_object set status_id='3' where status_id='8' and created_at > now()+'9 hour' - interval '30 minute' and number_of_images < 600;"

#Select="select count(*) from request_object where status_id='8' and created_at > current_date - 1;"
#Update="update request_object set status_id='3' where status_id='8' and created_at > current_date - 1;"

if [[ ! -e ${Logfile} ]]; then
        touch $Logfile
fi

# Query
rt=$(docker exec -i gravuty_postgres_1 psql -U postgres -d gravuty -a -c "$Select" |grep '  '|tr -d '\r'|tr -d ' ')
#echo $rt

if [[ $rt -gt 0 ]]; then
        echo "$Now : >>>>>>>>>> Service Restart" >> $Logfile
        docker restart `docker ps -aq --filter name=vn-m-04`
        echo -n "$Now : " >> $Logfile
        docker exec -i gravuty_postgres_1 psql -U postgres -d gravuty -a -c "$Update"  |grep 'UPDATE'>> $Logfile
#else
#        echo "$Now : No failure"
fi
