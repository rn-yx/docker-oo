#!/bin/bash

docker-compose -f docker-compose.yml -p gitlab down || true \
&& docker-compose -f docker-compose.yml -p gitlab up -d

