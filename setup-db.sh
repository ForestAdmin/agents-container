#!/bin/bash

echo "DATABASE_URL=$1://example:password@127.0.0.1:5443/example" >> .env
echo "DOCKER_DATABASE_URL=$1://example:password@host.docker.internal:5443/example" >> .env
