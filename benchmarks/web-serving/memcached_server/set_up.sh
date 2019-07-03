# !/usr/local/bin/bash

#memcached -d -u root -m 65535 -t 4
memcached -vv -u root -m 65535 -t 4 &
