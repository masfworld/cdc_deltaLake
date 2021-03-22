#!/bin/bash

PUBLIC_DNS=`curl -s http://169.254.169.254/latest/meta-data/public-hostname`
echo $PUBLIC_DNS
export EXTERNAL_IP=$PUBLIC_DNS

docker-compose stop
docker-compose up -d
