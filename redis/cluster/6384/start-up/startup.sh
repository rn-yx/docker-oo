#!/bin/bash

docker-compose -f docker-compose.yml -p redis-6384 down || true &&
docker-compose -f docker-compose.yml -p redis-6384 up -d
