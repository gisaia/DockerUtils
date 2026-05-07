#!/bin/bash
#You need to be login in dhi.io before run
set -o errexit -o pipefail

VERSION=`date '+%Y%m%d%H%M%S'`
docker build --no-cache -f Dockerfile-dhi-17 --tag gisaia/arlas-openjdk-17-dhi:$VERSION .
docker push gisaia/arlas-openjdk-17-dhi:$VERSION

docker tag gisaia/arlas-openjdk-17-dhi:$VERSION gisaia/arlas-openjdk-17-dhi:latest
docker push gisaia/arlas-openjdk-17-dhi:latest

echo "gisaia/arlas-openjdk-17-dhi:$VERSION released"