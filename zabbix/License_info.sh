#!/bin/bash
#

hname=$(sed -n '/Hostname=/p'  /etc/zabbix/zabbix_agentd.conf)
hname=${hname:9}

Today=$(date +%Y%m%d)
Now=$(date +%T)
Logdir=/home/vuno/init/log
Logfile=${Logdir}/License_info_${Today}.log

Select="select '>>>/'||coalesce(expire_date,'9999-12-31')||'/'||credit_total-credit_used from license_data where id=(select max(id) from license_data);"



# Query
rt=$(docker exec -i vuuc_db psql -U vuuc -d vuuc -a -c "$Select" |grep '>>>/[1-9]'|tr -d '\r'|tr -d ' ')
#echo $rt

license_date=$(echo $rt | cut -d '/' -f2)
license_count=$(echo $rt | cut -d '/' -f3)

echo "\"$hname\" \"LicenseCount\" \"$license_count\"" >$Logdir/License_data.txt
echo "\"$hname\" \"LicenseDate\" \"$license_date\"" >>$Logdir/License_data.txt

zabbix_sender -c /etc/zabbix/zabbix_agentd.conf -i /home/vuno/init/log/License_data.txt  