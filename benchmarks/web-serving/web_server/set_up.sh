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

mkdir -p /usr/share/nginx/html/
cp -r files/elgg_installation /usr/local/share/nginx/html/elgg

mkdir -p /usr/local/share/nginx/html/elgg/engine/
cp files/settings.php /usr/local/share/nginx/html/elgg/engine/

mkdir /elgg_data
chmod a+rw /elgg_data

mkdir -p /usr/local/etc/nginx/sites-available/

#put the content of files/nginx_sites_avail.append before "}" in 
#/usr/local/etc/nginx/nginx.conf


# Append nginx_enable="YES" to /etc/rc.conf
service nginx restart

# Append php_fpm_enable="YES" to /etc/rc.conf
service php-fpm restart

#modify the path to bash in the first line of bootstrap.sh 
./bootstrap.sh -d 127.0.0.1 127.0.0.1 80
