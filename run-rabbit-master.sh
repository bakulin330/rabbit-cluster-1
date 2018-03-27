#!/bin/bash

export CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ./env.sh

NAME="${MASTER_NODE}"
NET='lpm-network'
TAG='rabbitmq-base'

docker stop $NAME
docker rm -f $NAME

docker run -d \
	--name $NAME \
	--restart=always \
	--net=$NET \
	--net-alias $NAME \
	-e RABBITMQ_ERLANG_COOKIE=$RABBITMQ_ERLANG_COOKIE \
	$TAG 2>&1

echo '--------------'
docker ps | grep $NAME
echo
echo '[ DONE ]'