#!/bin/bash

isNew='true'
command="/usr/local/mysql/bin/mysqld --defaults-file=/usr/local/mysql/my.cnf --user=mysql"

if [ "`ls -A /usr/local/mysql/data`" = "" ] 
then 
	echo 'mysql has not init'
	cd /usr/local/mysql && ./scripts/mysql_install_db --user=mysql
else
	echo 'mysql inited'
fi

if [ -d "/opt/clusterFolder" ] 
then 
	echo 'cluster inited'
	isNew='false'
else
	echo 'new cluster'
	mkdir /opt/clusterFolder
fi

if [ $1 ]&&[ $1 == 'initCluster' ]&&[ $isNew == 'true' ]
then
	echo 'initCluster'
	command="${command} --wsrep-new-cluster"
elif [ $1 ]&&[ $1 == 'initNode' ]&&[ $isNew == 'true' ]
then
	echo "initNode"
fi

chown -R mysql:mysql /usr/local/mysql
chown -R mysql:mysql /var/log/mysql

$command
