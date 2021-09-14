## Usage : 
```
docker run --env STAC_URL="{$STAC_URL}" -ti gisaia/stac-api-validator:latest
```

## Publish the docker image in DockerHub :
```
docker build -t gisaia/stac-api-validator:x.x.x .
docker tag gisaia/stac-api-validator:x.x.x gisaia/stac-api-validator:latest 
```
```
docker login
```
```
docker push gisaia/stac-api-validator:latest
```