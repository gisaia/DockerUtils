## Usage : 
```
docker run --env WFS_GETCAPABILITIES_URL="{$URL_TO_WFS_CAPABILIES}" --env ID="{$ID_OF_A_FEATURE}"  -ti ets-wfs20:0.0.1
```

## Publish the docker image in DockerHub :
```
docker build -t gisaia/ets-wfs20:x.x.x gisaia/ets-wfs20:latest .
```
```
docker login
```
```
docker push gisaia/ets-wfs20:latest
```