#!/bin/bash

docker-compose -f docker-compose.yml -p redis-6380 down || true &&
docker-compose -f docker-compose.yml -p redis-6380 up -d
