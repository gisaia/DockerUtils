#!/bin/bash
set -o errexit -o pipefail
docker build  --tag gisaia/lazydocs:$1  --tag gisaia/lazydocs:latest .
docker push gisaia/lazydocs:$1
docker push gisaia/lazydocs:latest
