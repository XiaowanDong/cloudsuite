#!/usr/local/bin/bash


DB_SERVER_IP=${1:-"mysql_server"}
MEMCACHE_SERVER_IP=${2:-"memcache_server"}
sed -i '' -e"s/mysql_server/${DB_SERVER_IP}/g" /usr/local/www/nginx-dist/html/elgg/engine/settings.php
sed -i '' -e"s/'memcache_server'/'${MEMCACHE_SERVER_IP}'/g" /usr/local/www/nginx-dist/html/elgg/engine/settings.php


FPM_CHILDREN=${3:-80}
echo $FPM_CHILDREN
sed -i '' -e"s/pm.max_children = 5/pm.max_children = ${FPM_CHILDREN}/g" /usr/local/etc/php-fpm.d/www.conf
#sed -i -e"s/pm.max_children = 5/pm.max_children = ${FPM_CHILDREN}/" /etc/php5/fpm/pool.d/www.conf

service php-fpm restart
service nginx restart
bash
