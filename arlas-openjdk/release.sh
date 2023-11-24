#!/bin/bash
set -o errexit -o pipefail

docker pull  gcr.io/distroless/java17-debian12
docker build --no-cache -f Dockerfile-distroless-17 --tag gisaia/arlas-openjdk:17-distroless .
docker push gisaia/arlas-openjdk:17-distroless
