#!/bin/bash

docker-compose -f docker-compose.yml -p dns down || true \
&& docker-compose -f docker-compose.yml -p dns up -d
