#!/bin/bash

set -e

if [ ! -z "$RABBITMQ_ERLANG_COOKIE" ]; then
    echo "$RABBITMQ_ERLANG_COOKIE" > /var/lib/rabbitmq/.erlang.cookie
    chmod 600 /var/lib/rabbitmq/.erlang.cookie
    chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
    echo "COOKIE VAL = "
    cat /var/lib/rabbitmq/.erlang.cookie
    echo "=================="
fi

if [ ! -z "$CLUSTER_WITH" ]; then
    RAM_ARGS=

    if [ ! -z "$RAM_NODE" ]; then
        RAM_ARGS=--ram
    fi

    # Start RMQ from entry point.
    # This will ensure that environment variables passed
    # will be honored
    /usr/local/bin/docker-entrypoint.sh rabbitmq-server -detached

	rabbitmqctl stop_app
	sleep 5s

	rabbitmqctl join_cluster $RAM_ARGS rabbit@$CLUSTER_WITH

	# Stop the entire RMQ server. This is done so that we
    # can attach to it again, but without the -detached flag
    # making it run in the forground
    rabbitmqctl stopoc

    # Wait a while for the app to really stop
    sleep 5s

	# Start it
    /usr/local/bin/docker-entrypoint.sh rabbitmq-server
else
    /usr/local/bin/docker-entrypoint.sh rabbitmq-server
fi
