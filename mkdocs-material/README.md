## Usage :
```
docker run --rm -it -v ${PWD}:/docs gisaia/mkdocs-material ...
```

## Publish the docker image in DockerHub :
```
export VERSION=2.0.4
docker build --platform "linux/amd64" -t gisaia/mkdocs:$VERSION -t gisaia/mkdocs:latest .
docker login
docker push gisaia/mkdocs:$VERSION
```
