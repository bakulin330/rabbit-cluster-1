#!/bin/bash

export CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

NET='lpm-network'
NAME="rabbit-haproxy"
TAG='rabbit-haproxy'

docker stop $NAME
docker rm -f $NAME

docker run -d \
	--name $NAME \
	--restart=always \
	--net=$NET \
	--net-alias $NAME \
	$TAG 2>&1

echo '--------------'
docker ps | grep $NAME
echo
echo '[ DONE ]'