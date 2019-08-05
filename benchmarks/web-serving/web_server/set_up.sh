# !/usr/local/bin/bash

#install dependencies
pkg install git

cd /usr/ports/www/nginx 
make BATCH=yes -j8
make install BATCH=yes >& make_log.txt

cd /usr/ports/lang/php72
make BATCH=yes -j8
make install BATCH=yes >& make_log.txt

cd /usr/ports/graphics/php72-gd
make BATCH=yes -j8
make install BATCH=yes >& make_log.txt

cd /usr/ports/databases/php72-mysql
make BATCH=yes -j8
make install BATCH=yes >& make_log.txt

cd /usr/ports/ftp/php72-curl
make BATCH=yes -j8
make install BATCH=yes >& make_log.txt

cd /usr/ports/databases/php-memcache
make BATCH=yes 
make install BATCH=yes >& make_log.txt

cat files/limits.conf.append >> /etc/security/limits.conf  

export ELGG_VERSION="2.3.8"

fetch https://elgg.org/download/elgg-$ELGG_VERSION.zip \
    && unzip elgg-$ELGG_VERSION.zip \
    && mv elgg-$ELGG_VERSION /usr/local/share/nginx/html/elgg \
    && chown -R 777 /usr/local/share/nginx/html/elgg



mkdir -p /usr/local/share/nginx/html/elgg/elgg-config
cp files/settings.php /usr/local/share/nginx/html/elgg/elgg-config/settings.php

mkdir /elgg_data
chmod a+rw /elgg_data

cp /home/xd10/cloudsuite_new/cloudsuite/benchmarks/web-serving/web_server/nginx.conf /usr/local/etc/nginx/nginx.conf
# I have modified one place in the original nginx.conf
# see line 121 to 156 in /home/xd10/cloudsuite_new/cloudsuite/benchmarks/web-serving/web_server/nginx.conf, which is the new content appended to the original nginx.conf

cp  /home/xd10/cloudsuite_new/cloudsuite/benchmarks/web-serving/web_server/www.conf /usr/local/etc/php-fpm.d/www.conf
# I have modified two places in the original www.conf
# (1) change "listen = 127.0.0.1:9000" to "listen = /var/run/php72-fpm.sock"
# (2) Uncomment the following line:
#	listen.owner = www
#	listen.group = www
#	listen.mode = 0660

# Append nginx_enable="YES" to /etc/rc.conf
service nginx restart

mkdir -p /var/run/php
# Append php_fpm_enable="YES" to /etc/rc.conf
service php-fpm restart

#modify the path to bash in the first line of bootstrap.sh 
./bootstrap.sh -d 127.0.0.1 127.0.0.1 80
