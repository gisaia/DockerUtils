FROM node:20-alpine

RUN npm install -g widdershins@4.0.1


WORKDIR /ng-app

COPY . .

LABEL com.gisaia.tools.widdershins=4.0.1
LABEL vendor="Gisaïa"
LABEL description="This container build and serve the widdershins app"

ADD entrypoint.sh /opt/

ENTRYPOINT ["sh", "/opt/entrypoint.sh"]
