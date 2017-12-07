#!/usr/bin/env bash

for ((i = 0; i < 10; i++))
do
    echo fanout-$i
    mvn -q exec:java -Dexec.mainClass=com.rabbitmq.perf.PerfTest -Dexec.args="--predeclared --time 120 --exchange fanout-$i --consumers 0 --size 4000 --flag persistent" > "$HOME/issues/rabbitmq/rabbitmq-server/gh-1284/rmq-3.7.0-$i.out" &
done
wait
