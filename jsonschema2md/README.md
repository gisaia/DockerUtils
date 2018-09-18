## Usage

 - Place your terminal in the desire folder (where \*.schema.json files can be accessed)
 - Mount the project folder as a volume when you run the docker
 - Use the option `-d` to specify the source folder containing schema.json file
 - Use the option `-o` to specify the output folder
 - Use the option `-x` with value `-` to suppress output of json files


 ```bash
 docker run --rm -v `pwd`:/schema gisaia/jsonschema2md:0.1.1 -d /schema/json -o /schema/out -x -
 ```

## Help

 By running the container without parameters you can see all options availables

 ```bash
 docker run --rm -v `pwd`:/schema gisaia/jsonschema2md:0.1.1
 ```

## Publish the docker image in DockerHub :

 ```
 docker build -t gisaia/jsonschema2md:x.x.x gisaia/jsonschema2md:latest .
 ```
 ```
 docker login
 ```
 ```
 docker push gisaia/jsonschema2md:x.x.x
 docker push gisaia/jsonschema2md:latest
 ```
