#!/bin/bash

if [ -f .env ] ; then
    forest_server_url=$(cat .env | grep "FOREST_SERVER_URL")
    forest_auth_secret=$(cat .env | grep "FOREST_AUTH_SECRET")
    forest_env_secret=$(cat .env | grep "FOREST_ENV_SECRET")
    app_port=$(cat .env | grep "APPLICATION_PORT")
else
    forest_server_url=$(cat .env-template | grep "FOREST_SERVER_URL")
    forest_auth_secret=$(cat .env-template | grep "FOREST_AUTH_SECRET")
    forest_env_secret=$(cat .env-template | grep "FOREST_ENV_SECRET")
    app_port=$(cat .env-template | grep "APPLICATION_PORT")
fi

echo "# Database varialbes" > .env
echo "DATABASE_URL=$1://example:password@127.0.0.1:5443/example" >> .env
echo "DOCKER_DATABASE_URL=$1://example:password@host.docker.internal:5443/example" >> .env

echo "" >> .env
echo "# Docker variables" >> .env
echo $app_port >> .env
echo "DEPENDS_DB=$1" >> .env

echo "" >> .env
echo "# Forest variables" >> .env
echo "$forest_server_url" >> .env
echo "$forest_auth_secret" >> .env
echo "$forest_env_secret" >> .env

