## Usage : 
```
docker run --env CSW_GETCAPABILITIES_URL="{$URL_TO_CSW_CAPABILIES}" -ti gisaia/ets-cat30:0.0.1
```

## Publish the docker image in DockerHub :
```
docker build -t gisaia/ets-cat30:x.x.x gisaia/ets-cat30:latest .
```
```
docker login
```
```
docker push gisaia/ets-cat30:latest
```