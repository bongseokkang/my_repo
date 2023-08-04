#!/bin/bash

hname=$(sed -n '/Hostname=/p'  /etc/zabbix/zabbix_agentd.conf)
hname=${hname:9}

Today=$(date +%Y%m%d)
Now=$(date +%T)
Logdir=/home/vuno/init/log
Logfile=${Logdir}/License_info_${Today}.log

Select="select '>>>/'||count(*) from request_object where created_at >= (now() at time zone 'Asia/Seoul')::Date and created_at < (now() at time zone 'Asia/Seoul')::Date+1 and status_id=(select id from status where name='FAILED');"

# Query
rt=$(docker exec -i gravuty_postgres_1 psql -U postgres -d gravuty -a -c "$Select" |grep '>>>/[0-9]'|tr -d '\r'|tr -d ' ')
#echo $rt

fail_count=$(echo $rt | cut -d '/' -f2)

echo "\"$hname\" \"FailCount\" \"$fail_count\"" >$Logdir/fail_count.txt


zabbix_sender -c /etc/zabbix/zabbix_agentd.conf -i /home/vuno/init/log/fail_count.txt

#(crontab -l 2>/dev/null; echo "*/10 * * * * /home/vuno/init/zabbix/FailCount.sh") | crontab -