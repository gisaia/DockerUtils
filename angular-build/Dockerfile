FROM node:8-alpine

RUN apk update

RUN npm install -g @angular/cli

ADD env_build.sh /opt/

WORKDIR /output

ENTRYPOINT ["sh", "/opt/env_build.sh"]