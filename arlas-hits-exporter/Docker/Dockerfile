FROM node:8-alpine

RUN apk update && \
  apk add bash && apk add curl && apk add jq

RUN npm install -g json2csv

ADD configure_user_and_group.bash entrypoint.bash export_data.bash /opt/

WORKDIR /output

ENTRYPOINT ["bash", "/opt/entrypoint.bash"]
