
### STAGE 1: Build ###

# We label our stage as 'builder'
FROM node:8-alpine as builder

COPY ./package.json     ./

RUN npm set progress=false && npm config set depth 0 && npm cache clean --force

RUN npm update

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app

WORKDIR /ng-app

COPY . .

## Add jsonschema2md command line
RUN npm link

LABEL com.gisaia.tools.jsonschema2md=0.1.0
LABEL vendor="Gisaïa"
LABEL description="This container build and serve the jsonschema2md app"

ENTRYPOINT ["./cli.js"]
CMD []

