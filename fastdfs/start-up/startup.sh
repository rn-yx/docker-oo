#!/bin/bash

docker-compose -f docker-compose.yml  down || true \
&& docker-compose -f docker-compose.yml up -d

