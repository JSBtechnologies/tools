#!/bin/bash

DIR="/var/log/httpd-access.log";
DATE=$1;
FLAG=$2

rm /tmp/requests.log;
cat $DIR | grep $DATE >> /tmp/requests.log;
REQUESTS=$(cat /tmp/requests.log | wc -l);

if [ $FLAG = "-d" ]; then
    echo $REQUESTS;
else
    echo "Requests: $REQUESTS on $DATE";
fi
