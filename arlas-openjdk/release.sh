#!/bin/bash
set -o errexit -o pipefail

docker build -f Dockerfile-distroless-17 --tag gisaia/arlas-openjdk:17-distroless .
docker push gisaia/arlas-openjdk:17-distroless
