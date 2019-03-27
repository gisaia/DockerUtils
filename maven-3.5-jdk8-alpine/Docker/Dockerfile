FROM maven:3.5-jdk-8-alpine

RUN apk update && \
  apk add bash

ADD configure_user_and_group.bash entrypoint.bash /opt/
ADD settings.xml /usr/share/maven/conf/custom_settings.xml

WORKDIR /opt/maven

ENTRYPOINT ["bash", "/opt/entrypoint.bash"]