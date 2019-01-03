## Usage : 

- Place your terminal in the folder where your tagged typescript files reside : your project folder.
- Every non-native typescript module should be declared in a `package.json` file that is to be placed in the project folder.
- Mount the project folder as a volume into /docs :

```
docker run --rm -it -v `pwd`:/docs gisaia/typedocgen:0.0.5 generatedoc
```

>Most of the time, your project folder contains a node_modules folder that can be source of troubles while generating the documentation.
Please consider in that case applying the following use case:


- If you want to generate documentation from typscript files that are in a specific folder in your project folder :

```
docker run --rm -it -v `pwd`:/docs gisaia/typedocgen:0.0.5 generatedoc relative/path/to/the/specific/folder
```

## Generated documentation :

The markdown files are generated in `typedoc_docs` folder within your project folder.

## Publish the docker image in DockerHub : 

```
docker build -t gisaia/typedocgen:x.x.x gisaia/typedocgen:latest .
```
```
docker login
```
```
docker push gisaia/typedocgen:x.x.x
docker push gisaia/typedocgen:latest
```