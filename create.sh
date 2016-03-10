#!/bin/bash          
NEWEST_BUILD=$(curl http://$CONSUL_HOST:8500/v1/kv/web/newest_build?raw)
SWARM_MANAGER=$(curl http://$CONSUL_HOST:8500/v1/kv/web/swarm_manager?raw)

echo $NEWEST_BUILD
STR=$(<container.json)
new=`echo $STR | sed s/NEWEST_BUILD/$NEWEST_BUILD/g`
echo $new

echo $new |  curl -vX POST http://$SWARM_MANAGER/containers/create?name= -d @- --header "Content-Type: application/json"

