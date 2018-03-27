#!/bin/bash

export CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ./env.sh

NET='lpm-network'
NODE_NUM="${1:-2}"
NAME="rabbit$NODE_NUM"
TAG='rabbitmq-base'

docker stop $NAME
docker rm -f $NAME

docker run -d \
	--name $NAME \
	--restart=always \
	--net=$NET \
	--net-alias $NAME \
	-e RABBITMQ_ERLANG_COOKIE=$RABBITMQ_ERLANG_COOKIE \
	-e CLUSTER_WITH=$MASTER_NODE \
	$TAG 2>&1

echo '--------------'
docker ps | grep $NAME
echo
echo '[ DONE ]'