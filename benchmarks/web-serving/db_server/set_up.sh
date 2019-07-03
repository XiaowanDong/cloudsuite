#!/usr/local/bin/bash

#install mysql-server80 and mysql-client80 from the port

# Append mysql_enable="YES" in /etc/rc.conf

# Set password "root" for the user named root
service mysql-server start
mysql_secure_installation

# replace "bind-address = 127.0.0.1" with "bind-address = 0.0.0.0" in /usr/local/etc/mysql/my.cnf

sed -i -e"s/HOST_IP/127.0.0.1:8080/" files/elgg_db.dump
cp files/elgg_db.dump /elgg_db.dump


files/execute_xd.sh root
