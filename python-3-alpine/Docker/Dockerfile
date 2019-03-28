FROM python:3-alpine

RUN apk update && \
  apk add bash

ADD configure_user_and_group.bash entrypoint.bash /opt/

WORKDIR /opt/python

ENTRYPOINT ["bash", "/opt/entrypoint.bash"]