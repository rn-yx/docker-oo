#!/bin/bash

docker-compose -f docker-compose.yml -p jenkins down || true \
&& docker-compose -f docker-compose.yml -p jenkins up -d

