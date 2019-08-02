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
# I have modified two places in the original nginx.conf
#(1)change the path in files/nginx_sites_avail.append to be "root /usr/local/share/nginx/html/elgg;" 
#instead of "root /usr/share/nginx/html/elgg;"
#(2)append the conent of files/nginx_sites_avail.append to /usr/local/etc/nginx/nginx.conf 
#before the very last "}"




# Append nginx_enable="YES" to /etc/rc.conf
service nginx restart

mkdir -p /var/run/php
# Append php_fpm_enable="YES" to /etc/rc.conf
service php-fpm restart

#modify the path to bash in the first line of bootstrap.sh 
./bootstrap.sh -d 127.0.0.1 127.0.0.1 80
