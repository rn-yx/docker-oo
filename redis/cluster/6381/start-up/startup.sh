#!/bin/bash

docker-compose -f docker-compose.yml -p redis-6381 down || true &&
docker-compose -f docker-compose.yml -p redis-6381 up -d
