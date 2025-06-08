#!/bin/bash
WORK_DIR=$(pwd)
rm docker-compose.yml 
cp docker-compose-template.yml docker-compose.yml 

sed -i '' "s#{{WORK_DIR}}#$WORK_DIR#g" docker-compose.yml

docker compose down
docker compose up -d
