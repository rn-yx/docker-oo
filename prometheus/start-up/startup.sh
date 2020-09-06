#!/bin/bash

docker-compose -f docker-compose.yml -p prometheus down || true &&
docker-compose -f docker-compose.yml -p prometheus up -d
