#!/bin/bash
#
# valid 상태인데 reponse 항목에 있으면 status_id 6(finish)로 변경. 한건 씩.
# 
# 
Today=$(date +%Y%m%d)
Now=$(date +%T)
Logdir=/home/vuno/init/log
Logfile=${Logdir}/watcher_${Today}.log


Select="select rq.id from request_object rq, response_object rp where rq.id=rp.request_object_id and rq.status_id='3' and rq.created_at > current_date -1 limit 1;"

if [ ! -e ${Logfile} ]; then
	touch $Logfile
fi

# Query
rt=$(docker exec -it gravuty_postgres_1 psql -U postgres -d gravuty -a -c "$Select" |awk 'NR==4'|tr -d '\r'|tr -d ' ')
#echo $rt

if [ $rt != "(0rows)" ]; then
	Update="update request_object set status_id='6' where id='$rt';"
	echo -n "$Now : " >> $Logfile 
	#echo $Update
	docker exec -it gravuty_postgres_1 psql -U postgres -d gravuty -a -c "$Update"  >> $Logfile 
else
        echo "$Now : 0 Rows"
fi




