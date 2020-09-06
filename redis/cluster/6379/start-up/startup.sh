#!/bin/bash

docker-compose -f docker-compose.yml -p redis-6379 down || true &&
docker-compose -f docker-compose.yml -p redis-6379 up -d
