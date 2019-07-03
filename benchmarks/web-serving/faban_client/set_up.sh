#!/usr/local/bin/bash

fetch http://faban.org/downloads/faban-kit-latest.tar.gz 
tar zxvf faban-kit-latest.tar.gz
cp -r faban /

cp -r files/web20_benchmark /web20_benchmark

cd /web20_benchmark
ant deploy.jar
ant usergen-jar

cp /web20_benchmark/build/Web20Driver.jar /faban/benchmarks/
cp files/usersetup.properties /faban/usersetup.properties

#modify the path to bash in the first line of bootstrap.sh
./bootstrap.sh 127.0.0.1 7
