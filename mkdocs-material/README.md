## Usage :
```
docker run --rm -it -v ${PWD}:/docs gisaia/mkdocs-material ...
```

## Publish the docker image in DockerHub :
```
docker build -t gisaia/mkdocs:1.1.2 -t gisaia/mkdocs:latest .
docker login
docker push gisaia/mkdocs
```
