#!/bin/bash

docker-compose -f docker-compose.yml -p mysql down || true &&
docker-compose -f docker-compose.yml -p mysql up -d
