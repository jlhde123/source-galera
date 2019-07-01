FROM debian:9

MAINTAINER jlh "472327024@qq.com"

COPY galera.zip /opt/galera.zip
COPY sources.list /etc/apt/sources.list

RUN apt-get update && apt-get build-dep -y  mysql-server \
	&& apt-get install -y vim cmake bison \
	libncurses5-dev libasio-dev check scons libboost-program-options-dev libboost-dev  libssl-dev scons lsof rsync unzip \
	&& cd /opt && unzip galera.zip \
	&& cd /opt/mysql-wsrep-5.6 && cmake -DWITH_WSREP=ON -DWITH_INNODB_DISALLOW_WRITES=ON ./ && make &&  make install \
	&& cd /opt/galera-3.x && scons \
	&& cp /opt/galera-3.x/libgalera_smm.so /usr/lib/ \
	&& rm -rf /opt/galera-3.x && rm -rf /opt/mysql-wsrep-5.6 \
	&& rm -rf /var/lib/apt/lists/*

RUN groupadd mysql && useradd -g mysql mysql &&  mkdir /var/log/mysql && mkdir /var/run/mysqld && chown -R mysql:mysql /var/log/mysql && chown -R mysql:mysql /var/run/mysqld

COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/bin/bash","/opt/entrypoint.sh"]