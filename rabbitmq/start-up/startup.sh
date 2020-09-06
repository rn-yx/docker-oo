#!/bin/bash

docker-compose -f docker-compose.yml -p rabbitmq down || true &&
docker-compose -f docker-compose.yml -p rabbitmq up -d
