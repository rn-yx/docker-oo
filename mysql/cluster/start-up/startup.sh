#!/bin/bash

docker-compose -f docker-compose.yml -p mysql-cluster down || true &&
docker-compose -f docker-compose.yml -p mysql-cluster up -d
