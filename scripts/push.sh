#!/bin/bash

DOCKER_PASSWORD=Kjiflrf28@
DOCKER_USERNAME=energystart

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push energystart/zabbix