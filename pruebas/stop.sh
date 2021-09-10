#!/bin/bash


docker rm -f moodle
docker rm -f mariadb

docker network rm moodle-network
docker volume rm mariadb_data
docker volume rm moodle_data
