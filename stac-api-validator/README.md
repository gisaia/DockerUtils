## Usage : 
```
docker run --env STAC_URL="{$STAC_URL}" --env STAC_COLLECTION="{$STAC_COLLECTION}" -ti gisaia/stac-api-validator:x.x.x 
```

## Publish the docker image in DockerHub :
```
docker build -t gisaia/stac-api-validator:x.x.x .
docker tag gisaia/stac-api-validator:x.x.x 
```
```
docker login
```
```
docker push gisaia/stac-api-validator:x.x.x
```