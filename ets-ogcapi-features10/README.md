## Usage : 
```
docker run --env STAC_URL="{$STAC_URL}" -ti gisaia/ets-ogcapi-features10:x.x.x
```

## Publish the docker image in DockerHub :
```
docker build -t gisaia/ets-ogcapi-features10:x.x.x .
```
```
docker login
```
```
docker push gisaia/ets-ogcapi-features10:x.x.x
```