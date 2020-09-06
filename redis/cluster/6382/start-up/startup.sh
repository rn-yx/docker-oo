#!/bin/bash

docker-compose -f docker-compose.yml -p redis-6382 down || true &&
docker-compose -f docker-compose.yml -p redis-6382 up -d
