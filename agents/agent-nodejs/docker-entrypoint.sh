#!/bin/sh
# set -eux

# ugly hack to make custom forest_admin_server_url to be resolve as docker host
if [ $FOREST_SERVER_URL != "https://api.forestadmin.com" ]
then
    forest_addr=$(echo $FOREST_SERVER_URL | cut -d"/" -f3)
    addr=$(ping -c1 host.docker.internal | sed -n "2p" | cut -d':' -f1 | cut -d" " -f4)
    echo "$addr  $forest_addr" >> /etc/hosts
fi


exec "$@"
