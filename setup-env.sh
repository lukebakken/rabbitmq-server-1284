#!/usr/bin/env bash

set -o errexit
set -o nounset

for ((i = 0; i < 10; i++))
do
    exch_name="fanout-$i"
    echo -n Declaring exchange $exch_name...
    rabbitmqadmin declare exchange name="$exch_name" type=fanout durable=true
    echo Done.

    for ((j = 0; j < 5; j++))
    do
        q_name="lazy-$i-$j"
        echo -n Declaring queue $q_name...
        rabbitmqadmin declare queue name="$q_name" durable=true
        echo Done.

        echo -n Binding queue $q_name to exchange $exch_name...
        rabbitmqadmin declare binding source="$exch_name" destination="$q_name"
        echo Done.
    done
done

echo -n Declaring lazy policy...
rabbitmqadmin declare policy name=lazy-queues pattern='^lazy-' definition='{"queue-mode":"lazy"}' priority=0 apply-to=queues
echo Done.
