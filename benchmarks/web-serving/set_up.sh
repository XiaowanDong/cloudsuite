#!/usr/local/bin/bash
cd db_server
./set_up.sh

cd ../memcached_server
./set_up.sh

cd ../web_server
./set_up.sh

cd ../faban_client
./set_up.sh
