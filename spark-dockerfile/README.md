## Usage :
```
docker run -ti \
       -p "4040:4040" \
       gisaia/spark:latest \
       spark-shell \
       ...
```

## Publish the docker image in DockerHub :
```
docker build -t gisaia/spark:x.x.x -t gisaia/spark:latest .
```
```
docker login
```
```
docker push gisaia/spark
```
