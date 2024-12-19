
### STAGE 1: Build ###

# We label our stage as 'builder'
FROM node:18.20.5-alpine as builder

COPY ./package.json     ./

RUN npm set progress=false && npm config set depth 0 && npm cache clean --force

RUN npm update

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app

WORKDIR /ng-app

COPY . .

LABEL com.gisaia.tools.jsonschema2md=8.0.2
LABEL vendor="Gisaïa"
LABEL description="This container build and serve the jsonschema2md app"

ENTRYPOINT ["/bin/sh", "run.sh"]
CMD []
