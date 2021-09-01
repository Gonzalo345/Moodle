#!/bin/bash

docker network create moodle-network

docker volume create --name mariadb_data
docker volume create --name moodle_data

docker run -d --name mariadb \
  --env ALLOW_EMPTY_PASSWORD=yes \
  --env MARIADB_USER=us_onboarding \
  --env MARIADB_PASSWORD=onboarding \
  --env MARIADB_DATABASE=onboarding \
  --network moodle-network \
  --volume mariadb_data:/bitnami/mariadb \
  bitnami/mariadb:latest

IP_MARIADB=`docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mariadb`
./wait-for-it.sh $IP_MARIADB:3306 --timeout=1000 --strict -- echo "mariadb is up"

docker run -it --name moodle \
  -p 80:8080 -p 443:8443 \
  --env ALLOW_EMPTY_PASSWORD=yes \
  --env MOODLE_DATABASE_HOST=mariadb \
  --env MOODLE_DATABASE_PORT_NUMBER=3306 \
  --env MOODLE_DATABASE_USER=us_onboarding \
  --env MOODLE_DATABASE_PASSWORD=onboarding \
  --env MOODLE_DATABASE_NAME=onboarding \
  --network moodle-network \
  --volume moodle_data:/bitnami/moodle \
  bitnami/moodle:latest
