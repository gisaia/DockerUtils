#!/bin/bash
set -o errexit -o pipefail

# generate image for https://github.com/Mermade/widdershins/tags
docker build --no-cache --tag gisaia/widdershins:4.0.1 .
docker push gisaia/widdershins:4.0.1
