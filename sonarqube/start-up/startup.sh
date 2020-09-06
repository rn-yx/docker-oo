#!/bin/bash

docker-compose -f docker-compose.yml -p sonarqube down || true &&
docker-compose -f docker-compose.yml -p sonarqube up -d
