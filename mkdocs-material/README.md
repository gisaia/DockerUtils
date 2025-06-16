## Usage :
```
docker run --rm -it -v ${PWD}:/docs gisaia/mkdocs-material ...
```

## Publish the docker image in DockerHub :
```
docker build -t gisaia/mkdocs:2.0.0 -t gisaia/mkdocs:latest .
docker login
docker push gisaia/mkdocs
```
