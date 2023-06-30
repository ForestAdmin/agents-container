#!/bin/bash

echo "# Database varialbes" > .env
echo "DATABASE_URL=$1://example:password@127.0.0.1:5443/example" >> .env
echo "DOCKER_DATABASE_URL=$1://example:password@host.docker.internal:5443/example" >> .env

echo "# Docker variables" >> .env
cat .env-template | grep "APPLICATION_PORT" >> .env
echo "DEPENDS_DB=$1" >> .env