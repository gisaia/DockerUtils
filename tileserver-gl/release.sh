#!/bin/bash
set -o errexit -o pipefail

git clone -b watch-folder https://github.com/gisaia/tileserver-gl.git /tmp/tileserver-gl

cd /tmp/tileserver-gl

docker build  --tag gisaia/tileserver-gl:$1 .
docker push gisaia/tileserver-gl:$1
docker push gisaia/tileserver-gl:latest
rm -rf /tmp/tileserver-gl