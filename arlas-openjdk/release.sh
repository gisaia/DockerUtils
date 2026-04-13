#!/bin/bash
set -o errexit -o pipefail

VERSION=`date '+%Y%m%d%H%M%S'`
docker build --no-cache -f Dockerfile-distroless-17 --tag gisaia/arlas-openjdk-17-distroless:$VERSION .
docker push gisaia/arlas-openjdk-17-distroless:$VERSION

docker tag gisaia/arlas-openjdk-17-distroless:$VERSION gisaia/arlas-openjdk-17-distroless:latest
docker push gisaia/arlas-openjdk-17-distroless:latest

echo "gisaia/arlas-openjdk-17-distroless:$VERSION released"