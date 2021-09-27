#!/bin/bash
set -o errexit -o pipefail

docker build -f Dockerfile-alpine --tag gisaia/arlas-openjdk:8-jre-alpine .
docker push gisaia/arlas-openjdk:8-jre-alpine

docker build -f Dockerfile --tag gisaia/arlas-openjdk:8-bullseye .
docker push gisaia/arlas-openjdk:8-bullseye
