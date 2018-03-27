#!/bin/bash

./run-haproxy.sh
./run-rabbit-master.sh
./run-rabbit-slave.sh 1
./run-rabbit-slave.sh 2