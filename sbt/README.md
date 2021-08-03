## Usage :
```
docker run -ti \
       gisaia/sbt:latest \
       sbt version
```

## Publish the docker image in DockerHub :
```
cd 1.5.5
docker build -t gisaia/sbt:1.5.5_jdk8 -t gisaia/sbt:latest .
docker login
docker push gisaia/sbt
```
