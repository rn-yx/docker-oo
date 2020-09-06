#!/bin/bash

docker-compose -f docker-compose.yml -p redis-6383 down || true &&
docker-compose -f docker-compose.yml -p redis-6383 up -d
